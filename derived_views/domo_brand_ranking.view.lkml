view: domo_brand_ranking {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.domo_brand_ranking`
    ;;

  dimension: brand_ranking {
    type: number
    sql: ${TABLE}.brand_ranking ;;
  }

  dimension: customer_uuid {
    type: string
    sql: ${TABLE}.customer_uuid ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.PK ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  dimension: quantity {
    hidden: yes
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: retail_brand {
    label: "Product Brand"
    type: string
    sql: ${TABLE}.retail_brand ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }

  measure: total_quantity {
    type: sum
    value_format: "0.00"
    sql: ${quantity} ;;
  }
}
