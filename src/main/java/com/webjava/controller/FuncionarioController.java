package com.webjava.controller;

import com.webjava.dao.FuncionarioDAO;
import com.webjava.model.Funcionario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/funcionarios")
public class FuncionarioController {

    private FuncionarioDAO funcionarioDAO;

    @Autowired
    public FuncionarioController(FuncionarioDAO funcionarioDAO) {
        this.funcionarioDAO = funcionarioDAO;
    }

    @GetMapping
    public String exibirListaFuncionarios(Model model) {
        List<Funcionario> funcionarios = funcionarioDAO.listarFuncionarios();
        model.addAttribute("funcionarios", funcionarios);
        return "funcionarios";
    }

    @GetMapping("/editarFuncionario/{id}")
    public String exibirEditarFuncionario(@PathVariable("id") int id, Model model) {
        Funcionario funcionario = funcionarioDAO.obterFuncionarioPorId(id);
        if (funcionario != null) {
            model.addAttribute("funcionario", funcionario);
            return "editarFuncionario";
        } else {
            return "redirect:/funcionarios";
        }
    }

    @PostMapping("/editar/{id}")
    public String editarFuncionario(@PathVariable("id") int id,
                                    @RequestParam("nome") String nome,
                                    @RequestParam("cargo") String cargo,
                                    @RequestParam(value = "admin", required = false) Boolean admin,
                                    @RequestParam("login") String login,
                                    @RequestParam("senha") String senha,
                                    @RequestParam("email") String email,
                                    @RequestParam("telefone") String telefone,
                                    @RequestParam("endereco") String endereco,
                                    @RequestParam("salario") double salario) {
        Funcionario funcionarioExistente = funcionarioDAO.obterFuncionarioPorId(id);
        if (funcionarioExistente != null) {
            funcionarioExistente.setNome(nome);
            funcionarioExistente.setCargo(cargo);
            funcionarioExistente.setAdmin(admin != null ? admin : false);
            funcionarioExistente.setLogin(login);
            funcionarioExistente.setSenha(senha);
            funcionarioExistente.setEmail(email);
            funcionarioExistente.setTelefone(telefone);
            funcionarioExistente.setEndereco(endereco);
            funcionarioExistente.setSalario(salario);

            funcionarioDAO.atualizarFuncionario(funcionarioExistente);
        }
        return "redirect:/funcionarios";
    }

    @GetMapping("/excluir/{id}")
    public String excluirFuncionario(@PathVariable("id") int id) {
        funcionarioDAO.excluirFuncionario(id);
        return "redirect:/funcionarios";
    }

    @PostMapping("/adicionar")
    public String adicionarFuncionario(@RequestParam("nome") String nome,
                                       @RequestParam("cargo") String cargo,
                                       @RequestParam(value = "admin", required = false) Boolean admin,
                                       @RequestParam("login") String login,
                                       @RequestParam("senha") String senha,
                                       @RequestParam("email") String email,
                                       @RequestParam("telefone") String telefone,
                                       @RequestParam("endereco") String endereco,
                                       @RequestParam("salario") double salario,
                                       Model model) {

        Funcionario funcionario = new Funcionario(0, nome, cargo, admin != null ? admin : false, login, senha, email, telefone, endereco, salario);
        funcionarioDAO.adicionarFuncionario(funcionario);

        model.addAttribute("mensagemSucesso", "Funcionário adicionado com sucesso!");
        List<Funcionario> funcionarios = funcionarioDAO.listarFuncionarios();
        model.addAttribute("funcionarios", funcionarios);

        return "funcionarios";
    }
}
