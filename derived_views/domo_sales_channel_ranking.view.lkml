view: domo_sales_channel_ranking {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.domo_sales_channel_ranking`
    ;;

  dimension: sales_channel_ranking {
    type: number
    sql: ${TABLE}.sales_channel_ranking ;;
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

  dimension: ticket_count {
    type: number
    sql: ${TABLE}.count ;;
  }

  dimension: ticket_type {
    type: string
    sql: ${TABLE}.ticket_type ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }

  measure: total_ticket_count {
    type: sum
    value_format: "#,##0"
    sql: ${ticket_count} ;;
  }

  measure: distinct_customers {
    type: count_distinct
    value_format: "#,##0"
    sql: ${customer_uuid} ;;
  }
}
