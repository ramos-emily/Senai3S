from django.urls import path
from .views import (
    UsuarioListCreateAPIView,
    TarefaListCreateAPIView,
    TarefaRetrieveUpdateDestroyAPIView,
)

urlpatterns = [
    # Usuários
    path("usuarios/", UsuarioListCreateAPIView.as_view(), name="usuario-list-create"),

    # Tarefas (listar/criar)
    path("tarefas/", TarefaListCreateAPIView.as_view(), name="tarefa-list-create"),

    # Tarefa por ID (detalhe, atualizar, deletar)
    path("tarefas/<int:pk>/", TarefaRetrieveUpdateDestroyAPIView.as_view(), name="tarefa-detail"),
]
