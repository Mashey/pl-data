view: customer_addresses {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.customer_addresses`
    ;;

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${customer_id}, ${street1}, ${street2}, ${city}, ${state}, ${zipcode}, ${primary}) ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: customer_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: primary {
    type: yesno
    sql: ${TABLE}.primary ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: street1 {
    type: string
    sql: ${TABLE}.street1 ;;
  }

  dimension: street2 {
    type: string
    sql: ${TABLE}.street2 ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: zipcode {
    type: zipcode
    sql: ${TABLE}.zipcode ;;
  }

  measure: count {
    type: count
    drill_fields: [customers.last_name, customers.id, customers.first_name]
  }
}
