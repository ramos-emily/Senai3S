import { useForm } from "react-hook-form";
import {z} from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import axios from "axios";

const schemaRegister = z.object({
    nome: z.string()
        .min(1, 'Preencha o campo de nome, por favor')
        .max(30, 'Máximo de 30 caracteres'),

    email: z.string()
        .min(1, 'Preencha o campo de email, por favor')
        .max(50, 'Máximo de 50 caracteres')
        .email('Insira um email válido'),
    });

export function Register(){

    const{
        register, //registra oq foi digitado
        handlesubmit, // no momento do envio
        formStatus: {errors}, // se der ruim guarda no errors
        reset //limpa o form
    } = useForm({resolver: zodResolver(schemaRegister)})

    async function obterDados(data) {
        console.log("Dados inseridos", data)

        try{
            await axios.post('http://127.0.0.1:8000/usuario/', data);
            alert("Usuario cadastrado com sucesso!!");
            reset();
        }catch(errors){
            alert("Nao deu certo, faz dnv", errors);
            console.error(errors)
        }
    }

    return(
        <form className="form" onSubmit={handlesubmit(obterDados)}>
            <header>Cadastro de usuário</header>
            <label>Name:</label>
            <input type="text" placeholder="Gaibriel Bosco" {...register('nome')}/>
            {errors.nome && <p>{errors.nome.message}</p>}

            <label>E-mail:</label>
            <input type="email" placeholder="email@dominio.com.br" {...register('email')}/>
            {errors.email && <p>{errors.email.message}</p>}

            <button type="submit">Cadastrar</button>
        </form>
    )
}