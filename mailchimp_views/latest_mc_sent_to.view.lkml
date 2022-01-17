view: latest_mc_sent_to {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.latest_mc_sent_to`
    ;;

  dimension: _airbyte_emitted_at {
    type: string
    sql: ${TABLE}._airbyte_emitted_at ;;
  }

  dimension: _airbyte_sent_to_hashid {
    type: string
    sql: ${TABLE}._airbyte_sent_to_hashid ;;
  }

  dimension: absplit_group {
    type: string
    sql: ${TABLE}.absplit_group ;;
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

  dimension_group: first_open {
    type: time
    timeframes: [time,
      date,
      week,
      month,
      year]
    sql: ${TABLE}.first_open ;;
  }

  dimension: gmt_offset {
    type: number
    sql: ${TABLE}.gmt_offset ;;
  }

  dimension: ip {
    type: string
    sql: ${TABLE}.ip ;;
  }

  dimension_group: last_open {
    type: time
    timeframes: [time,
      date,
      week,
      month,
      year]
    sql: ${TABLE}.last_open ;;
  }

  dimension: list_id {
    type: string
    sql: ${TABLE}.list_id ;;
  }

  dimension: list_is_active {
    type: yesno
    sql: ${TABLE}.list_is_active ;;
  }

  dimension: open_count {
    type: number
    sql: ${TABLE}.open_count ;;
  }

  dimension: pk {
    type: string
    sql: ${TABLE}.pk ;;
    primary_key: yes
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension_group: timestamp {
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
    sql: ${TABLE}.timestamp ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: vip {
    type: yesno
    sql: ${TABLE}.vip ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: distinct_emails {
    type: count_distinct
    sql: ${email_id} ;;
  }
}
