import missao from '../assets/mission.png';
import mapa from '../assets/maps.png';
import bau from '../assets/bau_tratado.png';
import camera from '../assets/camera1.png';
import { Link } from 'react-router-dom';

export function Menu() {
  return (
    <nav className="menu" aria-label="Menu principal">
      <ul>
        <li>
          <Link to="missao" aria-label="Ir para Missões">
            <figure>
              <img src={missao} alt="Ícone de Missões" />
              <figcaption>Missões</figcaption>
            </figure>
          </Link>
        </li>

        <li>
          <button aria-label="Abrir Inventário">
            <figure>
              <img src={bau} alt="Ícone de Inventário" />
              <figcaption>Inventário</figcaption>
            </figure>
          </button>
        </li>

        <li>
          <button aria-label="Abrir GeoLocalização">
            <figure>
              <img src={mapa} alt="Ícone de GeoLocalização" />
              <figcaption>GeoLocalização</figcaption>
            </figure>
          </button>
        </li>

        <li>
          <button aria-label="Abrir Câmera">
            <figure>
              <img src={camera} alt="Ícone de Câmera" />
              <figcaption>Câmera</figcaption>
            </figure>
          </button>
        </li>
      </ul>
    </nav>
  );
}
