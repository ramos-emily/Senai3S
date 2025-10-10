import { useState } from "react";
import sucesso from "../assets/win.png";
import erro from "../assets/raios.png";

export function MissaoModal({ missao, onClose, onConcluir }) {
  const [resposta, setResposta] = useState("");
  const [resultado, setResultado] = useState(null);
  const [status, setStatus] = useState(null);

  const verificarResposta = () => {
    if (!resposta.trim()) {
      alert("Por favor, digite uma resposta antes de enviar!");
      return;
    }

    if (
      resposta.trim().toLowerCase() ===
      missao.respostaCorreta.trim().toLowerCase()
    ) {
      setResultado("Resposta correta! Parabéns!");
      setStatus("sucesso");
      setTimeout(() => {
        onConcluir(missao.id);
      }, 1000);
    } else {
      setResultado("Resposta incorreta. Tente novamente!");
      setStatus("erro");
    }
  };

  return (
    <dialog 
      open 
      className="modal" 
      role="dialog" 
      aria-modal="true" 
      aria-labelledby="titulo-missao" 
      aria-describedby="descricao-missao"
    >
      <h2 className="titulo" id="titulo-missao">
        {missao.titulo}
      </h2>

      <p id="descricao-missao">{missao.descricao}</p>

      <label htmlFor="resposta" className="sr-only">
        Resposta da missão
      </label>
      <input
        className="caixaTexto"
        id="resposta"
        type="text"
        placeholder="Digite sua resposta..."
        value={resposta}
        onChange={(e) => setResposta(e.target.value)}
        required
        aria-required="true"
      />

      <div className="modal-botoes">
        <button onClick={verificarResposta}>Enviar</button>
        <button onClick={onClose}>Fechar</button>
      </div>

      {resultado && (
        <div 
          className="resultado" 
          role="status" 
          aria-live="polite"
        >
          <p>{resultado}</p>
          {status === "sucesso" && (
            <img
              src={sucesso}
              alt="Missão concluída com sucesso"
              width="100"
            />
          )}
          {status === "erro" && (
            <img
              src={erro}
              alt="Resposta incorreta"
              width="100"
            />
          )}
        </div>
      )}
    </dialog>
  );
}
