import { Link } from 'react-router-dom'
import estilos from './Home.module.css'
import imagemDupla from '../../assets/album1.jpg'

function Home() {
  return (
    <article className={estilos.container}>
      <h1 className={estilos.titulo}>Jorge & Mateus</h1>
      
      {/* seção informativa sobre a dupla Jorge e Mateus */}
      <section className={estilos.sobre} aria-labelledby="sobre-dupla">
        <h2 id="sobre-dupla" className={estilos.tituloSecao}>Sobre a Dupla</h2>
        <div className={estilos.conteudoSobre}>
          <img 
            src={imagemDupla} 
            alt="Jorge & Mateus em show" 
            className={estilos.imagem}
          />
          <div className={estilos.textoSobre}>
            <p>
              Jorge & Mateus é uma dupla brasileira de música sertaneja formada em 2005 
              por Jorge Alves Barcelos e Mateus Pedro Liduário de Oliveira.
            </p>
            <p>
              Com mais de 15 anos de carreira, a dupla se consolidou como uma das mais 
              importantes do sertanejo universitário, com hits que marcaram gerações.
            </p>
            <Link to="/albums" className={estilos.botaoPrincipal}>
              Explorar Discografia
            </Link>
          </div>
        </div>
        <h1>So qualquer coisa aqui pra commitar e fingir que eu codo na gravação da GS</h1>
      </section>
      
      {/* seção sobre os destaques da carreira */}
      <section className={estilos.destaques} aria-labelledby="destaques-carreira">
        <h2 id="destaques-carreira" className={estilos.tituloSecao}>Destaques da Carreira</h2>
        <ul className={estilos.listaDestaques}>
          <li>Mais de 5 milhões de álbuns vendidos</li>
          <li>Mais de 15 bilhões de streams em plataformas digitais</li>
          <li>Turnês internacionais em 15 países diferentes</li>
          <li>8 prêmios importantes incluindo Grammy Latino</li>
          <li>12 álbuns lançados (entre estúdio e ao vivo)</li>
        </ul>
      </section>
    </article>
  )
}

export default Home