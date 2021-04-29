view: dim_domo_current_inventory {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.dim_domo_current_inventory`
    ;;

  dimension: available_units {
    type: number
    sql: ${TABLE}.available_units ;;
  }

  dimension: avg_days_aged {
    type: number
    sql: ${TABLE}.avg_days_aged ;;
  }

  dimension: packed_and_ready_units {
    type: number
    sql: ${TABLE}.packed_and_ready_units ;;
  }

  dimension: product_id {
    primary_key: yes
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
    type: number
    sql: ${TABLE}.reserved_units ;;
  }

  dimension: shelf {
    type: string
    sql: ${TABLE}.shelf ;;
  }

  dimension: total_cost {
    type: number
    sql: ${TABLE}.total_cost ;;
  }

  dimension: total_cost_with_excise {
    type: number
    sql: ${TABLE}.total_cost_with_excise ;;
  }

  dimension: total_units {
    type: number
    sql: ${TABLE}.total_units ;;
  }

  dimension: unit_price {
    type: number
    sql: ${TABLE}.unit_price ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;

  }

  dimension: days_aged_weighted{
    type: number
    sql: ${TABLE}.days_aged_weighted ;;
  }
  measure: count {
    type: count
    drill_fields: [productname]
  }

  measure: sum_available_units {
    type: sum
    value_format: "#,##0"
    sql: ${available_units} ;;
  }

  measure: sum_reserved_units {
    type: sum
    value_format: "#,##0"
    sql: ${reserved_units} ;;
  }

  measure: sum_packed_and_ready_units {
    type: sum
    value_format: "#,##0"
    sql: ${packed_and_ready_units} ;;
  }

  measure: sum_total_units {
    type: sum
    value_format: "#,##0"
    sql: ${total_units} ;;
  }

  measure: sum_total_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${total_cost} ;;
  }

  measure: sum_total_cost_with_excise {
    type: sum
    value_format: "$#,##0.00"
    sql: ${total_cost_with_excise} ;;
  }

  measure: average_days_aged {
    type: average
    value_format: "#,##0"
    sql: ${avg_days_aged} ;;
  }

  measure: average_days_aged_weighted {
    type: average
    value_format: "#,##0"
    sql: ${days_aged_weighted} ;;
  }

}