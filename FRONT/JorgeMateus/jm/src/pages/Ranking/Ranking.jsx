import { Link } from 'react-router-dom'
import estilos from './Ranking.module.css'
import imagemShow from '../../assets/jmRanking.jpg'


// array de dados e ranking deles
function Ranking() {
  const estatisticasSpotify = {
    ouvintesMensais: "12.5 milhões",
    musicasTop: [
      { nome: "Propaganda", reproducoes: "350 milhões" },
      { nome: "Voa Beija-Flor", reproducoes: "280 milhões" },
      { nome: "Amo Noite e Dia", reproducoes: "250 milhões" }
    ],
    posicaoGlobal: 45,
    posicaoBrasil: 8,
    seguidores: "8.2 milhões"
  }

  return (
    <article className={estilos.container}>
      <h1 className={estilos.titulo}>Ranking e Popularidade</h1>
      

      {/* seção principal */}
      <section className={estilos.conteudo} aria-labelledby="ranking">
        <div className={estilos.containerImagem}>
          <img 
            src={imagemShow} 
            alt="Jorge & Mateus no palco" 
            className={estilos.imagem}
          />
        </div>
        
        {/* grid com principais */}
        <div className={estilos.estatisticas}>
          <h2 id="ranking" className={estilos.tituloSecao}>Estatísticas no Spotify</h2>
          
          <div className={estilos.gradeEstatisticas}>
            <div className={estilos.itemEstatistica}>
              <h3 className={estilos.tituloEstatistica}>Ouvintes Mensais</h3>
              <p className={estilos.valorEstatistica}>{estatisticasSpotify.ouvintesMensais}</p>
            </div>
            
            <div className={estilos.itemEstatistica}>
              <h3 className={estilos.tituloEstatistica}>Ranking Global</h3>
              <p className={estilos.valorEstatistica}>#{estatisticasSpotify.posicaoGlobal}</p>
            </div>
            
            <div className={estilos.itemEstatistica}>
              <h3 className={estilos.tituloEstatistica}>Ranking no Brasil</h3>
              <p className={estilos.valorEstatistica}>#{estatisticasSpotify.posicaoBrasil}</p>
            </div>
            
            <div className={estilos.itemEstatistica}>
              <h3 className={estilos.tituloEstatistica}>Seguidores</h3>
              <p className={estilos.valorEstatistica}>{estatisticasSpotify.seguidores}</p>
            </div>
          </div>
          
          <div className={estilos.topMusicas}>
            <h3 className={estilos.subtitulo}>Músicas Mais Tocadas</h3>
            <ol className={estilos.listaMusicas}>
              {estatisticasSpotify.musicasTop.map((musica, indice) => (
                <li key={indice} className={estilos.itemMusica}>
                  <span className={estilos.nomeMusica}>{musica.nome}</span>
                  <span className={estilos.reproducoesMusica}>{musica.reproducoes}</span>
                </li>
              ))}
            </ol>
          </div>
        </div>
      </section>
      
      {/* link voltando pra home */}
      <div className={estilos.linkVoltar}>
        <Link to="/" className={estilos.botaoLink}>
          Voltar
        </Link>
      </div>
    </article>
  )
}

export default Ranking