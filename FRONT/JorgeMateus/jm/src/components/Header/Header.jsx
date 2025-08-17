import { Link } from 'react-router-dom'
import styles from './Header.module.css'
import logo from '../../assets/logo.png'

function Header() {
  return (
    <header className={styles.header}>
      <Link to="/">
        <img 
          src={logo} 
          alt="Logo Jorge & Mateus" 
          className={styles.logo}
        />
      </Link>

      {/* seção de navegação das pages */}
      <nav aria-label="Navegação principal" className={styles.navContainer}>
        <ul className={styles.navList}>
          <li>
            <Link to="/" className={styles.navLink}>
              Home
            </Link>
          </li>
          <li>
            <Link to="/albums" className={styles.navLink}>
              Álbuns
            </Link>
          </li>
          <li>
            <Link to="/ranking" className={styles.navLink}>
              Ranking
            </Link>
          </li>
        </ul>
      </nav>
    </header>
  )
}

export default Header