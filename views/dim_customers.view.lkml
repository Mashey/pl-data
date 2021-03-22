view: dim_customers {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.dim_customers`
    ;;

  dimension: birthday {
    type: string
    sql: ${TABLE}.birthday ;;
  }

  dimension: customer_group {
    type: string
    sql: ${TABLE}.customer_group ;;
  }

  dimension: customer_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_visit_frequency {
    type: number
    sql: ${TABLE}.customer_visit_frequency ;;
  }

  dimension: days_aged {
    type: number
    sql: ${TABLE}.days_aged ;;
  }

  dimension: days_aged_tiers {
    type: tier
    tiers: [1,16,31,46,61,91,121]
    style: integer
    sql: ${days_aged} ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension_group: first_order {
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
    sql: ${TABLE}.first_order ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension_group: last_order {
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
    sql: ${TABLE}.last_order ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension: lifetime_tickets {
    type: number
    sql: ${TABLE}.lifetime_tickets ;;
  }

  dimension: opt_out {
    type: string
    sql: ${TABLE}.opt_out ;;
  }

  dimension: percent_outside_visit_frequency {
    type: number
    sql: ${TABLE}.percent_outside_visit_frequency ;;
  }

  dimension: percent_outside_frequency_tiers {
    type: tier
    tiers: [0.01,0.7,0.8,0.9,1.2,2.0,3.0]
    style: relational
    sql: ${percent_outside_visit_frequency} ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: referral_source {
    type: string
    sql: ${TABLE}.referral_source ;;
  }

  dimension: rewards_balance {
    type: number
    sql: ${TABLE}.rewards_balance ;;
  }

  dimension_group: signup {
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
    sql: ${TABLE}.signup_date ;;
  }

  measure: count {
    type: count
    drill_fields: [last_name, first_name]
  }

  measure: average_customer_visit_frequency {
    type: average
    value_format: "0.0"
    sql: ${customer_visit_frequency} ;;
  }
  measure: average_days_aged {
    type: average
    value_format: "0.0"
    sql: ${days_aged} ;;
  }

  measure: total_rewards_balance {
    type: sum
    value_format: "0.0"
    sql: ${rewards_balance} ;;
  }

  measure: count_distinct_customers {
    type: count_distinct
    value_format: "0"
    sql: ${customer_id} ;;
  }

  measure: average_lifetime_value_revenue {
    type: average
    value_format: "$#,##0.00"
    sql: ${lifetime_revenue} ;;
  }

  measure: average_lifetime_tickets {
    type: average
    value_format: "#,##0"
    sql: ${lifetime_tickets} ;;
  }


}
