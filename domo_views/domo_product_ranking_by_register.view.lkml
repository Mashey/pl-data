view: domo_product_ranking_by_register {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.domo_product_ranking_by_register`
    ;;

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.PK ;;
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
    datatype: date
    sql: ${TABLE}.date_closed ;;
  }

  dimension: product_ranking_register {
    type: number
    sql: ${TABLE}.product_ranking_register ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
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
    type: string
    sql: ${TABLE}.retail_brand ;;
  }

  measure: count {
    type: count
    drill_fields: [productname]
  }
}
