view: ticket_item_discounts {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.ticket_item_discounts`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: cart {
    type: yesno
    sql: ${TABLE}.cart ;;
  }

  dimension: discount_amount {
    type: number
    sql: ${TABLE}.discount_amount ;;
  }

  dimension: discount_category {
    type: string
    sql: ${TABLE}.discount_category ;;
  }

  dimension: discount_method {
    type: string
    sql: ${TABLE}.discount_method ;;
  }

  dimension: discount_title {
    type: string
    sql: ${TABLE}.discount_title ;;
  }

  dimension: discounts {
    type: number
    sql: ${TABLE}.discounts ;;
  }

  dimension_group: last_updated {
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
    sql: ${TABLE}.last_updated_at ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: ticket_id {
    type: string
    sql: ${TABLE}.ticket_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }

  measure: total_discount {
    type: sum
    value_format: "$#,##0.00"
    sql: ${discounts} ;;
  }
}
