from rest_framework import serializers
from .models import Tarefa, Usuarios


class UsuariosSerializes(serializers.ModelSerializer):
    class Meta:
        model = Usuarios
        fields = ['nome', 'email']

class TarefaSerializes(serializers.ModelSerializer):
    class Meta:
        model = Tarefa
        fields = ['idTarefa', 'descricao', 'setor', 'prioridade', 'data', 'status', 'usuario']
