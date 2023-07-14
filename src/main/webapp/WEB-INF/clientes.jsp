<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.webjava.model.Cliente" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page session="false" %>
<% String username = (String) request.getSession().getAttribute("username"); %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Clientes</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/5.0.6/jquery.inputmask.min.js"></script>
    <style>
        body {
            padding-top: 70px;
        }
    </style>
    <script>
        function confirmExclusao(nomeCliente) {
            return confirm("Tem certeza que deseja excluir o cliente " + nomeCliente + "?");
        }

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
<div class="container mt-5">
    <h2>Adicionar Cliente</h2>
    <c:if test="${not empty mensagemSucesso}">
        <div class="alert alert-success">${mensagemSucesso}</div>
    </c:if>
    <form action="/app_bic/clientes/adicionar" method="post">
        <div class="form-group">
            <label for="nome">Nome:</label>
            <input type="text" class="form-control" id="nome" name="nome" required>
        </div>

        <div class="form-group">
            <label for="endereco">Endereço:</label>
            <input type="text" class="form-control" id="endereco" name="endereco" required>
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="text" class="form-control" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="telefone">Telefone:</label>
            <input type="text" class="form-control" id="telefone" name="telefone" required>
        </div>

        <div class="form-group">
            <label for="cpf">CPF:</label>
            <input type="text" class="form-control" id="cpf" name="cpf" required>
        </div>

        <button id="adicionarBtn" type="submit" class="btn btn-primary">Adicionar</button>

    </form>

    <a class="back-link" href="/app_bic/principal">&lt; Voltar para a página inicial</a>

    <h2>Lista de Clientes</h2>

    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Email</th>
            <th>Telefone</th>
            <th>Endereço</th>
            <th>CPF</th>
            <th>Ações</th>
        </tr>
        </thead>
        <tbody>
        Número de clientes: ${clientes.size()}
        <c:forEach var="cliente" items="${clientes}">
            <tr>
                <td>${cliente.id}</td>
                <td>${cliente.nome}</td>
                <td>${cliente.email}</td>
                <td>${cliente.telefone}</td>
                <td>${cliente.endereco}</td>
                <td>${cliente.cpf}</td>
                <td>
                    <a href="/app_bic/clientes/editarCliente/${cliente.id}" class="btn btn-sm btn-primary">Editar</a>
                    <a href="/app_bic/clientes/excluir/${cliente.id}" class="btn btn-sm btn-danger" onclick="return confirmExclusao('${cliente.nome}')">Excluir</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
