import { Header } from "./Components/header"
import {NavBar} from "./Components/NavBar"
import { Login } from "./pages/Login"
import { Register } from "./pages/Register"

function App() {
  return (
    <div>
      <NavBar/>
      <Header/>
      <Register/>
      <Login/>
    </div>
  )
}

export default App
