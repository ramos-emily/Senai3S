// src/App.jsx
import { Routes, Route } from 'react-router-dom'
import Home from './pages/Home/Home'
import Albums from './pages/Albums/Albums'
import Ranking from './pages/Ranking/Ranking'
import Header from './components/Header/Header'
import Footer from './components/Footer/Footer'
import styles from './App.module.css'

function App() {
  return (
    <div className={styles.app}>
      <Header />
      <main className={styles.mainContent}>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/albums" element={<Albums />} />
          <Route path="/ranking" element={<Ranking />} />
        </Routes>
      </main>
      <Footer />
    </div>
  )
}

export default App