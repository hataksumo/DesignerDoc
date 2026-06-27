CREATE TABLE test_order_header (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',

    order_no VARCHAR(64) NOT NULL COMMENT '订单号',

    total_amount DECIMAL(18, 2) NOT NULL DEFAULT 0.00 COMMENT '订单总金额',

    finish_time DATETIME DEFAULT NULL COMMENT '订单完成时间',

    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',

    PRIMARY KEY (id),
    UNIQUE KEY uk_order_no (order_no),
    KEY idx_finish_time (finish_time)
) COMMENT = '测试订单头表';


CREATE TABLE test_order_detail (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',

    order_no VARCHAR(64) NOT NULL COMMENT '订单号',

    goods_id BIGINT NOT NULL COMMENT '商品ID',
    sku_id BIGINT NOT NULL COMMENT 'SKU ID',
    goods_name VARCHAR(255) NOT NULL COMMENT '商品名称',

    sale_count INT NOT NULL DEFAULT 0 COMMENT 'SKU出售数量',
    sku_unit_price DECIMAL(18, 2) NOT NULL DEFAULT 0.00 COMMENT 'SKU单价',
    order_amount DECIMAL(18, 2) NOT NULL DEFAULT 0.00 COMMENT '该SKU订单金额',

    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',

    PRIMARY KEY (id),

    KEY idx_order_no (order_no),
    KEY idx_goods_id (goods_id),
    KEY idx_sku_id (sku_id)
) COMMENT = '测试订单明细表';


