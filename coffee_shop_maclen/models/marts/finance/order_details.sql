with order_items as (
    select * from {{ ref('stg_coffee_shop__order_items')}}
),

orders as (
    select * from {{ ref('stg_coffee_shop__orders')}}
),

product_prices as (
    select * from {{ ref('stg_coffee_shop__product_prices')}}
),

renamed as (
    select
        order_items.order_item_id,
        order_items.order_id,
        order_items.product_id,
        orders.customer_id,
        product_prices.price,
        row_number() over(partition by orders.order_id order by orders.created_at asc) = 1 as is_first_order,
        orders.created_at,
    from order_items
    left join orders using (order_id)
    left join product_prices 
        on order_items.product_id = product_prices.product_id
        and orders.created_at between product_prices.created_at and coalesce(product_prices.ended_at,'2099-01-01')
)

select * from renamed