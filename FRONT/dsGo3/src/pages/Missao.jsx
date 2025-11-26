import { useState } from "react";
import { missoes } from '../data/dadosMissao';
import { MissaoCard } from '../components/MissaoCard';
import { MissaoModal } from '../components/MissaoModal';

export default function Missao() {
  const [missaoSelecionada, setMissaoSelecionada] = useState(null);
  const [refresh, setRefresh] = useState(0);

  const concluirMissao = (id) => {
    const inventario = JSON.parse(localStorage.getItem("inventario")) || [];


    const m = missoes.find((ms) => ms.id === id);

    const figurinha = {
      id: m.id,
      nome: m.titulo || `Figurinha ${m.id}`,
      imagem: m.figura || "/src/assets/mandouBem.png",
    };

    // Evita duplicar a mesma figurinha
    if (!inventario.some((f) => f.id === id)) {
      inventario.push(figurinha);
      localStorage.setItem("inventario", JSON.stringify(inventario));
    }

    // Fecha modal
    setMissaoSelecionada(null);
    setRefresh((r) => r + 1);
  };


  return (
    <section className='conteiner'>
      <h2>Missões</h2>
      <div className="missoes-grid">
        {missoes.map((m) => (
          <MissaoCard
            key={`${m.id}-${refresh}`} 
            missao={m}  
            onIniciarMissao={setMissaoSelecionada} 

          />
        ))}
      </div>

      {missaoSelecionada && (
        <MissaoModal 
          missao={missaoSelecionada} 
          onClose={() => setMissaoSelecionada(null)} 
          onConcluir={concluirMissao} 
        />
      )}
    </section>
  );
}
