package com.webjava.model;

import java.util.Date;

public class Estoque {
    private int id;
    private int produtoId;
    private double quantidade;
    private Date dataAtualizacao;

    // Construtor
    public Estoque(int id, int produtoId, double quantidade, Date dataAtualizacao) {
        this.id = id;
        this.produtoId = produtoId;
        this.quantidade = quantidade;
        this.dataAtualizacao = dataAtualizacao;
    }

    // Construtor com parâmetro
    public Estoque(int produtoId, double quantidade) {
        this.produtoId = produtoId;
        this.quantidade = quantidade;
        this.dataAtualizacao = new Date(); // Data atual
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProdutoId() {
        return produtoId;
    }

    public void setProdutoId(int produtoId) {
        this.produtoId = produtoId;
    }

    public double getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(double quantidade) {
        this.quantidade = quantidade;
    }

}
