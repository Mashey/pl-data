view: dim_products {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.dim_products`
    ;;

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

  dimension: product_status {
    type: string
    sql: ${TABLE}.product_status ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  dimension: sellable_quantity {
    type: number
    sql: ${TABLE}.sellable_quantity ;;
  }

  measure: count {
    type: count
    drill_fields: [product_name]
  }
}
