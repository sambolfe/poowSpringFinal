package com.webjava.controller;

import com.webjava.dao.ProdutoDAO;
import com.webjava.model.Produto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/produtos")
public class ProdutoController {
    private ProdutoDAO produtoDAO;

    @Autowired
    public ProdutoController(ProdutoDAO produtoDAO) {
        this.produtoDAO = produtoDAO;
    }

    @GetMapping
    public String exibirListaProdutos(Model model) {
        List<Produto> produtos = produtoDAO.listarProdutos();
        model.addAttribute("produtos", produtos);
        return "produtos";
    }

    @GetMapping("/editarProduto/{id}")
    public String exibirEditarProduto(@PathVariable("id") int id, Model model) {
        Produto produto = produtoDAO.obterProdutoPorId(id);
        if (produto != null) {
            model.addAttribute("produto", produto);
            return "editarProduto";
        } else {
            return "redirect:/produtos";
        }
    }

    @PostMapping("/editar/{id}")
    public String editarProduto(@PathVariable("id") int id, @ModelAttribute("produto") Produto produto) {
        Produto produtoExistente = produtoDAO.obterProdutoPorId(id);
        if (produtoExistente != null) {
            produtoExistente.setNome(produto.getNome());
            produtoExistente.setDescricao(produto.getDescricao());
            produtoExistente.setPreco(produto.getPreco());
            produtoExistente.setQuantidade(produto.getQuantidade());

            produtoDAO.editarProduto(produtoExistente);
        }
        return "redirect:/produtos";
    }

    @GetMapping("/excluir/{id}")
    public String excluirProduto(@PathVariable("id") int id) {
        produtoDAO.excluirProduto(id);
        return "redirect:/produtos";
    }

    @PostMapping("/adicionar")
    public String adicionarProduto(@ModelAttribute("produto") Produto produto) {
        produtoDAO.criarProduto(produto);
        return "redirect:/produtos";
    }
}