include: "/domo_views/core_domo_ticket_items.view"

view: brand_exclusivity {
  derived_table: {
    sql: with focusbrand as
(
select distinct customer_uuid
from `fivetran-purple-lotus-warehous.dbt.core_domo_ticket_items`
where
  {% condition product_brand %} productbrand {% endcondition %}
  AND {% condition date_time_closed %} date_time_closed {% endcondition %}
),

otherbrands as
(
select distinct customer_uuid
from `fivetran-purple-lotus-warehous.dbt.core_domo_ticket_items`
where
  NOT {% condition product_brand %} productbrand {% endcondition %}
  AND {% condition date_time_closed %} date_time_closed {% endcondition %}
)

select s.customer_uuid
from focusbrand s
left join otherbrands o on o.customer_uuid = s.customer_uuid
where o.customer_uuid is null ;;
  }

  dimension: customer_uuid {
    sql: ${TABLE}.customer_uuid ;;
    type: string
    primary_key: yes
  }

  filter: product_brand {
    type: string
    suggest_explore: core_domo_ticket_items
    suggest_dimension: core_domo_ticket_items.productbrand
  }

  filter: date_time_closed {
    type: date_time
  }
}
