from django.shortcuts import render
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView
from .models import Tarefa, Usuarios
from .serializes import TarefaSerializes, UsuariosSerializes

class UsuarioListarCriar(ListCreateAPIView):
    queryset = Usuarios.objects.all()
    serializer_class = UsuariosSerializes


class TarefaListarCriar(ListCreateAPIView):
    queryset = Tarefa.objects.all()
    serializer_class = TarefaSerializes
    
class TarefaAlterarDeletar(RetrieveUpdateDestroyAPIView):
    queryset = Tarefa.objects.all()
    serializer_class = TarefaSerializes
    lookup_field = 'pk'
    