import { Outlet } from 'react-router-dom';
import { Menu } from '../components/Menu';

export default function DSGo(){
    return(
        <main className="corpo">
            <Outlet/>
            <Menu/>            
        </main>

    )
}