
import { Routes, Route } from "react-router-dom";
import { Inicial } from "../Paginas/Inicial";
import { DSGo } from "../Paginas/DSGo";
import { Missao} from "../Paginas/Missao";
import { Camera } from "../Paginas/"
// import { Inventario } from "../Pagina/Inventario";
// import { GeolocalizacaoMapa } from "../Componentes/GeolocalizacaoMapa";

export function Rotas() {
    return (
        <Routes>
            <Route path="/" element={<Inicial />} />
            <Route path="/dsgo" element={<DSGo />} >  
            <Route path="/missao" element={<Missao />} /> 
            <Route path="/camera" element={<Camera />} />
             {/*     <Route path="inventario" element={<Inventario/>} />
                <Route path="camera" element={<GeolocalizacaoMapa/>} />*/}
            </Route>   
        </Routes>
    );
}   