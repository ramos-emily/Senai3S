from django.db import models

class Usuarios(models.Model):
    idUsuario = models.IntegerField()
    nome = models.CharField(max_length=50)
    email = models.EmailField()

    def __str__(self):
        return self.nome
    
class Tarefa(models.Model):
    
    choices_prioridade = [("baixa", "baixa"), ("media", "media"), ("alta", "alta")]
    
    choices_status = [("feito", "feito"), ("fazendo", "fazendo"), ("aFazer", "a fazer")]
    
    idTarefa = models.IntegerField()
    descricao = models.TextField()
    setor  = models.CharField(max_length=50)
    prioridade = models.CharField(max_length=10, choices = choices_prioridade)
    data = models.DateField()
    status = models.CharField(max_length=10, choices= choices_status)
    usuario = models.ForeignKey(Usuarios, on_delete=models.CASCADE)

    def __str__(self):
        return self.descricao
