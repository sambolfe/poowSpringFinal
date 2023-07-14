package com.webjava.dao;

import com.webjava.model.Vendas;
import com.webjava.model.Cliente;
import com.webjava.model.Produto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Repository
public class VendaDAO {
    private final DataSource dataSource;
    private final EstoqueDAO estoqueDAO;
    private final ClienteDAO clienteDAO;
    private final ProdutoDAO produtoDAO;

    @Autowired
    public VendaDAO(DataSource dataSource, EstoqueDAO estoqueDAO, ClienteDAO clienteDAO, ProdutoDAO produtoDAO) {
        this.dataSource = dataSource;
        this.estoqueDAO = estoqueDAO;
        this.clienteDAO = clienteDAO;
        this.produtoDAO = produtoDAO;
    }

    public void criarVenda(Vendas venda) throws SQLException {
        String sql = "INSERT INTO vendas (id_produto, id_cliente, quantidade, preco_unitario, valor_total, data_venda) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, venda.getProduto().getId());
            statement.setInt(2, venda.getCliente().getId());
            statement.setInt(3, venda.getQuantidade());
            statement.setDouble(4, venda.getPrecoUnitario());
            statement.setDouble(5, venda.getValorTotal());
            java.sql.Date dataVendaSql = java.sql.Date.valueOf(venda.getData());
            statement.setDate(6, dataVendaSql);
            statement.executeUpdate();

            // Atualizar o estoque do produto
            estoqueDAO.removerQuantidade(venda.getProduto().getId(), venda.getQuantidade());
        }
    }

    public void atualizarVenda(Vendas venda) throws SQLException {
        String sql = "UPDATE vendas SET id_produto = ?, id_cliente = ?, quantidade = ?, preco_unitario = ?, valor_total = ?, data_venda = ? WHERE id = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, venda.getProduto().getId());
            statement.setInt(2, venda.getCliente().getId());
            statement.setInt(3, venda.getQuantidade());
            statement.setDouble(4, venda.getPrecoUnitario());
            statement.setDouble(5, venda.getValorTotal());
            java.sql.Date dataVendaSql = java.sql.Date.valueOf(venda.getData());
            statement.setDate(6, dataVendaSql);
            statement.setInt(7, venda.getId());

            statement.executeUpdate();
        }
    }

    public List<Vendas> listarVendas() throws SQLException {
        List<Vendas> vendas = new ArrayList<>();
        String sql = "SELECT * FROM vendas ORDER BY id ASC";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                int produtoId = resultSet.getInt("id_produto");
                int clienteId = resultSet.getInt("id_cliente");
                int quantidade = resultSet.getInt("quantidade");

                // pega o preço no banco
                double precoUnitario = 0.0;

                try (Statement getPriceStatement = connection.createStatement()) {
                    String getPriceSql = "SELECT preco FROM produtos WHERE id = " + produtoId;
                    try (ResultSet priceResultSet = getPriceStatement.executeQuery(getPriceSql)) {
                        if (priceResultSet.next()) {
                            precoUnitario = priceResultSet.getDouble("preco");
                        }
                    }
                }

                double valorTotal = resultSet.getDouble("valor_total");
                LocalDate dataVenda = resultSet.getDate("data_venda").toLocalDate();

                Cliente cliente = clienteDAO.obterClientePorId(clienteId);
                Produto produto = produtoDAO.obterProdutoPorId(produtoId);

                Vendas venda = new Vendas(id, cliente, produto, quantidade, precoUnitario, valorTotal, dataVenda);
                vendas.add(venda);
            }
        }

        return vendas;
    }

    public boolean excluirVenda(int id) {
        String sql = "DELETE FROM vendas WHERE id = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            int linhasAfetadas = statement.executeUpdate();

            if (linhasAfetadas > 0) {
                return true; // não excluiu
            }
        } catch (SQLException e) {
            System.out.println("Erro ao excluir venda: " + e.getMessage());
        }

        return false; // excluiu
    }

    public Vendas obterVendaPorId(int id) throws SQLException {
        Vendas venda = null;
        String sql = "SELECT * FROM vendas WHERE id = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int produtoId = resultSet.getInt("id_produto");
                    int clienteId = resultSet.getInt("id_cliente");
                    int quantidade = resultSet.getInt("quantidade");
                    double precoUnitario = resultSet.getDouble("preco_unitario");
                    double valorTotal = resultSet.getDouble("valor_total");
                    LocalDate dataVenda = resultSet.getDate("data_venda").toLocalDate();

                    Cliente cliente = clienteDAO.obterClientePorId(clienteId);
                    Produto produto = produtoDAO.obterProdutoPorId(produtoId);

                    venda = new Vendas(id, cliente, produto, quantidade, precoUnitario, valorTotal, dataVenda);
                }
            }
        }
        return venda;
    }
}
