view: core_domo_invoices {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.core_domo_invoices`
    ;;

  dimension_group: accepted_date {
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
    sql: ${TABLE}.accepted_date_time ;;
  }

  dimension: base_cost {
    type: number
    sql: ${TABLE}.base_cost ;;
  }

  dimension_group: created_date {
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
    sql: ${TABLE}.created_date_time ;;
  }

  dimension: discount {
    type: number
    sql: ${TABLE}.discount ;;
  }

  dimension: excise_tax {
    type: number
    sql: ${TABLE}.excise_tax ;;
  }

  dimension: invoice_id {
    type: string
    sql: ${TABLE}.invoice_id ;;
  }

  dimension: invoice_number {
    type: number
    sql: ${TABLE}.invoice_number ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: productbrand {
    type: string
    sql: ${TABLE}.productbrand ;;
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

  dimension: qty {
    type: number
    sql: ${TABLE}.qty ;;
  }

  dimension: total_cost {
    type: number
    sql: ${TABLE}.total_cost ;;
  }

  dimension: total_cost_final {
    type: number
    sql: ${TABLE}.total_cost_final ;;
  }

  dimension: total_final_cost {
    type: number
    sql: ${TABLE}.total_final_cost ;;
  }

  dimension: unitofmeasure {
    type: string
    sql: ${TABLE}.unitofmeasure ;;
  }

  dimension: vendorname {
    type: string
    sql: ${TABLE}.vendorname ;;
  }

  measure: count {
    type: count
    drill_fields: [productname, vendorname]
  }
}
