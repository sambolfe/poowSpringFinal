<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.webjava.model.Vendas" %>
<%@ page import="com.webjava.model.Cliente" %>
<%@ page import="com.webjava.model.Produto" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<% String username = (String) request.getSession().getAttribute("username"); %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Editar Venda</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

  <style>
    body {
      padding-top: 70px;
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
        <a class="nav-link" href="index.jsp">Sair</a>
      </li>
    </ul>
  </div>
</nav>

<div class="container">
  <h2>Editar Venda</h2>

  <c:if test="${not empty mensagemErro}">
    <div class="alert alert-danger">
        ${mensagemErro}
    </div>
  </c:if>

  <form action="/app_bic/vendas/editar/${venda.id}" method="POST">
    <input type="hidden" name="id" value="${venda.id}">

    <div class="form-group">
      <label for="clienteId">Cliente:</label>
      <select class="form-control" id="clienteId" name="cliente.id">
        <c:forEach var="cliente" items="${clientes}">
          <option value="${cliente.id}" <c:if test="${cliente.id == venda.cliente.id}">selected</c:if>>${cliente.nome}</option>
        </c:forEach>
      </select>
    </div>

    <div class="form-group">
      <label for="produtoId">Produto:</label>
      <select class="form-control" id="produtoId" name="produto.id">
        <c:forEach var="produto" items="${produtos}">
          <option value="${produto.id}" <c:if test="${produto.id == venda.produto.id}">selected</c:if>>${produto.nome}</option>
        </c:forEach>
      </select>
    </div>

    <div class="form-group">
      <label for="quantidade">Quantidade:</label>
      <input type="number" class="form-control" id="quantidade" name="quantidade" value="${venda.quantidade}" required>
    </div>

    <div class="form-group">
      <label for="precoUnitario">Preço Unitário:</label>
      <input type="number" class="form-control" id="precoUnitario" name="precoUnitario" value="${venda.precoUnitario}" step="0.01" required>
    </div>

    <div class="form-group">
      <label for="dataVenda">Data de Venda:</label>
      <input type="date" id="dataVenda" name="dataVenda" value="${venda.data}">
    </div>

    <button type="submit" class="btn btn-primary">Atualizar</button>
  </form>

  <a class="back-link" href="/app_bic/principal">&lt; Voltar para a página inicial</a>
</div>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>