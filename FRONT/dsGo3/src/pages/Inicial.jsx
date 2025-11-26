import { useNavigate } from 'react-router-dom';

export default function Inicial() {
    const navigate =useNavigate();

  return (
    <main className="inicial">
     
      <button onClick={() => navigate('/dsgo')} className='entrar'>
        Entrar
      </button>
    </main>
  );
}
