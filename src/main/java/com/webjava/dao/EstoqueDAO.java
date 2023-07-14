package com.webjava.dao;

import com.webjava.model.Estoque;
import com.webjava.model.Produto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;

@Repository
public class EstoqueDAO {
    private final DataSource dataSource;
    private final ProdutoDAO produtoDAO;

    @Autowired
    public EstoqueDAO(DataSource dataSource, ProdutoDAO produtoDAO) {
        this.dataSource = dataSource;
        this.produtoDAO = produtoDAO;
    }

    public void adicionarEstoque(Estoque estoque) {
        Produto produto = produtoDAO.obterProdutoPorId(estoque.getProdutoId());

        if (produto != null) {
            produto.setQuantidade(produto.getQuantidade() + estoque.getQuantidade());
            produtoDAO.editarProduto(produto);
        } else {
            // Tratar caso em que o produto não existe
        }
    }

    public boolean removerQuantidade(int produtoId, double quantidade) {
        Produto produto = produtoDAO.obterProdutoPorId(produtoId);

        if (produto != null) {
            double quantidadeAtual = produto.getQuantidade();
            double novaQuantidade = quantidadeAtual - quantidade;

            if (novaQuantidade >= 0) {
                produto.setQuantidade(novaQuantidade);
                produtoDAO.editarProduto(produto);
                return true; // operação bem-sucedida
            } else {
                return false; // estoque insuficiente
            }
        } else {
            return false; // produto não encontrado
        }
    }

    public double getQuantidade(int produtoId) {
        Produto produto = produtoDAO.obterProdutoPorId(produtoId);

        if (produto != null) {
            return produto.getQuantidade();
        } else {
            return 0.0;
        }
    }

}
