import { Routes, Route, useLocation } from 'react-router-dom'
import { Navbar } from './components/Navbar'

import { Login } from './pages/Login'
import { Cadastro } from './pages/Register'

import { Ambiente } from './pages/Environment'
import { Home } from './pages/Map'
import { Sensores } from './pages/Sensor'
import { Historico } from './pages/History'

import './App.css'

export default function App() {
  const location = useLocation()

  const hideNavbarRoutes = ["/", "/cadastro"] 
  const hideNavbar = hideNavbarRoutes.includes(location.pathname)

  return (
    <>

      {!hideNavbar && <Navbar />}

      <Routes>
        <Route path="/home" element={<Home />} />
        <Route path="/ambiente" element={<Ambiente />} />
        <Route path="/sensores" element={<Sensores />} />
        <Route path="/historico" element={<Historico />} />

        <Route path="/" element={<Login />} />
        <Route path="/cadastro" element={<Cadastro />} />
      </Routes>
    </>
  )
}
