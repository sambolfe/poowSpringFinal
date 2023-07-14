package com.webjava.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/principal")
public class PrincipalController {

    @GetMapping
    public String exibirPrincipal() {
        return "principal";
    }

    @GetMapping("/voltar")
    public String voltarParaPrincipal() {
        return "redirect:/principal";
    }
}