package com.webjava.controller;

import com.webjava.dao.FuncionarioDAO;
import com.webjava.model.Funcionario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private FuncionarioDAO funcionarioDAO;

    @GetMapping
    public String exibirFormularioLogin() {

        return "index";
    }

    @GetMapping("logout")
    public String fazerLogout(HttpServletRequest request){
        request.getSession().invalidate();
        return "index";
    }

    @PostMapping("/principal")
    public String fazerLogin(ModelAndView m, String username, String password, Model model, HttpSession session) {
        Funcionario funcionario = funcionarioDAO.getFuncionario(username);
        if (funcionario != null && funcionario.getSenha().equals(password)) {
            // autenticação ok
            session.setAttribute("username", funcionario.getNome()); // Armazena o nome do usuário na sessão
            session.setAttribute("admin", funcionario.isAdmin());

            return "principal";
        } else {

            model.addAttribute("mensagemErro", "Usuário ou senha inválidos");
            return "index";
        }

    }
}
