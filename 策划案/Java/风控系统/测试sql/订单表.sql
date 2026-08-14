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




CREATE TABLE test_order_return_header (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',

    order_no VARCHAR(64) NOT NULL COMMENT '订单号',
    return_no VARCHAR(64) NOT NULL COMMENT '退货单号',

    total_amount DECIMAL(18, 2) NOT NULL DEFAULT 0.00 COMMENT '订单总金额',

    finish_time DATETIME DEFAULT NULL COMMENT '退货完成时间',

    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',

    PRIMARY KEY (id),
    UNIQUE KEY uk_order_no (order_no),
    UNIQUE KEY uk_return_no (return_no),
    KEY idx_finish_time (finish_time)
) COMMENT = '测试退货单头表';


CREATE TABLE test_order_return_detail (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',

    return_no VARCHAR(64) NOT NULL COMMENT '退货单号',

    goods_id BIGINT NOT NULL COMMENT '商品ID',
    sku_id BIGINT NOT NULL COMMENT 'SKU ID',
    goods_name VARCHAR(255) NOT NULL COMMENT '商品名称',

    sale_count INT NOT NULL DEFAULT 0 COMMENT 'SKU出售数量',
    order_amount DECIMAL(18, 2) NOT NULL DEFAULT 0.00 COMMENT '该SKU订单金额',

    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',

    PRIMARY KEY (id),

    KEY idx_return_no (return_no),
    KEY idx_goods_id (goods_id),
    KEY idx_sku_id (sku_id)
) COMMENT = '测试退货单明细表';


CREATE TABLE test_table_view_header (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',

    bill_no VARCHAR(64) NOT NULL COMMENT '单据号',

    status tinyint NOT NULL DEFAULT 1 COMMENT '单据状态，枚举',
    finish_time DATETIME DEFAULT NULL COMMENT '单据完成时间',
    order_idx int4 NOT NULL DEFAULT 0 COMMENT '排序号',
    system_id BIGINT NULL DEFAULT 0 COMMENT '租户id',


    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',

    PRIMARY KEY (id),
    UNIQUE KEY uk_test_table_view_header_order_no (order_no),
    KEY idx_test_table_view_header_finish_time (finish_time)
) COMMENT = '测试订单头表';


CREATE TABLE test_table_view_detail(
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    bill_no VARCHAR(64) NOT NULL COMMENT '单据号',

    dim_a varchar(32) NOT NULL DEFAULT 'DEFAULT' COMMENT '维度a',
    dim_b int NOT NULL DEFAULT 1 COMMENT '维度b-整数',
    dim_c tinyint NOT NULL DEFAULT 1 COMMENT '维度c-枚举',

    int_a int4 NULL COMMENT '整数a',
    int_b int4 NULL COMMENT '整数b',
    long_a int8 NULL COMMENT "长整数a",
    long_b int8 NULL COMMENT "长整数b",
    str_a varchar(1000) NULL COMMENT "字符串a,长度1000",
    str_b text NULL COMMENT "字符串b",
    date_time_a datetime NULL COMMENT "时间A",
    date_time_b datetime NULL COMMENT "时间B",
    double_a double null COMMENT "double a",
    float_a float null COMMENT "float a",
    number_2 DECIMAL(20,2) null COMMENT "2位小数变量",
    number_4 DECIMAL(20,4) null COMMENT "4位小数变量",
    number_6 DECIMAL(25,8) null COMMENT "8位小数变量",
    bool_a tinyint(1) null COMMENT "布尔变量a",
    bool_b tinyint(1) null COMMENT "布尔变量b",
    str_arr_a varchar(1024) null COMMENT "字符串数组a,长度1000",
    str_arr_a text null COMMENT "字符串数组a,长度不限",


    PRIMARY KEY (id),
    KEY idx_test_table_view_detail_bill_no (order_no),
    KEY idx_dima (dim_a),
    KEY idx_dimb (dim_b),
    KEY idx_dimc (dim_c)
)COMMENT = '测试订单明细表';