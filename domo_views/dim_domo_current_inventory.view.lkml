view: dim_domo_current_inventory {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.dim_domo_current_inventory`
    ;;

  dimension: available_units {
    type: number
    sql: ${TABLE}.available_units ;;
  }

  dimension: packed_and_ready_units {
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
    type: number
    sql: ${TABLE}.reserved_units ;;
  }

  dimension: total_units {
    type: number
    sql: ${available_units} + ${reserved_units} + ${packed_and_ready_units} ;;
  }

  measure: count {
    type: count
    drill_fields: [productname]
  }

  measure: sum_available_units {
    type: sum
    value_format: "$#,##0.00"
    sql: ${available_units} ;;
  }

  measure: sum_reserved_units {
    type: sum
    value_format: "$#,##0.00"
    sql: ${reserved_units} ;;
  }

  measure: sum_packed_and_ready_units {
    type: sum
    value_format: "$#,##0.00"
    sql: ${packed_and_ready_units} ;;
  }

  measure: sum_total_units {
    type: sum
    value_format: "$#,##0.00"
    sql: ${packed_and_ready_units} ;;
  }


}
