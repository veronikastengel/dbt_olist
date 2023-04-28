{{ config(materialized='view') }}

with source_data as (

    SELECT 'tbl_olist_sellers' as tbl_name, row_cnt, col_cnt FROM 
        (SELECT count(*) row_cnt FROM olist.tbl_olist_sellers) c1,
        (SELECT count(*) col_cnt FROM information_schema.columns WHERE table_name = 'tbl_olist_sellers') c2
    UNION ALL
    SELECT 'tbl_olist_products' as tbl_name, row_cnt, col_cnt FROM 
        (SELECT count(*) row_cnt FROM olist.tbl_olist_products) c1,
        (SELECT count(*) col_cnt FROM information_schema.columns WHERE table_name = 'tbl_olist_products') c2
    UNION ALL
    SELECT 'tbl_olist_orders' as tbl_name, row_cnt, col_cnt FROM 
        (SELECT count(*) row_cnt FROM olist.tbl_olist_orders) c1,
        (SELECT count(*) col_cnt FROM information_schema.columns WHERE table_name = 'tbl_olist_orders') c2
    UNION ALL
    SELECT 'tbl_olist_order_reviews' as tbl_name, row_cnt, col_cnt FROM 
        (SELECT count(*) row_cnt FROM olist.tbl_olist_order_reviews) c1,
        (SELECT count(*) col_cnt FROM information_schema.columns WHERE table_name = 'tbl_olist_order_reviews') c2
    UNION ALL
    SELECT 'tbl_olist_order_payments' as tbl_name, row_cnt, col_cnt FROM 
        (SELECT count(*) row_cnt FROM olist.tbl_olist_order_payments) c1,
        (SELECT count(*) col_cnt FROM information_schema.columns WHERE table_name = 'tbl_olist_order_payments') c2
    UNION ALL
    SELECT 'tbl_olist_order_items' as tbl_name, row_cnt, col_cnt FROM 
        (SELECT count(*) row_cnt FROM olist.tbl_olist_order_items) c1,
        (SELECT count(*) col_cnt FROM information_schema.columns WHERE table_name = 'tbl_olist_order_items') c2
    UNION ALL
    SELECT 'tbl_olist_geolocation' as tbl_name, row_cnt, col_cnt FROM 
        (SELECT count(*) row_cnt FROM olist.tbl_olist_geolocation) c1,
        (SELECT count(*) col_cnt FROM information_schema.columns WHERE table_name = 'tbl_olist_geolocation') c2
    UNION ALL
    SELECT 'tbl_olist_customers' as tbl_name, row_cnt, col_cnt FROM 
        (SELECT count(*) row_cnt FROM olist.tbl_olist_customers) c1,
        (SELECT count(*) col_cnt FROM information_schema.columns WHERE table_name = 'tbl_olist_customers') c2   
    UNION ALL
    SELECT 'tbl_product_category_name_translation' as tbl_name, row_cnt, col_cnt FROM 
        (SELECT count(*) row_cnt FROM olist.tbl_product_category_name_translation) c1,
        (SELECT count(*) col_cnt FROM information_schema.columns WHERE table_name = 'tbl_product_category_name_translation') c2     

)

select *
from source_data