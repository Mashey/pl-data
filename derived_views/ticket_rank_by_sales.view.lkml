view: ticket_rank_by_sales {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.ticket_rank_by_sales`
    ;;

  dimension: pk {
    type: number
    primary_key: yes
    hidden: yes
    sql: concat(${ticketid},${customer_uuid},${total_net_sales}) ;;
  }

  dimension: count_orders {
    type: number
    sql: ${TABLE}.count_orders ;;
  }

  dimension: customer_uuid {
    type: string
    sql: ${TABLE}.customer_uuid ;;
  }

  dimension_group: date_time_closed {
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
    sql: ${TABLE}.date_time_closed ;;
  }

  dimension: distinct_customers {
    type: number
    sql: ${TABLE}.distinct_customers ;;
  }

  dimension: total_net_sales {
    type: number
    sql: ${TABLE}.total_net_sales ;;
  }

  dimension: ticket_rank_by_sale_price {
    type: number
    sql: ${TABLE}.ticket_rank_by_sale_price ;;
  }

  dimension: ticket_sequence_number {
    type: number
    sql: ${TABLE}.ticket_sequence_number ;;
  }

  dimension: ticketid {
    type: string
    sql: ${TABLE}.ticketid ;;
  }

  dimension: is_first_purchase {
    type: yesno
    sql: ${ticket_sequence_number} = 1 ;;
  }

  dimension: customer_ticket_rank_status {
    type: string
    sql: ${TABLE}.customer_ticket_rank_status ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }

  measure: avg_sequence_order_value {
    label: "Average Order Value (Sequence)"
    type: average
    sql: ${total_net_sales} ;;
    value_format: "$#,##0.00"
  }
}
