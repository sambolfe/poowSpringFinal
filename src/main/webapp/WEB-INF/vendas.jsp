<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.webjava.model.Produto" %>
<%@ page import="com.webjava.model.Cliente" %>
<%@ page import="com.webjava.model.Vendas" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<% String username = (String) request.getSession().getAttribute("username"); %>

<!DOCTYPE html>
<html>
<head>
  <title>Lista de Vendas</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
        <a class="nav-link" href="/app_bic/login/logout">Sair</a>
      </li>
    </ul>
  </div>
</nav>
<div class="container mt-5">

  <div class="form-container">
    <h2>Adicionar nova Venda:</h2>
    <c:if test="${not empty mensagemSucesso}">
      <div class="alert alert-success">${mensagemSucesso}</div>
    </c:if>
    <c:if test="${not empty mensagemErro}">
      <div class="alert alert-danger">${mensagemErro}</div>
    </c:if>

    <form action="/app_bic/vendas/adicionar" method="POST">
      <input type="hidden" name="action" value="adicionar">
      <div class="form-group">
        <label for="clienteId">Cliente:</label>
        <select id="clienteId" name="clienteId" required class="form-control">
          <option value="">Selecione o cliente</option>
          <c:forEach var="cliente" items="${clientes}">
            <option value="${cliente.id}">${cliente.nome}</option>
          </c:forEach>
        </select>
      </div>
      <div class="form-group">
        <label for="produtoId">Produto:</label>
        <select id="produtoId" name="produtoId" required class="form-control">
          <option value="">Selecione o produto</option>
          <c:forEach var="produto" items="${produtos}">
            <option value="${produto.id}">${produto.nome}</option>
          </c:forEach>
        </select>
      </div>
      <div class="form-group">
        <label for="quantidade">Quantidade:</label>
        <input type="number" id="quantidade" name="quantidade" required class="form-control">
      </div>
      <div class="form-group">
        <label for="precoUnitario">Preço Unitário:</label>
        <input type="number" step="0.01" id="precoUnitario" name="precoUnitario" required class="form-control">
      </div>
      <div class="form-group">
        <label for="dataVenda">Data de Venda:</label>
        <input type="date" id="dataVenda" name="dataVenda" required class="form-control">
      </div>
      <input type="submit" value="Adicionar" class="btn btn-primary">
    </form>
  </div>

  <a class="back-link mt-3" href="/app_bic/principal">&lt; Voltar para a página inicial</a>

  <div class="mt-3">
    <h2>Lista de Vendas</h2>
    <p>Número de vendas realizadas: ${vendas.size()}</p>

    <table class="table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Cliente</th>
        <th>Produto</th>
        <th>Quantidade</th>
        <th>Preço Unitário</th>
        <th>Valor Total</th>
        <th>Data de Venda</th>
        <th>Ações</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="venda" items="${vendas}">
        <tr>
          <td>${venda.id}</td>
          <td>${venda.cliente.nome}</td>
          <td>${venda.produto.nome}</td>
          <td>${venda.quantidade}</td>
          <td>${venda.precoUnitario}</td>
          <td>${venda.valorTotal}</td>
          <td>${venda.data}</td>
          <td>
            <a href="/app_bic/vendas/editarVenda/${venda.id}" class="btn btn-sm btn-primary">Editar</a>
            <a href="/app_bic/vendas/excluir/${venda.id}" class="btn btn-sm btn-danger" onclick="return confirm('Tem certeza que deseja excluir esta venda?')">Excluir</a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
