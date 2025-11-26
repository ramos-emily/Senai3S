import { useState, useEffect, useRef } from 'react';

export default function Camera({ onFotoTirada }) {
    const videoRef = useRef(null);
    const canvasRef = useRef(null);
    const [foto, setFoto] = useState(null);

    useEffect(() => {
        iniciarCamera();

        return () => {
            pararCamera();
        };
    }, []);

    const iniciarCamera = async () => {
        try {
            const stream = await navigator.mediaDevices.getUserMedia({ video: true });
            if (videoRef.current) {
                videoRef.current.srcObject = stream;
            }
        } catch (error) {
            console.error("Erro ao acessar a camera", error);
        }
    };

    const pararCamera = () => {
        const video = videoRef.current;
        if (video && video.srcObject) {
            const tracks = video.srcObject.getTracks();
            tracks.forEach(track => track.stop());
        }
    };

    const tirarFoto = () => {
        const video = videoRef.current;
        const canvas = canvasRef.current;

        if (video && canvas) {
            const ctx = canvas.getContext("2d");

            canvas.width = video.videoWidth;
            canvas.height = video.videoHeight;

            ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
            
            const imagem = canvas.toDataURL("image/png");
            setFoto(imagem);

            if (onFotoTirada) {
                onFotoTirada(imagem);
            }
        }
    };

    const reiniciar = () => {
        setFoto(null);
        iniciarCamera();
    };

    return (
        <section className='camera-box'>
            <h2>Captura de Imagem por Camera</h2>
            <div className='preview'>
                {!foto ? (
                    <video ref={videoRef} autoPlay playsInline />
                ) : (
                    <img src={foto} alt="Foto capturada" />
                )}
            </div>
            
            <div>
                {!foto ? (
                    <button type='button' onClick={tirarFoto}>Tirar Foto</button>
                ) : (
                    <button type='button' onClick={reiniciar}>Nova Foto</button>
                )}
            </div>
            
            <canvas ref={canvasRef} style={{ display: "none" }}></canvas>
        </section>
    );
}