package com.webjava.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.webjava.model.Produto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;

@Repository
public class ProdutoDAO {

    @Autowired
    private DataSource dataSource;


    public Produto obterProdutoPorId(int id) {
        try {
            String sql = "SELECT * FROM produtos WHERE id = ?";
            PreparedStatement statement = dataSource.getConnection().prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String nome = resultSet.getString("nome");
                String descricao = resultSet.getString("descricao");
                double preco = resultSet.getDouble("preco");
                double quantidade = resultSet.getDouble("quantidade");
                return new Produto(id, nome, descricao, preco, quantidade);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean criarProduto(Produto produto) {
        String sql = "INSERT INTO produtos (nome, descricao, preco, quantidade) VALUES (?, ?, ?, ?)";

        try (PreparedStatement statement = dataSource.getConnection().prepareStatement(sql)) {
            statement.setString(1, produto.getNome());
            statement.setString(2, produto.getDescricao());
            statement.setDouble(3, produto.getPreco());
            statement.setDouble(4, produto.getQuantidade());
            int linhasAfetadas = statement.executeUpdate();
            return (linhasAfetadas > 0); //  true se pelo menos uma linha foi afetada
        } catch (SQLException e) {
            return false; // false em caso de exceção
        }
    }

    public boolean editarProduto(Produto produto) {
        try {
            String sql = "UPDATE produtos SET nome = ?, descricao = ?, preco = ?, quantidade = ? WHERE id = ?";
            PreparedStatement statement = dataSource.getConnection().prepareStatement(sql);
            statement.setString(1, produto.getNome());
            statement.setString(2, produto.getDescricao());
            statement.setDouble(3, produto.getPreco());
            statement.setDouble(4, produto.getQuantidade());
            statement.setInt(5, produto.getId());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0; //  true se pelo menos uma linha foi atualizada
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean excluirProduto(int id) {
        String sql = "DELETE FROM produtos WHERE id = ?";

        try (PreparedStatement statement = dataSource.getConnection().prepareStatement(sql)) {
            statement.setInt(1, id);
            int linhasAfetadas = statement.executeUpdate();

            if (linhasAfetadas > 0) {
                return true; // não excluiu
            }
        } catch (SQLException e) {
            System.out.println("Erro ao excluir produto: " + e.getMessage());
        }

        return false; // excluiu com sucesso
    }

    public List<Produto> listarProdutos() {
        String sql = "SELECT * FROM produtos ORDER BY id ASC";
        List<Produto> produtos = new ArrayList<>();

        try (PreparedStatement statement = dataSource.getConnection().prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String nome = resultSet.getString("nome");
                String descricao = resultSet.getString("descricao");
                double preco = resultSet.getDouble("preco");
                double quantidade = resultSet.getDouble("quantidade");
                Produto produto = new Produto(id ,nome, descricao, preco, quantidade);
                produto.setId(id);
                produtos.add(produto);
            }
        } catch (SQLException e) {
            System.out.println("Erro ao listar produtos: " + e.getMessage());
        }

        return produtos;
    }
}
