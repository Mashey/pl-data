view: core_ga_alltraffic2 {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.core_ga_alltraffic2`
    ;;

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: ga_bounces {
    type: number
    sql: ${TABLE}.ga_bounces ;;
  }

  dimension: ga_channelgrouping {
    type: string
    sql: ${TABLE}.ga_channelgrouping ;;
  }

  dimension: ga_keyword {
    type: string
    sql: ${TABLE}.ga_keyword ;;
  }

  dimension: ga_newusers {
    type: number
    sql: ${TABLE}.ga_newusers ;;
  }

  dimension: ga_pageviews {
    type: number
    sql: ${TABLE}.ga_pageviews ;;
  }

  dimension: ga_sessions {
    type: number
    sql: ${TABLE}.ga_sessions ;;
  }

  dimension: ga_source {
    type: string
    sql: ${TABLE}.ga_source ;;
  }

  dimension: ga_sourcemedium {
    type: string
    sql: ${TABLE}.ga_sourcemedium ;;
  }

  dimension: ga_transactionrevenue {
    type: number
    sql: ${TABLE}.ga_transactionrevenue ;;
  }

  dimension: ga_transactions {
    type: number
    sql: ${TABLE}.ga_transactions ;;
  }

  dimension: ga_users {
    type: number
    sql: ${TABLE}.ga_users ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_bounces {
    type: sum
    sql: ${ga_bounces} ;;
  }

  measure: total_sessions {
    type: sum
    sql: ${ga_sessions} ;;
  }

  measure: total_pageviews {
    type: sum
    sql: ${ga_pageviews} ;;
  }

  measure: bounce_rate {
    type: number
    value_format_name: percent_1
    sql: ${total_bounces}/nullif(${total_sessions},0) ;;
  }

  measure: total_pageviews_per_session {
    type: number
    value_format: "0.0"
    sql: ${total_pageviews}/nullif(${total_sessions},0) ;;
  }
}
