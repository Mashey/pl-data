view: ticket_items {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.ticket_items`
    ;;

  dimension_group: date_closed {
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

    sql: ${TABLE}.date_closed ;;
  }

  dimension: discounts {
    type: number
    sql: ${TABLE}.discounts ;;
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

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.PK ;;
  }

  dimension: price_sell {
    type: number
    sql: ${TABLE}.price_sell ;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  dimension: product_unit {
    type: string
    sql: ${TABLE}.product_unit ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: sell_price {
    type: number
    sql: ${TABLE}.sell_price ;;
  }

  dimension: ticket_id {
    type: string
    sql: ${TABLE}.ticket_id ;;
  }

  dimension: net_sales {
    type: number
    sql: ${price_sell}*${quantity} ;;
  }

  measure: total_net_sales {
    type: sum
    value_format_name: usd
    sql: ${net_sales} ;;
  }

  measure: count {
    type: count
    drill_fields: [product_name]
  }

  measure: total_quantity {
    type: sum
    value_format: "0.0"
    sql: ${quantity}  ;;
  }

}
