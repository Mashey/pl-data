view: core_domo_customers {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.core_domo_customers`
    ;;

  dimension: age {
    type: string
    sql: ${TABLE}.age ;;
  }

  dimension: age_group {
    type: string
    sql: ${TABLE}.age_group ;;
  }

  dimension: age_group_tier {
    type: tier
    tiers: [21,36]
    style: integer
    sql: CASE WHEN ${age} <> 'N/A' THEN CAST(${age} as int64)
      ELSE 0 END ;;
  }




  dimension_group: customer_signup {
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
    datatype: date
    sql: ${TABLE}.customer_signup_date ;;
  }

  dimension: customer_source {
    type: string
    sql: ${TABLE}.customer_source ;;
  }


  dimension: customer_status {
    type: string
    sql: ${TABLE}.customer_status ;;
  }

  dimension: customer_uuid {
    primary_key: yes
    type: string
    sql: ${TABLE}.customer_uuid ;;
  }

  dimension: email {
    hidden: no
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    hidden: no
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: groupnames {
    type: string
    sql: ${TABLE}.groupnames ;;
  }

  dimension: last_name {
    hidden: no
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: last_updated_at {
    type: string
    sql: ${TABLE}.last_updated_at ;;
  }

  dimension: opted_in {
    type: string
    sql: ${TABLE}.opted_in ;;
  }

  dimension: patient_type {
    type: string
    sql: ${TABLE}.patient_type ;;
  }

  dimension: phone {
    label: "Customers Phone"
    hidden: no
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: reward_balance {
    hidden: yes
    type: number
    sql: ${TABLE}.reward_balance ;;
  }

  measure: count {
    type: count
    drill_fields: [last_name, first_name]
  }

  measure: total_distinct_customers {
    type: count_distinct
    value_format: "#,##0"
    sql: ${customer_uuid} ;;
    drill_fields: [customer_uuid, email, gender, age_group]
  }

  measure: total_distinct_customer_emails {
    type: count_distinct
    value_format: "#,##0"
    sql: ${email} ;;
    drill_fields: [customer_uuid, email, gender, age_group]
  }

  measure: total_reward_balance {
    type: sum
    value_format: "$#,##0.00"
    sql: ${reward_balance}/100 ;;
    }
}
