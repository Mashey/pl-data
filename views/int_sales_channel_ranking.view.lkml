view: int_sales_channel_ranking {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.int_sales_channel_ranking`
    ;;

  dimension: channel_count {
    type: number
    sql: ${TABLE}.channel_count ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: sales_channel_ranking {
    type: number
    sql: ${TABLE}.sales_channel_ranking ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
