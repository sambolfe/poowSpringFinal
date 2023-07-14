<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.webjava.model.Produto" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<% String username = (String) request.getSession().getAttribute("username"); %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Produtos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <style>
        body {
            padding-top: 70px;
        }
    </style>
    <script>
        function confirmExclusao(nomeProduto) {
            return confirm("Tem certeza que deseja excluir o produto " + nomeProduto + "?");
        }
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
    <h2>Adicionar novo produto:</h2>
    <c:if test="${not empty mensagemSucesso}">
        <p class="text-danger">${mensagemSucesso}</p>
    </c:if>
    <form action="/app_bic/produtos/adicionar" method="POST">
        <div class="form-group">
            <label for="nome">Nome:</label>
            <input type="text" class="form-control" id="nome" name="nome" required>
        </div>

        <div class="form-group">
            <label for="descricao">Descrição:</label>
            <textarea class="form-control" id="descricao" name="descricao" required></textarea>
        </div>

        <div class="form-group">
            <label for="preco">Preço:</label>
            <input type="number" class="form-control" id="preco" name="preco" step="0.01" required>
        </div>

        <div class="form-group">
            <label for="quantidade">Quantidade:</label>
            <input type="number" class="form-control" id="quantidade" name="quantidade" step="0.01" required>
        </div>

        <button type="submit" class="btn btn-primary">Adicionar</button>
    </form>

    <a class="back-link" href="/app_bic/principal">&lt; Voltar para a página inicial</a>

    <h2>Lista de Produtos</h2>

    <table class="table mt-3">
        <thead>
        <tr>
            <th>Nome</th>
            <th>Preço</th>
            <th>Descrição</th>
            <th>Quantidade</th>
            <th>Ações</th>
        </tr>
        </thead>

        <tbody>
        Número de produtos: ${produtos.size()}
        <c:forEach var="produto" items="${produtos}">
            <tr>
                <td>${produto.nome}</td>
                <td>${produto.preco}</td>
                <td>${produto.descricao}</td>
                <td>${produto.quantidade}</td>
                <td>
                    <a href="/app_bic/produtos/editarProduto/${produto.id}" class="btn btn-sm btn-primary">Editar</a>
                    <a href="/app_bic/produtos/excluir/${produto.id}" class="btn btn-sm btn-danger" onclick="return confirmExclusao('${produto.nome}')">Excluir</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
