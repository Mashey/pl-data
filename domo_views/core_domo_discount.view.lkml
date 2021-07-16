view: core_domo_discount {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.core_domo_discount`
    ;;

  dimension: cashier {
    type: string
    sql: ${TABLE}.cashier ;;
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

  dimension: discount_amount {
    type: number
    sql: ${TABLE}.discount_amount ;;
  }

  dimension: discount_method {
    type: string
    sql: ${TABLE}.discount_method ;;
  }

  dimension: discount_reason {
    type: string
    sql: ${TABLE}.discount_reason ;;
  }

  dimension: discount_title {
    type: string
    sql: ${TABLE}.discount_title ;;
  }

  dimension: discount_type {
    type: string
    sql: ${TABLE}.discount_type ;;
  }

  dimension: distributor {
    type: string
    sql: ${TABLE}.distributor ;;
  }

  dimension: net_sales {
    type: number
    sql: ${TABLE}.net_sales ;;
  }

  dimension: price_per_unit_after_discount {
    type: number
    sql: ${TABLE}.price_per_unit_after_discount ;;
  }

  dimension: price_per_unit_difference {
    type: number
    sql: ${TABLE}.price_per_unit_difference ;;
  }

  dimension: priceperunit {
    type: number
    sql: ${TABLE}.priceperunit ;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: productname {
    type: string
    sql: ${TABLE}.productname ;;
  }

  dimension: productsubtype {
    type: string
    sql: ${TABLE}.productsubtype ;;
  }

  dimension: producttype {
    type: string
    sql: ${TABLE}.producttype ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: salestax {
    type: number
    sql: ${TABLE}.salestax ;;
  }

  dimension: size {
    type: string
    sql: ${TABLE}.size ;;
  }

  dimension: ticket_id {
    type: string
    sql: ${TABLE}.ticket_id ;;
  }

  dimension: ticketlineid {
    primary_key: yes
    type: string
    sql: ${TABLE}.ticketlineid ;;
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

  measure: total_discount_amount {
    type: sum
    value_format: "$#.00;($#.00)"
    sql: ${discount_amount} ;;
    drill_fields: [ticket_id, discount_amount, discount_title, core_domo_ticket_items.net_sales, core_domo_ticket_items.discount_rate, cashier, customer_uuid, core_domo_customers.first_name, core_domo_customers.last_name, core_domo_customers.groupnames]
  }
}
