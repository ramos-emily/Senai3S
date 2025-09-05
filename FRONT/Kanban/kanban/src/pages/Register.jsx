import { useForm } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import axios from "axios";

// Validação com Zod
const schemaUsuario = z.object({
  nome: z
    .string()
    .min(1, "Preencha o campo de nome")
    .max(50, "Máximo de 50 caracteres"),
  email: z
    .string()
    .min(1, "Preencha o campo de email")
    .max(100, "Máximo de 100 caracteres")
    .email("Insira um email válido"),
});

export function Register() {
  const {
    register,
    handleSubmit,
    formState: { errors },
    reset,
  } = useForm({
    resolver: zodResolver(schemaUsuario),
  });

  async function cadastrarUsuario(data) {
    console.log("Dados inseridos", data);

    try {
      await axios.post("http://127.0.0.1:8000/usuarios/", data);
      alert("Usuário registrado com sucesso!");
      reset();
    } catch (error) {
      console.error(error);
      if (error.response) {
        // Erro vindo do backend
        alert(`Erro ao registrar: ${JSON.stringify(error.response.data)}`);
      } else {
        alert("Erro de conexão com o servidor");
      }
    }
  }

  return (
    <form className="form" onSubmit={handleSubmit(cadastrarUsuario)}>
      <header>Cadastro de Usuário</header>

      <label>Nome:</label>
      <input type="text" placeholder="Emily Ramos" {...register("nome")} />
      {errors.nome && <p style={{ color: "red" }}>{errors.nome.message}</p>}

      <label>E-mail:</label>
      <input type="email" placeholder="email@dominio.com.br" {...register("email")} />
      {errors.email && <p style={{ color: "red" }}>{errors.email.message}</p>}

      <button type="submit">Registrar</button>
    </form>
  );
}
