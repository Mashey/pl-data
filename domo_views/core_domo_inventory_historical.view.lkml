view: core_domo_inventory_historical {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.core_domo_inventory_historical`
    ;;

  dimension: accepted_date {
    type: string
    sql: ${TABLE}.accepted_date ;;
  }

  dimension: available_units {
    hidden: yes
    type: number
    sql: ${TABLE}.available_units ;;
  }

  dimension: cost_per_unit {
    type: number
    sql: ${TABLE}.cost_per_unit ;;
  }

  dimension: cost_per_unit_with_excise {
    type: number
    sql: ${TABLE}.cost_per_unit_with_excise ;;
  }

  dimension: days_aged {
    type: number
    sql: ${TABLE}.days_aged ;;
  }

  dimension: excise_tax_per_unit {
    type: number
    sql: ${TABLE}.excise_tax_per_unit ;;
  }

  dimension_group: inventory_valuation {
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
    convert_tz: no
    sql: ${TABLE}.inventory_valuation_date ;;
  }

  dimension: invoice_id {
    type: string
    sql: ${TABLE}.invoice_id ;;
  }

  dimension: location_name {
    type: string
    sql: ${TABLE}.location_name ;;
  }

  dimension: packed_and_ready_units {
    hidden: yes
    type: number
    sql: ${TABLE}.packed_and_ready_units ;;
  }

  dimension: pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.pk ;;
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

  dimension: producttype {
    type: string
    sql: ${TABLE}.producttype ;;
  }

  dimension: reserved_units {
    hidden: yes
    type: number
    sql: ${TABLE}.reserved_units ;;
  }

  dimension: state_tracking_id {
    type: string
    sql: ${TABLE}.state_tracking_id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: total_cost {
    hidden: yes
    type: number
    sql: ${TABLE}.total_cost ;;
  }

  dimension: total_cost_with_excise {
    hidden: yes
    type: number
    sql: ${TABLE}.total_cost_with_excise ;;
  }

  dimension: unit_of_measure {
    type: string
    sql: ${TABLE}.unit_of_measure ;;
  }

  dimension: weighted_days_aged {
    type: number
    sql: ${TABLE}.weighted_days_aged ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [location_name, productname]
  }

  measure: total_available_units {
    type: sum
    value_format: "#,##0"
    sql: ${available_units} ;;
  }

  measure: total_packed_and_ready_units {
    type: sum
    value_format: "#,##0"
    sql: ${packed_and_ready_units} ;;
  }

  measure: total_reserved_units {
    type: sum
    value_format: "#,##0"
    sql: ${reserved_units} ;;
  }

  measure: total_units {
    type: number
    value_format: "#,##0"
    sql: ${total_available_units}+${total_packed_and_ready_units}+${total_reserved_units} ;;
  }

  measure: total_cost_without_excise_tax {
    type: sum
    value_format: "$#,##0.00"
    sql: ${total_cost} ;;
  }

  measure: total_cost_with_excise_tax {
    type: sum
    value_format: "$#,##0.00"
    sql: ${total_cost_with_excise} ;;
  }

  measure: average_days_aged {
    type: average
    value_format: "#,##0"
    sql: ${days_aged} ;;
  }

  measure: sku_count {
    description: "Sku count by unique name/brand"
    type: count_distinct
    value_format: "#,##0"
    sql: CONCAT(${productname},${productbrand},${product_id}) ;;
    filters: [available_units: ">0"]
  }

  measure: brand_count {
    description: "Count of all brands"
    type: count_distinct
    value_format: "#,##0"
    sql: ${productbrand} ;;
    filters: [available_units: ">0"]
  }
}
