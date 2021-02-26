view: products {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.products`
    ;;
  drill_fields: [product_id]

  dimension: product_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: category_type {
    type: string
    sql: ${TABLE}.category_type ;;
  }

  dimension_group: last_updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_updated_at ;;
  }

  dimension: product_status {
    type: string
    sql: ${TABLE}.product_status ;;
  }

  dimension: sellable_quantity {
    type: number
    sql: ${TABLE}.sellable_quantity ;;
  }

  measure: count {
    type: count
    drill_fields: [product_id, ticket_item_taxes.count, ticket_items.count, ticket_item_discounts.count]
  }
}
