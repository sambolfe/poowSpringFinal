<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.webjava.model.Funcionario" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<% String username = (String) request.getSession().getAttribute("username"); %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Funcionários</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/5.0.6/jquery.inputmask.min.js"></script>

    <style>
        body {
            padding-top: 70px;
        }
    </style>

    <script>
        function confirmExclusao(nomeFuncionario) {
            return confirm("Tem certeza que deseja excluir o funcionário " + nomeFuncionario + "?");
        }

        $(document).ready(function() {
            $('#telefone').inputmask('(99) 99999-9999');
        });
    </script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <a class="navbar-brand" href="/app_bic/principal/voltar">Sistema de Vendas</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="#"><%= username %></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/app_bic/login/logout">Sair</a>
            </li>
        </ul>
    </div>
</nav>
<div class="container">
    <h2>Adicionar novo funcionário:</h2>
    <c:if test="${not empty mensagemSucesso}">
        <div class="alert alert-success">${mensagemSucesso}</div>
    </c:if>
    <form action="/app_bic/funcionarios/adicionar" method="POST">
        <div class="form-group">
            <label for="nome">Nome:</label>
            <input type="text" class="form-control" id="nome" name="nome" required>
        </div>

        <div class="form-group">
            <label for="cargo">Cargo:</label>
            <input type="text" class="form-control" id="cargo" name="cargo" required>
        </div>

        <div class="form-group">
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="admin" name="admin">
                <label class="form-check-label" for="admin">Administrador</label>
            </div>
        </div>

        <div class="form-group">
            <label for="login">Login:</label>
            <input type="text" class="form-control" id="login" name="login" required>
        </div>

        <div class="form-group">
            <label for="senha">Senha:</label>
            <input type="password" class="form-control" id="senha" name="senha" required>
        </div>

        <div class="form-group">
            <label for="email">E-mail:</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="telefone">Telefone:</label>
            <input type="text" class="form-control" id="telefone" name="telefone" required>
        </div>

        <div class="form-group">
            <label for="endereco">Endereço:</label>
            <input type="text" class="form-control" id="endereco" name="endereco" required>
        </div>

        <div class="form-group">
            <label for="salario">Salário:</label>
            <input type="number" class="form-control" id="salario" name="salario" step="0.01" required>
        </div>

        <button type="submit" class="btn btn-primary btn-rounded">Adicionar</button>
    </form>

    <a class="back-link" href="/app_bic/principal">&lt; Voltar para a página inicial</a>

    <h2>Lista de Funcionários</h2>

    <table class="table text-left">
        <thead>
        <tr>
            <th>Nome</th>
            <th>Cargo</th>
            <th>Admin</th>
            <th>Login</th>
            <th>Senha</th>
            <th>E-mail</th>
            <th>Telefone</th>
            <th>Endereço</th>
            <th>Salário</th>
            <th>Ações</th>
        </tr>
        </thead>

        <tbody>
        Número de funcionários: ${funcionarios.size()}
        <c:forEach var="funcionario" items="${funcionarios}">
            <tr>
                <td>${funcionario.nome}</td>
                <td>${funcionario.cargo}</td>
                <td>${funcionario.admin}</td>
                <td>${funcionario.login}</td>
                <td>${funcionario.senha}</td>
                <td>${funcionario.email}</td>
                <td>${funcionario.telefone}</td>
                <td>${funcionario.endereco}</td>
                <td>${funcionario.salario}</td>
                <td>
                    <div class="btn-group">
                        <a href="/app_bic/funcionarios/editarFuncionario/${funcionario.id}" class="btn btn-primary btn-sm">Editar</a>
                        <a href="/app_bic/funcionarios/excluir/${funcionario.id}" class="btn btn-danger btn-sm ml-2" onclick="return confirmExclusao('${funcionario.nome}')">Excluir</a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
