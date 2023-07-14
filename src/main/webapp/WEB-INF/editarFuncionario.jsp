<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.webjava.model.Funcionario" %>
<%@ page import="com.webjava.dao.FuncionarioDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String username = (String) request.getSession().getAttribute("username"); %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Funcionário</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/5.0.6/jquery.inputmask.min.js"></script>

    <style>
        body {
            padding-top: 70px;
        }
    </style>
    <script>
    $(document).ready(function() {
    // Máscara para telefone
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
    <h1>Editar Funcionário</h1>

    <c:if test="${funcionario != null}">
        <form action="/app_bic/funcionarios/editar/${funcionario.id}" method="POST">
            <input type="hidden" name="action" value="atualizar">
            <input type="hidden" name="id" value="${funcionario.id}">

            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="${funcionario.nome}" class="form-control" required><br>
            </div>

            <div class="form-group">
                <label for="cargo">Cargo:</label>
                <input type="text" id="cargo" name="cargo" value="${funcionario.cargo}" class="form-control"><br>
            </div>

            <div class="form-group">
                <label for="admin">Admin:</label>
                <input type="checkbox" id="admin" name="admin" ${funcionario.admin ? 'checked' : ''}><br>
            </div>

            <div class="form-group">
                <label for="login">Login:</label>
                <input type="text" id="login" name="login" value="${funcionario.login}" class="form-control" required><br>
            </div>

            <div class="form-group">
                <label for="senha">Senha:</label>
                <input type="password" id="senha" name="senha" value="${funcionario.senha}" class="form-control"><br>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${funcionario.email}" class="form-control" required><br>
            </div>

            <div class="form-group">
                <label for="telefone">Telefone:</label>
                <input type="text" id="telefone" name="telefone" value="${funcionario.telefone}" class="form-control" required><br>
            </div>

            <div class="form-group">
                <label for="endereco">Endereço:</label>
                <input type="text" id="endereco" name="endereco" value="${funcionario.endereco}" class="form-control" required><br>
            </div>

            <div class="form-group">
                <label for="salario">Salário:</label>
                <input type="text" id="salario" name="salario" value="${funcionario.salario}" class="form-control" required><br>
            </div>

            <button type="submit" class="btn btn-primary">Atualizar</button>
        </form>

        <a class="back-link" href="/app_bic/principal">&lt; Voltar para a página inicial</a>
    </c:if>
    <c:if test="${funcionario == null}">
        <p>Funcionário não encontrado</p>
    </c:if>
</div>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
