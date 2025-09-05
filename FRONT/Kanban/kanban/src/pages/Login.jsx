import { useForm } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import axios from "axios";

// Validação com Zod
const schemaLogin = z.object({
  nome: z
    .string()
    .min(1, "Preencha o campo de nome, por favor")
    .max(30, "Máximo de 30 caracteres"),
  email: z
    .string()
    .min(1, "Preencha o campo de email, por favor")
    .max(50, "Máximo de 50 caracteres")
    .email("Insira um email válido"),
});

export function Login() {
  const {
    register,
    handleSubmit,
    formState: { errors },
    reset,
  } = useForm({ resolver: zodResolver(schemaLogin) });

  async function logar(data) {
    console.log("Dados inseridos", data);

    try {
      await axios.post("http://127.0.0.1:8000/usuarios/", data);
      alert("Usuário Logado com sucesso!!");
      reset();
    } catch (error) {
      alert("Erro ao logar");
      console.error(error);
    }
  }

  return (
    <form className="form" onSubmit={handleSubmit(logar)}>
      <header>Login de usuário</header>
      <label>Nome:</label>
      <input type="text" placeholder="Emily Ramos" {...register("nome")} />
      {errors.nome && <p>{errors.nome.message}</p>}

      <label>E-mail:</label>
      <input type="email" placeholder="email@dominio.com.br" {...register("email")} />
      {errors.email && <p>{errors.email.message}</p>}

      <button type="submit">Logar</button>
    </form>
  );
}
