view: agg_domo_tickets {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.agg_domo_tickets`
    ;;

  dimension: cashier {
    type: string
    sql: ${TABLE}.cashier ;;
  }

  dimension: cbt_tax {
    hidden: yes
    type: number
    sql: ${TABLE}.cbt_tax ;;
  }

  dimension: cost {
    hidden: yes
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: cost_without_excise {
    hidden: yes
    type: number
    sql: ${TABLE}.cost_without_excise ;;
  }

  dimension: customer_uuid {
    type: string
    sql: ${TABLE}.customer_uuid ;;
  }

  dimension_group: date_closed {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      month_name,
      day_of_month,
      quarter,
      year,
      day_of_year
    ]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.date_closed ;;
  }

  dimension_group: date_opened {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_opened ;;
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

  dimension_group: date_time_opened {
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
    sql: ${TABLE}.date_time_opened ;;
  }

  dimension: discounts {
    hidden: yes
    type: number
    sql: ${TABLE}.discounts ;;
  }

  dimension: excise_tax {
    hidden: yes
    type: number
    sql: ${TABLE}.excise_tax ;;
  }

  dimension: gross_income {
    hidden: yes
    type: number
    sql: ${TABLE}.gross_income ;;
  }

  dimension: gross_receipts {
    hidden: yes
    type: number
    sql: ${TABLE}.gross_receipts ;;
  }

  dimension: gross_sales {
    hidden: yes
    type: number
    sql: ${TABLE}.gross_sales ;;
  }

  dimension: net_sales {
    hidden: yes
    type: number
    sql: ${TABLE}.net_sales ;;
  }

  dimension: quantity {
    hidden: yes
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: register {
    type: string
    sql: ${TABLE}.register ;;
  }

  dimension: returns_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.returns_amount ;;
  }

  dimension: sales_tax {
    hidden: yes
    type: number
    sql: ${TABLE}.sales_tax ;;
  }

  dimension: ticket_status {
    type: string
    sql: ${TABLE}.ticket_status ;;
  }

  dimension: ticket_type {
    type: string
    sql: ${TABLE}.ticket_type ;;
  }

  dimension: ticketid {
    primary_key: yes
    type: string
    sql: ${TABLE}.ticketid ;;
  }

  dimension: total_taxes {
    hidden: yes
    type: number
    sql: ${TABLE}.total_taxes ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }

  measure: total_cost_without_excise {
    type: sum
    value_format: "$#,##0.00"
    sql: ${cost_without_excise} ;;
  }

  measure: total_discounts {
    type: sum
    value_format: "$#,##0.00"
    sql: ${discounts} ;;
  }

  measure: total_excise_tax  {
    type: sum
    value_format: "$#,##0.00"
    sql: ${excise_tax} ;;
  }

  measure: total_gross_receipts {
    type: sum
    value_format: "$#,##0.00"
    sql: ${gross_receipts} ;;
  }

  measure: total_gross_sales {
    type: sum
    value_format: "$#,##0.00"
    sql: ${gross_sales}sales} ;;
  }

  measure: total_net_sales {
    type: sum
    value_format: "$#,##0.00"
    sql: ${net_sales} ;;
  }

  measure: total_quantity {
    type: sum
    value_format: "0.00"
    sql: ${quantity} ;;
  }

  measure: total_orders {
    type: count_distinct
    value_format: "0"
    sql: ${ticketid} ;;
  }

  measure: total_gross_profit {
    type: number
    value_format: "$#,##0.00"
    sql: ${total_net_sales}-${total_cost_without_excise};;
  }

  measure: gross_margin {
    type: number
    value_format: "0.0\%"
    sql: ${total_gross_profit}/${total_net_sales} ;;
  }

  measure: discount_rate {
    type: number
    value_format: "0.0\%"
    sql: ${total_discounts}/${total_gross_sales} ;;
  }

}
