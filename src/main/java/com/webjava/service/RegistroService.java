package com.webjava.service;

import com.webjava.dao.FuncionarioDAO;
import com.webjava.model.Funcionario;
import org.springframework.stereotype.Service;

@Service
public class RegistroService {

    public boolean registrarUsuario(Funcionario funcionario) {
        FuncionarioDAO funcionarioDAO = new FuncionarioDAO();

        if (funcionarioDAO.getFuncionario(funcionario.getLogin()) != null) {
            return false; // ja existe um usuário com esse login
        }

        // inserir o novo funcionario(usuario) no banco de dados
        return funcionarioDAO.adicionarFuncionario(funcionario);
    }
}