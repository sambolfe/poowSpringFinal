<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.webjava.model.Produto" %>
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
    <title>Editar Produto</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<style>
    body {
        padding-top: 70px;
    }
</style>
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
    <h1>Editar Produto</h1>

    <c:if test="${produto != null}">
        <form action="/app_bic/produtos/editar/${produto.id}" method="POST">
            <input type="hidden" name="action" value="atualizar">
            <input type="hidden" name="id" value="${produto.id}"><br>

            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" name="nome" id="nome" value="${produto.nome}" class="form-control" required><br>
            </div>

            <div class="form-group">
                <label for="descricao">Descrição:</label>
                <textarea name="descricao" id="descricao" class="form-control" required>${produto.descricao}</textarea><br>
            </div>

            <div class="form-group">
                <label for="preco">Preço:</label>
                <input type="text" name="preco" id="preco" value="${produto.preco}" class="form-control" required><br>
            </div>

            <div class="form-group">
                <label for="quantidade">Quantidade:</label>
                <input type="text" name="quantidade" id="quantidade" value="${produto.quantidade}" class="form-control" required><br>
            </div>

            <button type="submit" class="btn btn-primary">Atualizar</button>
        </form>

        <a class="back-link" href="/app_bic/principal">&lt; Voltar para a página inicial</a>
    </c:if>
    <c:if test="${produto == null}">
        <p>Produto não encontrado</p>
    </c:if>
</div>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
