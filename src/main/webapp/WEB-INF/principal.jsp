<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.webjava.dao.FuncionarioDAO" %>
<%@ page import="com.webjava.model.Funcionario" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String username = (String) session.getAttribute("username");
    boolean isAdmin = (boolean) session.getAttribute("admin");
%>
<html>
<head>
    <title>Página Inicial</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f1f1f1;
        }

        .grid-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            grid-gap: 20px;
            text-align: center;
        }

        .item {
            background-color: #fff;
            padding: 20px;
        }
    </style>
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

<div class="grid-container">
    <% if (isAdmin) { %>
    <div class="item">
        <h2>Gerenciamento de Clientes</h2>
        <a href="/app_bic/clientes" class="btn btn-primary">Gerenciar Clientes</a>
    </div>
    <div class="item">
        <h2>Gerenciamento de Vendas</h2>
        <a href="/app_bic/vendas" class="btn btn-primary">Gerenciar Vendas</a>
    </div>
    <div class="item">
        <h2>Gerenciamento de Funcionários</h2>
        <a href="/app_bic/funcionarios" class="btn btn-primary">Gerenciar Funcionários</a>
    </div>
    <div class="item">
        <h2>Gerenciamento de Produtos</h2>
        <a href="/app_bic/produtos" class="btn btn-primary">Gerenciar Produtos</a>
    </div>
    <% } else { %>
    <div class="item">
        <h2>Gerenciamento de Vendas</h2>
        <a href="/app_bic/vendas" class="btn btn-primary">Gerenciar Vendas</a>
    </div>
    <div class="item">
        <h2>Gerenciamento de Produtos</h2>
        <a href="/app_bic/produtos" class="btn btn-primary">Gerenciar Produtos</a>
    </div>
    <div class="item">
        <h2>Gerenciamento de Clientes</h2>
        <a href="/app_bic/clientes" class="btn btn-primary">Gerenciar Clientes</a>
    </div>
    <% } %>
</div>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
