package com.webjava.service;

import com.webjava.dao.FuncionarioDAO;
import com.webjava.model.Funcionario;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

    public boolean autenticar(String login, String senha){

        Funcionario f = new FuncionarioDAO().getFuncionario(login);
        if(f.getNome() == null){
            System.out.println("usuário null -> "+f.toString());
            return false;
        }else{
            if(f.getLogin().equals(login) && f.getSenha().equals(senha)){
                return true;
            }else{
                return false;
            }
        }
    }
}
