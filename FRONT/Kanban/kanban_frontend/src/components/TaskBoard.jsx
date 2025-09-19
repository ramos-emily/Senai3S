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

// Componente DroppableColumn
const DroppableColumn = ({ id, title, tasks, onEdit, onDelete }) => {
  const { setNodeRef, isOver } = useDroppable({
    id: id,
  });

  return (
    <div className="task-board__column">
      <h3 className="task-board__column-title">{title}</h3>
      <div 
        ref={setNodeRef}
        className={`task-board__tasks ${isOver ? 'task-board__tasks--over' : ''}`}
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
      </div>
    </div>
  );
};

// Componente SortableTask
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
    opacity: isDragging ? 0.8 : 1,
    scale: isDragging ? 0.95 : 1,
  };

  return (
    <div
      ref={setNodeRef}
      style={style}
      className={`task-card ${isDragging ? 'task-card--dragging' : ''}`}
      {...attributes}
      {...listeners}
    >
      <div className="task-card__content">
        <p className="task-card__description">{task.descricao}</p>
        <div className="task-card__details">
          <span className="task-card__detail">Setor: {task.setor}</span>
          <span className={`task-card__priority task-card__priority--${task.prioridade}`}>
            Prioridade: {task.prioridade}
          </span>
          <span className="task-card__detail">Vinculado a: {task.usuario_object?.nome}</span>
          <span className="task-card__status">Status: {getStatusLabel(task.status)}</span>
        </div>
      </div>
      <div className="task-card__actions">
        <button 
          className="task-card__btn task-card__btn--edit"
          onClick={(e) => {
            e.stopPropagation();
            onEdit(task);
          }}
        >
          Editar
        </button>
        <button 
          className="task-card__btn task-card__btn--delete"
          onClick={(e) => {
            e.stopPropagation();
            onDelete(task);
          }}
        >
          Excluir
        </button>
      </div>
    </div>
  );
};

// Função auxiliar para mostrar o status em português
const getStatusLabel = (status) => {
  const statusLabels = {
    'a_fazer': 'A Fazer',
    'fazendo': 'Fazendo',
    'pronto': 'Pronto'
  };
  return statusLabels[status] || status;
};

// Componente TaskCard para o overlay de arrasto
const TaskCardOverlay = ({ task }) => (
  <div className="task-card task-card--dragging">
    <div className="task-card__content">
      <p className="task-card__description">{task.descricao}</p>
      <div className="task-card__details">
        <span className="task-card__detail">Setor: {task.setor}</span>
        <span className={`task-card__priority task-card__priority--${task.prioridade}`}>
          Prioridade: {task.prioridade}
        </span>
        <span className="task-card__detail">Vinculado a: {task.usuario_object?.nome}</span>
        <span className="task-card__status">Status: {getStatusLabel(task.status)}</span>
      </div>
    </div>
  </div>
);

// Componente principal TaskBoard
const TaskBoard = () => {
  const [tasks, setTasks] = useState([]);
  const [editingTask, setEditingTask] = useState(null);
  const [showForm, setShowForm] = useState(false);
  const [activeTask, setActiveTask] = useState(null);

  // Configuração dos sensores
  const sensors = useSensors(
    useSensor(PointerSensor, {
      activationConstraint: {
        distance: 8, // 8px de movimento antes de iniciar o drag
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
    if (window.confirm('Tem certeza que deseja excluir esta tarefa?')) {
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

    // Verifica se o destino é uma das colunas válidas
    const validStatuses = ['a_fazer', 'fazendo', 'pronto'];
    
    if (validStatuses.includes(newStatus)) {
      // Mudança de coluna (status)
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
        console.error('Erro ao atualizar status via drag and drop:', error);
      }
    } else {
      // Reordenamento dentro da mesma coluna
      // Neste caso, não precisamos fazer nada no backend já que é apenas reordenamento visual
      // Mas podemos atualizar o estado local se quisermos
    }
  };

  if (showForm) {
    return (
      <TaskForm 
        editingTask={editingTask} 
        onSaveComplete={handleSaveComplete} 
      />
    );
  }

  const tasksByStatus = {
    a_fazer: tasks.filter(task => task.status === 'a_fazer'),
    fazendo: tasks.filter(task => task.status === 'fazendo'),
    pronto: tasks.filter(task => task.status === 'pronto')
  };

  const columns = [
    { id: 'a_fazer', title: 'A Fazer', tasks: tasksByStatus.a_fazer },
    { id: 'fazendo', title: 'Fazendo', tasks: tasksByStatus.fazendo },
    { id: 'pronto', title: 'Pronto', tasks: tasksByStatus.pronto }
  ];

  return (
    <DndContext
      sensors={sensors}
      collisionDetection={closestCenter}
      onDragStart={handleDragStart}
      onDragEnd={handleDragEnd}
    >
      <div className="task-board">
        <h2 className="task-board__title">Quadro de Tarefas</h2>
        
        <div className="task-board__columns">
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
      </div>

      <DragOverlay adjustScale={false}>
        {activeTask ? (
          <TaskCardOverlay task={activeTask} />
        ) : null}
      </DragOverlay>
    </DndContext>
  );
};

export default TaskBoard;