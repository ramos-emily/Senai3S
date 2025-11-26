export function MissaoCard({ missao, onIniciarMissao, concluida }) {
  const inventario = JSON.parse(localStorage.getItem("inventario")) || [];
  const concluidaLocal = inventario.some((f) => f.id === missao.id);
  const isConcluida = concluida !== undefined ? concluida : concluidaLocal;

  return (
    <article 
      className="missao-card"
      tabIndex="0"
      aria-labelledby={`missao-titulo-${missao.id}`}
    >
      <div className="missao-conteudo">
        <h3 id={`missao-titulo-${missao.id}`} className="conteudo">
          {missao.titulo}
        </h3>

        <p>{missao.missao}</p>

        <button 
          className="button"
          onClick={() => onIniciarMissao(missao)} 
          disabled={isConcluida}
          aria-disabled={isConcluida}
        >
          {isConcluida ? "Concluída" : "Iniciar Missão"}
        </button>
      </div>
    </article>
  );
}