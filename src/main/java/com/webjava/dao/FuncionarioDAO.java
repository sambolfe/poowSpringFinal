package com.webjava.dao;

import com.webjava.model.Funcionario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class FuncionarioDAO {

    @Autowired
    private DataSource dataSource;

    public boolean adicionarFuncionario(Funcionario funcionario) {
        try {
            // verifica se o funcionário já existe no banco
            if (funcionarioJaExiste(funcionario.getNome())) {
                return false; // funcionário já existe
            }

            String sql = "INSERT INTO funcionarios (nome, cargo, admin, login, senha, email, telefone, endereco, salario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = dataSource.getConnection().prepareStatement(sql);
            statement.setString(1, funcionario.getNome());
            statement.setString(2, funcionario.getCargo());
            statement.setBoolean(3, funcionario.isAdmin());
            statement.setString(4, funcionario.getLogin());
            statement.setString(5, funcionario.getSenha());
            statement.setString(6, funcionario.getEmail());
            statement.setString(7, funcionario.getTelefone());
            statement.setString(8, funcionario.getEndereco());
            statement.setDouble(9, funcionario.getSalario());

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean funcionarioJaExiste(String nome) throws SQLException {
        String sql = "SELECT COUNT(*) FROM funcionarios WHERE nome = ?";
        PreparedStatement statement = dataSource.getConnection().prepareStatement(sql);
        statement.setString(1, nome);
        ResultSet resultSet = statement.executeQuery();
        resultSet.next();
        int count = resultSet.getInt(1);
        return count > 0;
    }

    public Funcionario obterFuncionarioPorId(int id) {
        try {
            String sql = "SELECT * FROM funcionarios WHERE id = ?";
            PreparedStatement statement = dataSource.getConnection().prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String nome = resultSet.getString("nome");
                String cargo = resultSet.getString("cargo");
                boolean admin = resultSet.getBoolean("admin");
                String login = resultSet.getString("login");
                String senha = resultSet.getString("senha");
                String email = resultSet.getString("email");
                String telefone = resultSet.getString("telefone");
                String endereco = resultSet.getString("endereco");
                double salario = resultSet.getDouble("salario");
                return new Funcionario(id, nome, cargo, admin, login, senha, email, telefone, endereco, salario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Funcionario getFuncionario(String login) {
        Funcionario funcionario = null;
        try {
            String sql = "SELECT * FROM funcionarios WHERE login = ?";
            PreparedStatement statement = dataSource.getConnection().prepareStatement(sql);
            statement.setString(1, login);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int id = resultSet.getInt("id");
                String nome = resultSet.getString("nome");
                String cargo = resultSet.getString("cargo");
                boolean admin = resultSet.getBoolean("admin");
                String senha = resultSet.getString("senha");
                String email = resultSet.getString("email");
                String telefone = resultSet.getString("telefone");
                String endereco = resultSet.getString("endereco");
                double salario = resultSet.getDouble("salario");
                funcionario = new Funcionario(0, nome, cargo, admin, login, senha, email, telefone, endereco, salario);
                funcionario.setId(id);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return funcionario;
    }

    public List<Funcionario> listarFuncionarios() {
        List<Funcionario> funcionarios = new ArrayList<>();

        String sql = "SELECT * FROM funcionarios ORDER BY id ASC";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                // Obtenha os dados do funcionário do ResultSet
                int id = resultSet.getInt("id");
                String nome = resultSet.getString("nome");
                String cargo = resultSet.getString("cargo");
                boolean admin = resultSet.getBoolean("admin");
                String login = resultSet.getString("login");
                String senha = resultSet.getString("senha");
                String email = resultSet.getString("email");
                String telefone = resultSet.getString("telefone");
                String endereco = resultSet.getString("endereco");
                double salario = resultSet.getDouble("salario");

                // Crie um objeto Funcionario e adiciona a lista
                Funcionario funcionario = new Funcionario(id, nome, cargo, admin, login, senha, email, telefone, endereco, salario);
                funcionarios.add(funcionario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return funcionarios;
    }


    public boolean atualizarFuncionario(Funcionario funcionario) {
        try {
            String sql = "UPDATE funcionarios SET nome = ?, cargo = ?, admin = ?, login = ?, senha = ?, email = ?, telefone = ?, endereco = ?, salario = ? WHERE id = ?";
            PreparedStatement statement = dataSource.getConnection().prepareStatement(sql);
            statement.setString(1, funcionario.getNome());
            statement.setString(2, funcionario.getCargo());
            statement.setBoolean(3, funcionario.isAdmin());
            statement.setString(4, funcionario.getLogin());
            statement.setString(5, funcionario.getSenha());
            statement.setString(6, funcionario.getEmail());
            statement.setString(7, funcionario.getTelefone());
            statement.setString(8, funcionario.getEndereco());
            statement.setDouble(9, funcionario.getSalario());
            statement.setInt(10, funcionario.getId());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0; // true se pelo menos uma linha foi atualizada
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean excluirFuncionario(int id) {
        try {
            String sql = "DELETE FROM funcionarios WHERE id = ?";
            PreparedStatement statement = dataSource.getConnection().prepareStatement(sql);
            statement.setInt(1, id);
            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
