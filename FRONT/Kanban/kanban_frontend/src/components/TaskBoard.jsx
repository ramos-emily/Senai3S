import React, { useState, useEffect } from 'react';
import {
  DndContext,
  closestCenter,
  KeyboardSensor,
  PointerSensor,
  useSensor,
  useSensors,
  DragOverlay,
  useDroppable
} from '@dnd-kit/core';
import {
  SortableContext,
  verticalListSortingStrategy,
  arrayMove,
} from '@dnd-kit/sortable';
import {
  useSortable,
} from '@dnd-kit/sortable';
import { CSS } from '@dnd-kit/utilities';
import TaskForm from './TaskForm';
import { taskService } from '../services/api';
import '../styles/main.scss';

// Componente DroppableColumn redesenhado
const DroppableColumn = ({ id, title, tasks, onEdit, onDelete }) => {
  const { setNodeRef, isOver } = useDroppable({
    id: id,
  });

  const getColumnTheme = (columnId) => {
    switch(columnId) {
      case 'a_fazer': return { bg: '#FFF3E0'};
      case 'fazendo': return { bg: '#E8F5E9'};
      case 'pronto': return { bg: '#E3F2FD'};
      default: return { bg: '#F5F5F6'};
    }
  };

  const theme = getColumnTheme(id);

  return (
    <div className="kanban-column" style={{ borderColor: theme.border }}>
      <div className="kanban-column__header">
        <h3 className="kanban-column__title">{title}</h3>
      </div>
      
      <div 
        ref={setNodeRef}
        className={`kanban-column__tasks ${isOver ? 'kanban-column__tasks--over' : ''}`}
        style={{ backgroundColor: theme.bg }}
        id={id}
      >
        <SortableContext 
          items={tasks.map(task => task.id)} 
          strategy={verticalListSortingStrategy}
        >
          {tasks.map((task) => (
            <SortableTask
              key={task.id}
              task={task}
              onEdit={onEdit}
              onDelete={onDelete}
            />
          ))}
        </SortableContext>
        
        {tasks.length === 0 && (
          <div className="kanban-column__empty">
            <span>Nenhuma tarefa aqui</span>
          </div>
        )}
      </div>
    </div>
  );
};


const SortableTask = ({ task, onEdit, onDelete }) => {
  const {
    attributes,
    listeners,
    setNodeRef,
    transform,
    transition,
    isDragging,
  } = useSortable({ id: task.id });

  const style = {
    transform: CSS.Transform.toString(transform),
    transition: isDragging ? 'none' : transition,
    opacity: isDragging ? 0.6 : 1,
    scale: isDragging ? 1.02 : 1,
  };



  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString('pt-BR');
  };

  return (
    <div
      ref={setNodeRef}
      style={style}
      className={`task-card ${isDragging ? 'task-card--dragging' : ''}`}
      {...attributes}
      {...listeners}
    >
      <div className="task-card__header">
        <div className="task-card__priority" style={{ backgroundColor: getPriorityColor(task.prioridade) }}>
          {task.prioridade}
        </div>
        <div className="task-card__actions">
          <button 
            className="task-card__btn"
            onClick={(e) => {
              e.stopPropagation();
              onEdit(task);
            }}
            title="Editar tarefa"
          >
            Editar
          </button>
          <button 
            className="task-card__btn"
            onClick={(e) => {
              e.stopPropagation();
              onDelete(task);
            }}
            title="Excluir tarefa"
          >
            Excluir
          </button>
        </div>
      </div>
      
      <div className="task-card__content">
        <p className="task-card__description">{task.descricao}</p>
        
        <div className="task-card__meta">
          <div className="task-card__meta-item">
            <span className="task-card__meta-label">Setor</span>
            <span className="task-card__meta-value">{task.setor}</span>
          </div>
          
          <div className="task-card__meta-item">
            <span className="task-card__meta-label">Responsável</span>
            <span className="task-card__meta-value">{task.usuario_object?.nome || 'Não atribuído'}</span>
          </div>
          
          {task.data_limite && (
            <div className="task-card__meta-item">
              <span className="task-card__meta-label">Prazo</span>
              <span className="task-card__meta-value">{formatDate(task.data_limite)}</span>
            </div>
          )}
        </div>
      </div>
      
      <div className="task-card__footer">
        <span className="task-card__status">{getStatusLabel(task.status)}</span>
        {task.data_criacao && (
          <span className="task-card__date">Criado em {formatDate(task.data_criacao)}</span>
        )}
      </div>
    </div>
  );
};

// Componente TaskCard para o overlay de arrasto
const TaskCardOverlay = ({ task }) => (
  <div className="task-card task-card--dragging task-card--overlay">
    <div className="task-card__header">
      <div className="task-card__priority" style={{ 
        backgroundColor: getPriorityColor(task.prioridade) 
      }}>
        {task.prioridade}
      </div>
    </div>
    <div className="task-card__content">
      <p className="task-card__description">{task.descricao}</p>
    </div>
  </div>
);

// Função auxiliar para mostrar o status em português
const getStatusLabel = (status) => {
  const statusLabels = {
    'a_fazer': 'A Fazer',
    'fazendo': 'Em Andamento',
    'pronto': 'Concluído'
  };
  return statusLabels[status] || status;
};

