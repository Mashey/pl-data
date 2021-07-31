view: domo_subtype_ranking {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.domo_subtype_ranking`
    ;;

  dimension: customer_uuid {
    type: string
    sql: ${TABLE}.customer_uuid ;;
  }

  dimension: pk {
    type: string
    sql: ${TABLE}.PK ;;
  }

  dimension: product_subtype {
    type: string
    sql: ${TABLE}.product_subtype ;;
  }

  dimension: product_subtype_ranking {
    type: number
    sql: ${TABLE}.product_subtype_ranking ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_quantity {
    type: sum
    value_format: "#,##0"
    sql: ${quantity} ;;
  }
}
