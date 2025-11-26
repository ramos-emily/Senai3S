import { Routes, Route } from 'react-router-dom';
import Inicial from "./pages/Inicial";
import DSGo from "./pages/DSGo";
import Missao from "./pages/Missao";
import Camera from './pages/Camera';
// import { Inventario } from "../Pagina/Inventario";
// import { GeolocalizacaoMapa } from "../Componentes/GeolocalizacaoMapa";

function App() {
  return (
    <Routes>
      <Route path="/" element={<Inicial />} />
      <Route path="/dsgo" element={<DSGo />} >
        <Route index element={<DSGo />} />
        <Route path="missao" element={<Missao />} />
        <Route path="camera" element={<Camera />} />
        {/*     <Route path="inventario" element={<Inventario/>} />
                <Route path="camera" element={<GeolocalizacaoMapa/>} />*/}
      </Route>
    </Routes>
  );
}

export default App;