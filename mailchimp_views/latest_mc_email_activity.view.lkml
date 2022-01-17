view: latest_mc_email_activity {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.latest_mc_email_activity`
    ;;

  dimension: _airbyte_email_activity_hashid {
    type: string
    sql: ${TABLE}._airbyte_email_activity_hashid ;;
  }

  dimension_group: _airbyte_emitted {
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
    sql: ${TABLE}._airbyte_emitted_at ;;
  }

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: email_address {
    type: string
    sql: ${TABLE}.email_address ;;
  }

  dimension: email_id {
    type: string
    sql: ${TABLE}.email_id ;;
  }

  dimension: ip {
    type: string
    sql: ${TABLE}.ip ;;
  }

  dimension: list_id {
    type: string
    sql: ${TABLE}.list_id ;;
  }

  dimension: list_is_active {
    type: yesno
    sql: ${TABLE}.list_is_active ;;
  }

  dimension: pk {
    type: string
    sql: ${TABLE}.pk ;;
    primary_key: yes
  }

  dimension: timestamp {
    type: string
    sql: ${TABLE}.timestamp ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  measure: distinct_emails {
    type: count_distinct
    sql: ${email_id} ;;
  }

  measure: distinct_opens {
    type: count_distinct
    sql: ${email_id} ;;
    filters: [action: "open"]
  }

  measure: distinct_clicks {
    type: count_distinct
    sql: ${email_id} ;;
    filters: [action: "click"]
    drill_fields: [url]
  }

  measure: distinct_bounces {
    type: count_distinct
    sql: ${email_id} ;;
    filters: [action: "bounce"]
  }

  measure: open_rate {
    type: number
    sql: ${distinct_opens}/nullif(${latest_mc_sent_to.distinct_emails},0) ;;
    value_format: "0.00%"
  }

  measure: click_rate {
    type: number
    sql: ${distinct_clicks}/nullif(${latest_mc_sent_to.distinct_emails},0) ;;
    drill_fields: [distinct_emails, url]
    value_format: "0.00%"
  }

  measure: click_through_rate {
    type: number
    sql: ${distinct_clicks} / nullif(${distinct_opens}, 0) ;;
    drill_fields: [distinct_emails, url]
    value_format: "0.00%"
  }

  measure: bounce_rate {
    type: number
    sql: ${distinct_bounces}/nullif(${latest_mc_sent_to.distinct_emails},0) ;;
    value_format: "0.00%"
  }

  measure: openers_that_purchased {
    label: "Conversions"
    type: count_distinct
    sql: ${core_domo_customers.email} ;;
    filters: [action: "open", core_domo_ticket_items.customer_uuid: "-null"]
  }

  measure: conversion_rate {
    type: number
    sql: ${openers_that_purchased} / nullif(${latest_mc_sent_to.distinct_emails},0) ;;
    value_format: "0.00%"
  }
}
