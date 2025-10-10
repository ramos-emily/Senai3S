import logo from '../assets/logo.png';
import { useNavigate } from 'react-router-dom';

export function Inicial() {
  const navigate = useNavigate();

  return (
    <main 
      className="inicial" 
      aria-label="Tela inicial do jogo" 
      style={{ backgroundImage: `url(${logo})` }}
    >
      <button 
        onClick={() => navigate('/dsgo')} 
        className="entrar"
        aria-label="Entrar no jogo"
      >
        Entrar
      </button>
    </main>
  );
}
