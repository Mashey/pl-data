view: domo_sales_channel_ranking {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.domo_sales_channel_ranking`
    ;;

  dimension: brand_ranking {
    type: number
    sql: ${TABLE}.brand_ranking ;;
  }

  dimension: customer_uuid {
    type: string
    sql: ${TABLE}.customer_uuid ;;
  }

  dimension: pk {
    type: string
    sql: ${TABLE}.PK ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: ticket_type {
    type: string
    sql: ${TABLE}.ticket_type ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_quantity {
    type: sum
    value_format: "0.00"
    sql: ${quantity} ;;
  }
}
