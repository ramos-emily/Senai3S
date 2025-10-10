export function MissaoCard({ missao, onIniciarMissao, concluida }) {
  return (
    <article 
      className="missao-card" 
      aria-labelledby={`titulo-${missao.id}`} 
      aria-describedby={`descricao-${missao.id}`}
    >
      <h3 id={`titulo-${missao.id}`}>{missao.titulo}</h3>
      <p id={`descricao-${missao.id}`}>{missao.missao}</p>
      <button
        onClick={() => onIniciarMissao(missao)}
        disabled={concluida}
        aria-disabled={concluida}
        aria-label={concluida ? "Missão já concluída" : "Iniciar missão"}
      >
        {concluida ? "Missão concluída" : "Iniciar Missão"}
      </button>
    </article>
  );
}