const getPriorityColor = (priority) => {
  switch(priority) {
    case 'alta': return '#D32F2F';
    case 'media': return '#FFA000';
    case 'baixa': return '#4CAF50';
    default: return '#757575';
  }
};


const TaskBoard = () => {
  const [tasks, setTasks] = useState([]);
  const [editingTask, setEditingTask] = useState(null);
  const [showForm, setShowForm] = useState(false);
  const [activeTask, setActiveTask] = useState(null);
  const [filter, setFilter] = useState('all');
  const [searchTerm, setSearchTerm] = useState('');


  const sensors = useSensors(
    useSensor(PointerSensor, {
      activationConstraint: {
        distance: 5,
      },
    }),
    useSensor(KeyboardSensor)
  );

  useEffect(() => {
    fetchTasks();
  }, []);

  const fetchTasks = async () => {
    try {
      const response = await taskService.getAll();
      setTasks(response.data);
    } catch (error) {
      console.error('Erro ao carregar tarefas:', error);
    }
  };

  const handleEdit = (task) => {
    setEditingTask(task);
    setShowForm(true);
  };

  const handleDelete = async (task) => {
    if (window.confirm(`Tem certeza que deseja excluir a tarefa "${task.descricao}"?`)) {
      try {
        await taskService.delete(task.id);
        fetchTasks();
      } catch (error) {
        console.error('Erro ao excluir tarefa:', error);
      }
    }
  };

  const handleSaveComplete = () => {
    setShowForm(false);
    setEditingTask(null);
    fetchTasks();
  };

  const handleDragStart = (event) => {
    const { active } = event;
    const task = tasks.find(t => t.id === active.id);
    setActiveTask(task);
  };

  const handleDragEnd = async (event) => {
    const { active, over } = event;
    setActiveTask(null);

    if (!over) return;

    const taskId = active.id;
    const newStatus = over.id.toString();
    const validStatuses = ['a_fazer', 'fazendo', 'pronto'];
    
    if (validStatuses.includes(newStatus)) {
      try {
        const taskToUpdate = tasks.find(task => task.id === taskId);
        if (taskToUpdate && taskToUpdate.status !== newStatus) {
          await taskService.update(taskToUpdate.id, { 
            ...taskToUpdate, 
            status: newStatus 
          });
          fetchTasks();
        }
      } catch (error) {
        console.error('Erro ao atualizar status:', error);
      }
    }
  };


  const filteredTasks = tasks.filter(task => {
    const matchesFilter = filter === 'all' || task.prioridade === filter;
    const matchesSearch = task.descricao.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         task.setor.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         (task.usuario_object?.nome || '').toLowerCase().includes(searchTerm.toLowerCase());
    return matchesFilter && matchesSearch;
  });

  const tasksByStatus = {
    a_fazer: filteredTasks.filter(task => task.status === 'a_fazer'),
    fazendo: filteredTasks.filter(task => task.status === 'fazendo'),
    pronto: filteredTasks.filter(task => task.status === 'pronto')
  };

  const columns = [
    { id: 'a_fazer', title: 'A Fazer', tasks: tasksByStatus.a_fazer },
    { id: 'fazendo', title: 'Em Andamento', tasks: tasksByStatus.fazendo },
    { id: 'pronto', title: 'Concluído', tasks: tasksByStatus.pronto }
  ];

  if (showForm) {
    return (
      <TaskForm 
        editingTask={editingTask} 
        onSaveComplete={handleSaveComplete} 
      />
    );
  }

  return (
    <div className="kanban-container">
      {/* Header do Kanban */}
      <div className="kanban-header">
        <div className="kanban-header__left">
          <h1 className="kanban-header__title"> Quadro de Tarefas</h1>
        </div>
      </div>

      {/* Estatísticas */}
      <div className="kanban-stats">
        <div className="stat-card">
          <span className="stat-card__number">{tasks.length}</span>
          <span className="stat-card__label">Total</span>
        </div>
        <div className="stat-card">
          <span className="stat-card__number">{tasksByStatus.a_fazer.length}</span>
          <span className="stat-card__label">A Fazer</span>
        </div>
        <div className="stat-card">
          <span className="stat-card__number">{tasksByStatus.fazendo.length}</span>
          <span className="stat-card__label">Em Andamento</span>
        </div>
        <div className="stat-card">
          <span className="stat-card__number">{tasksByStatus.pronto.length}</span>
          <span className="stat-card__label">Concluídas</span>
        </div>
      </div>

      {/* Quadro Kanban */}
      <DndContext
        sensors={sensors}
        collisionDetection={closestCenter}
        onDragStart={handleDragStart}
        onDragEnd={handleDragEnd}
      >
        <div className="kanban-board">
          {columns.map(column => (
            <DroppableColumn
              key={column.id}
              id={column.id}
              title={column.title}
              tasks={column.tasks}
              onEdit={handleEdit}
              onDelete={handleDelete}
            />
          ))}
        </div>

        <DragOverlay adjustScale={false}>
          {activeTask ? (
            <TaskCardOverlay task={activeTask} />
          ) : null}
        </DragOverlay>
      </DndContext>
    </div>
  );
};

export default TaskBoard;