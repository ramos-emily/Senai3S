from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView
from .models import Usuario, Tarefa
from .serializer import TarefaSerializer, UsuarioSerializer


class UsuarioListCreateAPIView(ListCreateAPIView):
    queryset = Usuario.objects.all()
    serializer_class = UsuarioSerializer

    def get_queryset(self):
        queryset = super().get_queryset()
        nome = self.request.query_params.get('nome')
        serie = self.request.query_params.get('serie')

        if nome:
            queryset = queryset.filter(nome__icontains=nome)
        if serie:
            queryset = queryset.filter(serie__icontains=serie)
        return queryset


class TarefaListCreateAPIView(ListCreateAPIView):
    queryset = Tarefa.objects.all()
    serializer_class = TarefaSerializer

    def get_queryset(self):
        queryset = super().get_queryset()
        nome = self.request.query_params.get('nome')
        serie = self.request.query_params.get('serie')

        if nome:
            queryset = queryset.filter(nome__icontains=nome)
        if serie:
            queryset = queryset.filter(serie__icontains=serie)
        return queryset


class TarefaRetrieveUpdateDestroyAPIView(RetrieveUpdateDestroyAPIView):
    queryset = Tarefa.objects.all()
    serializer_class = TarefaSerializer
    lookup_field = 'pk'
