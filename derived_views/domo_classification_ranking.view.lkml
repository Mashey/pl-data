view: domo_classification_ranking {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.domo_classification_ranking`
    ;;

  dimension: classification {
    type: string
    sql: ${TABLE}.classification ;;
  }

  dimension: classification_ranking {
    type: number
    sql: ${TABLE}.classification_ranking ;;
  }

  dimension: count_domo_classification_ranking {
    hidden: yes
    type: number
    sql: ${TABLE}.count ;;
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

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}
