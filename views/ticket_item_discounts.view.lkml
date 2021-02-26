view: ticket_item_discounts {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.ticket_item_discounts`
    ;;
  drill_fields: [id]

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${product_id}, ${ticket_id}, ${discount_title}, ${discount_category}, ${discount_amount}, ${discount_method}) ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: cart {
    type: yesno
    sql: ${TABLE}.cart ;;
  }

  dimension: discount_amount {
    type: number
    sql: ${TABLE}.discount_amount ;;
  }

  dimension: discount_category {
    type: string
    sql: ${TABLE}.discount_category ;;
  }

  dimension: discount_method {
    type: string
    sql: ${TABLE}.discount_method ;;
  }

  dimension: discount_title {
    type: string
    sql: ${TABLE}.discount_title ;;
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

  dimension: product_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension: savings {
    type: number
    sql: ${TABLE}.savings ;;
  }

  dimension: ticket_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.ticket_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, products.product_id, tickets.cash_drawer_name, tickets.ticket_id]
  }
}
