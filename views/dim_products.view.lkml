view: dim_products {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.dim_products`
    ;;

  dimension: classification {
    type: string
    sql: ${TABLE}.classification ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_date ;;
  }

  dimension: hidden_from_menu {
    type: yesno
    sql: ${TABLE}.hidden_from_menu ;;
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

  dimension: price_type {
    type: string
    sql: ${TABLE}.price_type ;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension: product_status {
    type: string
    sql: ${TABLE}.product_status ;;
  }

  dimension: product_subtype {
    type: string
    sql: ${TABLE}.product_subtype ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  dimension: sell_price {
    type: number
    sql: ${TABLE}.sell_price ;;
  }

  dimension: sellable_quantity {
    type: number
    sql: ${TABLE}.sellable_quantity ;;
  }

  dimension: tier_name {
    type: string
    sql: ${TABLE}.tier_name ;;
  }

  dimension: unit_of_measure {
    type: string
    sql: ${TABLE}.unit_of_measure ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }

  measure: count {
    type: count
    drill_fields: [tier_name, product_name]
  }
}
