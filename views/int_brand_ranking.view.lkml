view: int_brand_ranking {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.int_brand_ranking`
    ;;

  dimension: brand_ranking {
    type: number
    sql: ${TABLE}.brand_ranking ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.PK ;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
