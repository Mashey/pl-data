view: core_domo_inventory {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.core_domo_inventory`
    ;;

  dimension: pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.pk ;;
  }

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

  dimension: days_aged_tiers {
    type: tier
    tiers: [1,31,61,91,121]
    style: integer
    sql: ${days_aged} ;;
  }

  dimension: excise_tax_per_unit {
    type: number
    sql: ${TABLE}.excise_tax_per_unit ;;
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

  dimension: total_units {
    hidden: yes
    type: number
    sql: ${available_units} + ${reserved_units} + ${packed_and_ready_units} ;;
  }

  dimension: unit_of_measure {
    type: string
    sql: ${TABLE}.unit_of_measure ;;
  }

  dimension: weighted_days_aged {
    hidden: yes
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

  measure: total_reserved_units {
    type: sum
    value_format: "#,##0"
    sql: ${reserved_units} ;;
  }

  measure: total_packed_and_ready_units {
    type: sum
    value_format: "#,##0"
    sql: ${packed_and_ready_units} ;;
  }

  measure: sum_total_units {
    type: sum
    value_format: "#,##0"
    sql: ${total_units} ;;
    drill_fields: [core_domo_ticket_items.ticketid]
  }

  measure: total_inventory_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${total_cost} ;;
  }

  measure: total_inventory_cost_with_excise {
    type: sum
    value_format: "$#,##0.00"
    sql: ${total_cost_with_excise} ;;
  }

  measure: average_inventory_days_aged {
    type: average
    value_format: "#,##0"
    sql: ${days_aged} ;;
  }

  measure: average_weighted_days_aged{
    hidden: yes
    type: average
    value_format: "#,##0"
    sql: ${weighted_days_aged} ;;
  }


}
