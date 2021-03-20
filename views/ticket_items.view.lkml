view: ticket_items {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.ticket_items`
    ;;

  dimension: inventory_batch_id {
    type: string
    sql: ${TABLE}.inventory_batch_id ;;
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

  dimension: location_name {
    type: string
    sql: ${TABLE}.location_name ;;
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

  dimension: price_total {
    type: number
    sql: ${TABLE}.price_total ;;
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

  dimension: ticket_id {
    type: string
    sql: ${TABLE}.ticket_id ;;
  }

  measure: count {
    type: count
    drill_fields: [product_name, location_name]
  }

  measure: total_units_sold {
    type: sum
    value_format: "#,##0"
    sql: ${quantity};;
  }
}
