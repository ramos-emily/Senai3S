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
    <dialog open className="modal w-[90%] md:max-w-md" aria-labelledby="titulo-missao" aria-describedby="descricao-missao">
      <h2 className="titulo text-lg sm:text-xl md:text-2xl" id="titulo-missao">
        {missao.titulo}
      </h2>
      
      <p id="descricao-missao" className="my-4 text-sm">
        {missao.descricao}
      </p>

      <label htmlFor="resposta" className="sr-only sm:text-1">
        Digite sua resposta
      </label>
      <input
        className="caixaTexto w-full"
        id="resposta"
        type="text"
        placeholder="Digite aqui"
        value={resposta}
        onChange={(e) => setResposta(e.target.value)}
        required
      />
      
      <div className="modal-botoes mt-4 flex flex-col gap-2 sm:flex-row-reverse">
        <button onClick={verificarResposta} className="w-full sm:w-auto text-sm md:text-base">Enviar</button>
        <button onClick={onClose} className="w-full sm:w-auto text-sm md:text-base">Fechar</button>
      </div>

      {resultado && (
        <div className="resultado mt-4 flex flex-col items-center gap-2" role="alert">
          <p className="text-sm md:text-base">{resultado}</p>
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
              alt="Erro na resposta da missão"
              width="100"
            />
          )}
        </div>
      )}
    </dialog>
  );
}