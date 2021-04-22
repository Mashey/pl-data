
view: domo_product_ranking {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.domo_product_ranking`
    ;;

  dimension: product_ranking {
    type: number
    sql: ${TABLE}.product_ranking ;;
  }

  dimension: customer_uuid {
    type: string
    sql: ${TABLE}.customer_uuid ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.PK ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: retail_brand {
    label: "Product Brand"
    type: string
    sql: ${TABLE}.retail_brand ;;
  }

  measure: count {
    type: count
    drill_fields: [product_name]
  }

  measure: total_quantity {
    type: sum
    value_format: "0.00"
    sql: ${quantity}  ;;
  }
}
