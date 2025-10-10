import { useState } from "react";
import { missoes } from '../Dados/dadosMissao';
import { MissaoCard } from '../Componentes/MissaoCard';
import { MissaoModal } from '../Componentes/MissaoModal';

export function Missao() {
  const [missaoSelecionada, setMissaoSelecionada] = useState(null);
  const [missoesConcluidas, setMissoesConcluidas] = useState([]);

  const concluirMissao = (id) => {
    setMissoesConcluidas((prev) => [...prev, id]);
    setMissaoSelecionada(null);
  };

  return (
    <section 
      className="conteiner" 
      aria-labelledby="titulo-missoes" 
      role="region"
    >
      <h2 id="titulo-missoes">Missões</h2>

      <div 
        className="missoes-grid" 
        role="list" 
        aria-label="Lista de missões disponíveis"
      >
        {missoes.map((m) => (
          <div key={m.id} role="listitem">
            <MissaoCard
              missao={m}
              onIniciarMissao={setMissaoSelecionada}
              concluida={missoesConcluidas.includes(m.id)}
            />
          </div>
        ))}
      </div>

      {missaoSelecionada && (
        <MissaoModal
          missao={missaoSelecionada}
          onClose={() => setMissaoSelecionada(null)}
          onConcluir={() => concluirMissao(missaoSelecionada.id)}
        />
      )}
    </section>
  );
}
