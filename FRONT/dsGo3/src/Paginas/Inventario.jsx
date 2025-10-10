import { useEffect, useState } from "react";

export function Inventario() {
  const [figurinhas, setFigurinhas] = useState([]);

  useEffect(() => {
    const armazenado = JSON.parse(localStorage.getItem("inventario")) || [];
    setFigurinhas(armazenado);
  }, []);

  const limparInventario = () => {
    if (!window.confirm("Deseja realmente limpar o inventário?")) return;
    localStorage.removeItem("inventario");
    setFigurinhas([]);
  };

  return (
    <main className="conteiner" aria-labelledby="titulo-inventario">
      <section className="inventario">
        <h2 id="titulo-inventario">Inventário</h2>

        <button 
          className="limpar-inventario" 
          onClick={limparInventario}
          aria-label="Limpar todo o inventário"
        >
          Limpar Inventário
        </button>

        {figurinhas.length === 0 ? (
          <p className="vazio">Nenhuma figurinha coletada ainda!</p>
        ) : (
          <div 
            className="grid" 
            role="list" 
            aria-label="Lista de figurinhas coletadas"
          >
            {figurinhas.map((f) => (
              <div 
                key={f.id} 
                className="figurinha" 
                role="listitem"
                aria-label={`Figurinha ${f.nome}`}
              >
                <img src={f.imagem} alt={`Figurinha: ${f.nome}`} />
              </div>
            ))}
          </div>
        )}
      </section>
    </main>
  );
}
