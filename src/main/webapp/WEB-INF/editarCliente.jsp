<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.webjava.model.Cliente" %>
<%@ page import="com.webjava.dao.ClienteDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<% String username = (String) request.getSession().getAttribute("username"); %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Cliente</title>
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

            // Máscara para CPF
            $('#cpf').inputmask('999.999.999-99');
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
    <h1>Editar Cliente</h1>

    <c:if test="${cliente != null}">
        <form action="/app_bic/clientes/editar/${cliente.id}" method="post">
            <input type="hidden" name="action" value="atualizar">
            <input type="hidden" name="id" value="${cliente.id}">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="${cliente.nome}" required class="form-control"><br>
            </div>

            <div class="form-group">
                <label for="endereco">Endereço:</label>
                <input type="text" id="endereco" name="endereco" value="${cliente.endereco}" required class="form-control"><br>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" name="email" id="email" value="${cliente.email}" required class="form-control"><br>
            </div>

            <div class="form-group">
                <label for="telefone">Telefone:</label>
                <input type="text" id="telefone" name="telefone" value="${cliente.telefone}" required class="form-control"><br>
            </div>

            <div class="form-group">
                <label for="cpf">CPF:</label>
                <input type="text" id="cpf" name="cpf" value="${cliente.cpf}" required class="form-control"><br>
            </div>

            <input type="submit" value="Atualizar" class="btn btn-primary">
        </form>

        <a class="back-link" href="/app_bic/principal">&lt; Voltar para a página inicial</a>

    </c:if>
    <c:if test="${cliente == null}">
        <p>Cliente não encontrado</p>
    </c:if>
</div>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
