import { Link } from 'react-router-dom'
import estilos from './Albums.module.css'
import capaAlbum1 from '../../assets/album1.jpg'
import capaAlbum2 from '../../assets/album2.jpg'
import capaAlbum3 from '../../assets/album3.jpeg'


// array com albuns 
function Albuns() {
  const discografia = [
    {
      id: 1,
      titulo: "Ao Vivo em Jurerê",
      ano: 2012,
      imagem: capaAlbum1,
      faixas: 15,
      destaques: ["Propaganda", "Amo Noite e Dia", "Voa Beija-Flor"]
    },
    {
      id: 2,
      titulo: "Os Anjos Cantam",
      ano: 2015,
      imagem: capaAlbum2,
      faixas: 12,
      destaques: ["Que Sorte a Nossa", "A Hora é Agora", "Enchendo e Derramando"]
    },
    {
      id: 3,
      titulo: "Terra Sem CEP",
      ano: 2017,
      imagem: capaAlbum3,
      faixas: 14,
      destaques: ["Motel Afrodite", "Moleque Atrevido", "Dormi Na Praça"]
    }
  ]

  return (
    <article className={estilos.container}>
      <h1 className={estilos.titulo}>Discografia</h1>
      
      {/* seção principal */}
      <section aria-labelledby="albuns">
        <h2 id="albuns" className={estilos.tituloSecao}>Álbuns de Estúdio e Ao Vivo</h2>
        
        {/* grid para os cards com o map percorrendo aquele array q fiz la em cima */}
        <div className={estilos.gradeAlbuns}>
          {discografia.map(album => (
            <div key={album.id} className={estilos.cartaoAlbum}>
              <img 
                src={album.imagem} 
                alt={`Capa do álbum ${album.titulo}`} 
                className={estilos.imagemAlbum}
              />
              <div className={estilos.infoAlbum}>
                <h3 className={estilos.tituloAlbum}>{album.titulo}</h3>
                <p className={estilos.anoAlbum}>Lançamento: {album.ano}</p>
                <p className={estilos.faixasAlbum}>{album.faixas} faixas</p>
                
                {/* seção de mais detalhes dos albuns */}
                <details className={estilos.detalhesAlbum}>
                  <summary>Destaques</summary>
                  <ul className={estilos.listaDestaques}>
                    {album.destaques.map((musica, indice) => (
                      <li key={indice}>{musica}</li>
                    ))}
                  </ul>
                </details>
              </div>
            </div>
          ))}
        </div>
      </section>
      
      {/* link de voltar na home */}
      <div className={estilos.linkVoltar}>
        <Link to="/" className={estilos.botaoLink}>
          Voltar
        </Link>
      </div>
    </article>
  )
}

export default Albuns