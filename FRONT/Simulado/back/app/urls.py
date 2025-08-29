from django.urls import path
from .views import UsuarioListarCriar, TarefaAlterarDeletar, TarefaListarCriar

urlpatterns = [
    path('usuarios/', UsuarioListarCriar.as_view()),
    path('tarefa/', TarefaListarCriar.as_view()),
    path('tarefa/<int:pk>/', TarefaAlterarDeletar.as_view())
]