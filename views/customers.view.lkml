# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: customers {
  hidden: yes

  join: customers__customer_groups {
    view_label: "Customers: Customer Groups"
    sql: LEFT JOIN UNNEST(${customers.customer_groups}) as customers__customer_groups ;;
    relationship: one_to_many
  }
}

view: customers {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.customers`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: birthday {
    type: string
    sql: ${TABLE}.birthday ;;
  }

  dimension: customer_groups {
    hidden: yes
    sql: ${TABLE}.customer_groups ;;
  }

  dimension: customer_type {
    type: string
    sql: ${TABLE}.customer_type ;;
  }

  dimension: drivers_license {
    type: string
    sql: ${TABLE}.drivers_license ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension_group: last_visit {
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
    sql: ${TABLE}.last_visit_date ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: opt_out {
    type: string
    sql: ${TABLE}.opt_out ;;
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

  dimension: rewards_type {
    type: string
    sql: ${TABLE}.rewards_type ;;
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

  dimension: state_id_expiration {
    type: string
    sql: ${TABLE}.state_id_expiration ;;
  }

  dimension: state_medical_id {
    type: string
    sql: ${TABLE}.state_medical_id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: verification_status {
    type: string
    sql: ${TABLE}.verification_status ;;
  }

  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, customer_addresses.count, tickets.count]
  }
}

view: customers__customer_groups {
  dimension: customers__customer_groups {
    type: string
    sql: customers__customer_groups ;;
  }
}
