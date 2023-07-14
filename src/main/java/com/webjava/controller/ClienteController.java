package com.webjava.controller;

import com.webjava.dao.ClienteDAO;
import com.webjava.model.Cliente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/clientes")
public class ClienteController {

    @Autowired
    private ClienteDAO clienteDAO;

    public ClienteController() {
    }

    @GetMapping
    public String exibirListaClientes(Model model) {
        List<Cliente> clientes = clienteDAO.listarClientes();
        model.addAttribute("clientes", clientes);
        return "clientes";
    }

    @GetMapping("/editarCliente/{id}")
    public String exibirEditarCliente(@PathVariable("id") int id, Model model) {
        Cliente cliente = clienteDAO.obterClientePorId(id);
        if (cliente != null) {
            model.addAttribute("cliente", cliente);
            return "editarCliente";
        } else {
            return "redirect:/clientes";
        }
    }

    @PostMapping("/editar/{id}")
    public String editarCliente(@PathVariable("id") int id, @ModelAttribute("cliente") Cliente cliente) {
        Cliente existingCliente = clienteDAO.obterClientePorId(id);
        if (existingCliente != null) {
            existingCliente.setNome(cliente.getNome());
            existingCliente.setEmail(cliente.getEmail());
            existingCliente.setTelefone(cliente.getTelefone());
            existingCliente.setEndereco(cliente.getEndereco());
            existingCliente.setCpf(cliente.getCpf());

            clienteDAO.editarCliente(existingCliente);
        }
        List<Cliente> clientes = clienteDAO.listarClientes();
        return "redirect:/clientes";
    }

    @GetMapping("/excluir/{id}")
    public String excluirCliente(@PathVariable("id") int id) {
        clienteDAO.excluirCliente(id);
        return "redirect:/clientes";
    }

    @PostMapping("/adicionar")
    public String adicionarCliente(@RequestParam("nome") String nome,
                                   @RequestParam("email") String email,
                                   @RequestParam("telefone") String telefone,
                                   @RequestParam("endereco") String endereco,
                                   @RequestParam("cpf") String cpf,
                                   Model model) {
        Cliente cliente = new Cliente(0, nome, email, telefone, endereco, cpf);
        clienteDAO.adicionarCliente(cliente);

        model.addAttribute("mensagemSucesso", "Cliente adicionado com sucesso!");
        List<Cliente> clientes = clienteDAO.listarClientes();
        model.addAttribute("clientes", clientes);

        return "clientes";
    }
}
