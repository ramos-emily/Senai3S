from django.db import models
from django.utils import timezone

# Modelo de usuário
class Usuario(models.Model):
    id = models.AutoField(primary_key=True)
    nome = models.CharField(max_length=250) 
    email = models.EmailField(unique=True)

    def __str__(self):
        return self.nome


class Tarefa(models.Model):

    PRIORIDADES_CHOICES = [
        ('baixo', 'Baixo'),
        ('medio', 'Médio'),
        ('alto', 'Alto'),
    ]

    STATUS_CHOICES = [
        ('a_fazer', 'A fazer'),
        ('fazendo', 'Fazendo'), 
        ('concluido', 'Concluído'),
    ]

    id = models.AutoField(primary_key=True)
    usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    descricao = models.CharField(max_length=250)
    setor = models.CharField(max_length=250)
    prioridade = models.CharField(max_length=10, choices=PRIORIDADES_CHOICES, default='baixo')
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='a_fazer')
    data_criacao = models.DateTimeField(default=timezone.now)

    def __str__(self):
        return f"{self.descricao} ({self.get_status_display()})"
