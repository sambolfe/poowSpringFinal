package com.webjava.controller;

import com.webjava.dao.ClienteDAO;
import com.webjava.dao.ProdutoDAO;
import com.webjava.dao.VendaDAO;
import com.webjava.dao.EstoqueDAO;
import com.webjava.model.Estoque;
import com.webjava.model.Vendas;
import com.webjava.model.Cliente;
import com.webjava.model.Produto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/vendas")
public class VendaController {
    private VendaDAO vendaDAO;
    private EstoqueDAO estoqueDAO;
    private ClienteDAO clienteDAO;
    private ProdutoDAO produtoDAO;

    @Autowired
    public VendaController(VendaDAO vendaDAO, EstoqueDAO estoqueDAO, ClienteDAO clienteDAO, ProdutoDAO produtoDAO) {
        this.vendaDAO = vendaDAO;
        this.estoqueDAO = estoqueDAO;
        this.clienteDAO = clienteDAO;
        this.produtoDAO = produtoDAO;
    }

    @GetMapping
    public ModelAndView exibirListaVendas() {
        ModelAndView modelAndView = new ModelAndView("vendas");
        try {
            List<Vendas> vendas = vendaDAO.listarVendas();
            List<Cliente> clientes = clienteDAO.listarClientes();
            List<Produto> produtos = produtoDAO.listarProdutos();

            modelAndView.addObject("vendas", vendas);
            modelAndView.addObject("clientes", clientes);
            modelAndView.addObject("produtos", produtos);
        } catch (SQLException e) {
            String mensagemErro = "Erro ao obter a lista de vendas. Por favor, tente novamente mais tarde.";
            modelAndView.addObject("mensagemErro", mensagemErro);
        }
        return modelAndView;
    }

    @GetMapping("/editarVenda/{id}")
    public String exibirEditarVenda(@PathVariable("id") int id, Model model) throws SQLException {
        Vendas venda = vendaDAO.obterVendaPorId(id);
        if (venda != null) {
            if (venda.getData() == null) {
                venda.setData(LocalDate.now()); // define a data atual como valor padrão
            }
            List<Cliente> clientes = clienteDAO.listarClientes();
            List<Produto> produtos = produtoDAO.listarProdutos();

            model.addAttribute("venda", venda);
            model.addAttribute("clientes", clientes);
            model.addAttribute("produtos", produtos);

            return "editarVenda";
        } else {
            return "redirect:/vendas";
        }
    }

    @PostMapping("/editar/{id}")
    public String editarVenda(@PathVariable("id") int id, RedirectAttributes redirectAttributes, @RequestParam("dataVenda") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dataVenda, @ModelAttribute("venda") Vendas venda) throws SQLException {
        Vendas vendaExistente = vendaDAO.obterVendaPorId(id);
        if (vendaExistente != null) {
            // pega a quantidade atual do produto antes da edição
            int quantidadeAntiga = vendaExistente.getQuantidade();

            // atualiza os dados da venda existente
            vendaExistente.setCliente(venda.getCliente());
            vendaExistente.setProduto(venda.getProduto());
            vendaExistente.setQuantidade(venda.getQuantidade());
            vendaExistente.setPrecoUnitario(venda.getPrecoUnitario());
            vendaExistente.setData(dataVenda);

            // calcula a diferença entre as quantidades
            int diferencaQuantidade = venda.getQuantidade() - quantidadeAntiga;

            // verifica se a quantidade foi alterada
            if (diferencaQuantidade > 0) {
                boolean removidoComSucesso = estoqueDAO.removerQuantidade(venda.getProduto().getId(), Math.abs(diferencaQuantidade));
                if (!removidoComSucesso) {
                    redirectAttributes.addFlashAttribute("mensagemErro", "Estoque insuficiente para o produto selecionado.");
                    return "redirect:/vendas/editarVenda/" + id; // Redirecionar para a página de edição com a mensagem de erro
                }
            } else {
                estoqueDAO.adicionarEstoque(new Estoque(venda.getProduto().getId(), Math.abs(diferencaQuantidade)));
            }

            // calcula o valor total atualizado da venda
            double valorTotalAtualizado = vendaExistente.getPrecoUnitario() * vendaExistente.getQuantidade();
            vendaExistente.setValorTotal(valorTotalAtualizado);

            // atualiza a venda no banco de dados
            vendaDAO.atualizarVenda(vendaExistente);
        }
        return "redirect:/vendas";
    }

    @PostMapping("/adicionar")
    public String adicionarVenda(@RequestParam("clienteId") int clienteId,
                                 @RequestParam("produtoId") int produtoId,
                                 @RequestParam("quantidade") int quantidade,
                                 @RequestParam("precoUnitario") double precoUnitario,
                                 RedirectAttributes redirectAttributes) {
        Cliente cliente = clienteDAO.obterClientePorId(clienteId);
        Produto produto = produtoDAO.obterProdutoPorId(produtoId);

        Vendas venda = new Vendas(0, cliente, produto, quantidade, precoUnitario, 0.0, LocalDate.now());

        try {
            double quantidadeDisponivel = estoqueDAO.getQuantidade(produtoId);

            if (quantidade > quantidadeDisponivel) {
                redirectAttributes.addFlashAttribute("mensagemErro", "Estoque insuficiente para o produto selecionado.");
            } else {
                double valorTotal = quantidade * precoUnitario;
                venda.setValorTotal(valorTotal);
                vendaDAO.criarVenda(venda);
                redirectAttributes.addFlashAttribute("mensagemSucesso", "Venda concluída com sucesso!");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("mensagemErro", "Erro ao adicionar a venda.");
        }

        return "redirect:/vendas";
    }


    @GetMapping("/excluir/{id}")
    public String excluirVenda(@PathVariable("id") int id) {
        vendaDAO.excluirVenda(id);
        return "redirect:/vendas";
    }
}
