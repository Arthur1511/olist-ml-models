WITH tb_join AS (
    SELECT t1.dtPedido, t3.idVendedor, t2.*

    FROM pedido AS t1

    LEFT JOIN pagamento_pedido AS t2
    ON t1.idPedido = t2.idPedido

    LEFT JOIN item_pedido AS t3
    ON t1.idPedido = t3.idPedido

    WHERE t1.dtPedido < '2018-01-01' AND t1.dtPedido >='2017-06-01' AND t3.idVendedor not NULL
),

tb_group AS (
    SELECT idVendedor, 
    descTipoPagamento, 
    count(DISTINCT idPedido) AS qtdPedidoMeioPagamento,
    sum(vlPagamento) AS vlPedidoMeioPagamento

    FROM tb_join

    GROUP BY idVendedor, descTipoPagamento
    ORDER BY idVendedor, descTipoPagamento
)

SELECT idVendedor,

    sum(case when descTipoPagamento='boleto' then qtdPedidoMeioPagamento else 0 end) as qtd_boleto_pedido,
    sum(case when descTipoPagamento='credit_card' then qtdPedidoMeioPagamento else 0 end) as qtd_credit_card_pedido,
    sum(case when descTipoPagamento='voucher' then qtdPedidoMeioPagamento else 0 end) as qtd_voucher_pedido,
    sum(case when descTipoPagamento='debit_card' then qtdPedidoMeioPagamento else 0 end) as qtd_debit_card_pedido,

    sum(case when descTipoPagamento='boleto' then vlPedidoMeioPagamento else 0 end) as valor_boleto_pedido,
    sum(case when descTipoPagamento='credit_card' then vlPedidoMeioPagamento else 0 end) as valor_credit_card_pedido,
    sum(case when descTipoPagamento='voucher' then vlPedidoMeioPagamento else 0 end) as valor_voucher_pedido,
    sum(case when descTipoPagamento='debit_card' then vlPedidoMeioPagamento else 0 end) as valor_debit_card_pedido,

    sum(case when descTipoPagamento='boleto' then qtdPedidoMeioPagamento else 0 end) / sum(qtdPedidoMeioPagamento) as pct_qtd_boleto_pedido,
    sum(case when descTipoPagamento='credit_card' then qtdPedidoMeioPagamento else 0 end) / sum(qtdPedidoMeioPagamento) as pct_qtd_credit_card_pedido,
    sum(case when descTipoPagamento='voucher' then qtdPedidoMeioPagamento else 0 end) / sum(qtdPedidoMeioPagamento) as pct_qtd_voucher_pedido,
    sum(case when descTipoPagamento='debit_card' then qtdPedidoMeioPagamento else 0 end) / sum(qtdPedidoMeioPagamento) as pct_qtd_debit_card_pedido,

    sum(case when descTipoPagamento='boleto' then vlPedidoMeioPagamento else 0 end) / sum(vlPedidoMeioPagamento) as pct_valor_boleto_pedido,
    sum(case when descTipoPagamento='credit_card' then vlPedidoMeioPagamento else 0 end) / sum(vlPedidoMeioPagamento) as pct_valor_credit_card_pedido,
    sum(case when descTipoPagamento='voucher' then vlPedidoMeioPagamento else 0 end) / sum(vlPedidoMeioPagamento) as pct_valor_voucher_pedido,
    sum(case when descTipoPagamento='debit_card' then vlPedidoMeioPagamento else 0 end) / sum(vlPedidoMeioPagamento) as pct_valor_debit_card_pedido

 FROM tb_group

 GROUP BY idVendedor