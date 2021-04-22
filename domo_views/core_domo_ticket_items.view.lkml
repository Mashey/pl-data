view: core_domo_ticket_items {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.core_domo_ticket_items`
    ;;

  dimension: cashier {
    type: string
    sql: ${TABLE}.cashier ;;
  }

  dimension: cbt_tax {
    type: number
    sql: ${TABLE}.cbt_tax ;;
  }

  dimension: classification {
    type: string
    sql: ${TABLE}.classification ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: cost_without_excise {
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
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
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
    type: number
    sql: ${TABLE}.discounts ;;
  }

  dimension: dynamic_tax {
    type: string
    sql: ${TABLE}.dynamic_tax ;;
  }

  dimension: excise_tax {
    type: number
    sql: ${TABLE}.excise_tax ;;
  }

  dimension: gross_income {
    type: number
    sql: ${TABLE}.gross_income ;;
  }

  dimension: gross_receipts {
    type: number
    sql: ${TABLE}.gross_receipts ;;
  }

  dimension: grosssales {
    type: number
    sql: ${TABLE}.grosssales ;;
  }

  dimension: is_arms_length {
    type: number
    sql: ${TABLE}.is_arms_length ;;
  }

  dimension: net_sales {
    type: number
    sql: ${TABLE}.net_sales ;;
  }

  dimension: priceunit {
    type: number
    sql: ${TABLE}.priceunit ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_subtype {
    type: string
    sql: ${TABLE}.product_subtype ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  dimension: productbrand {
    hidden: yes
    type: string
    sql: ${TABLE}.productbrand ;;
  }

  dimension: productname {
    type: string
    sql: ${TABLE}.productname ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: register {
    type: string
    sql: ${TABLE}.register ;;
  }

  dimension: retail_brand {
    label: "Product Brand"
    type: string
    sql: ${TABLE}.retail_brand ;;
  }

  dimension: returns_amount {
    type: number
    sql: ${TABLE}.returns_amount ;;
  }

  dimension: sales_tax {
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
    type: string
    sql: ${TABLE}.ticketid ;;
  }

  dimension: ticketlineid {
    primary_key: yes
    type: string
    sql: ${TABLE}.ticketlineid ;;
  }

  dimension: total_taxes {
    type: number
    sql: ${TABLE}.total_taxes ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: unitofmeasure {
    type: string
    sql: ${TABLE}.unitofmeasure ;;
  }

  dimension: weight {
    type: string
    sql: ${TABLE}.weight ;;
  }

  measure: count {
    type: count
    drill_fields: [productname]
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
    sql: ${grosssales} ;;
  }

  measure: total_net_sales {
    type: sum
    value_format: "$#,##0.00"
    sql: ${net_sales} ;;
  }

  measure: total_units_sold_net {
    type: sum
    value_format: "#,##0"
    sql: ${quantity} ;;
  }

  measure: total_units_sold_gross {
    type: sum
    value_format: "#,##0"
    sql: ${quantity} ;;
    filters: [type: "SALE"]
  }

  measure: total_units_returned {
    type: sum
    value_format: "#,##0"
    sql: ${quantity} * -1 ;;
    filters: [type: "RETURN"]
  }

  measure: total_gross_profit{
    type: number
    value_format: "$#,##0.00"
    sql: ${total_net_sales} - ${total_cost_without_excise} ;;
  }

  measure: gross_margin {
    type: number
    value_format_name: percent_2
    sql: ${total_gross_profit}/nullif(${total_net_sales},0) ;;
  }

  measure: discount_rate {
    type: number
    value_format_name: percent_2
    sql: ${total_discounts}/nullif(${total_gross_sales},0) ;;
  }

  measure: count_distinct_customers {
    type: count_distinct
    value_format: "#,##0"
    sql: ${customer_uuid} ;;
  }

  measure: total_orders {
    type: count_distinct
    value_format: "#,##0"
    sql: ${ticketid} ;;
  }

  measure: average_order_value {
    type: number
    value_format: "$#,##0.00"
    sql: ${total_net_sales} / nullif(${total_orders},0) ;;
  }

  measure: return_rate {
    type: number
    value_format_name: percent_1
    sql: ${total_units_returned} / nullif(${total_units_sold_gross},0) ;;
  }



 }
