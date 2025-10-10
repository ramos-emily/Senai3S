import { Outlet } from 'react-router-dom';
import { Menu } from '../Componentes/Menu';

export function DSGo() {
  return (
    <div className="corpo" role="application">
      <main aria-label="Conteúdo principal do jogo">
        <Outlet />
      </main>

      <Menu />
    </div>
  );
}
