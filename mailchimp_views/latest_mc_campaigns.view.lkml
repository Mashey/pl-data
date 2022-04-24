view: latest_mc_campaigns {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.latest_mc_campaigns`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: _airbyte_campaigns_hashid {
    type: string
    sql: ${TABLE}._airbyte_campaigns_hashid ;;
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

  dimension: ab_split_opts {
    type: string
    sql: ${TABLE}.ab_split_opts ;;
  }

  dimension: archive_url {
    type: string
    sql: ${TABLE}.archive_url ;;
    html: <a href="{{value}}">{{value}}</a> ;;
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.content_type ;;
  }

  dimension: create_time {
    type: string
    sql: ${TABLE}.create_time ;;
  }

  dimension: delivery_status {
    type: string
    sql: ${TABLE}.delivery_status ;;
  }

  dimension: emails_sent {
    type: number
    sql: ${TABLE}.emails_sent ;;
  }

  dimension: long_archive_url {
    type: string
    sql: ${TABLE}.long_archive_url ;;
  }

  dimension: needs_block_refresh {
    type: yesno
    sql: ${TABLE}.needs_block_refresh ;;
  }

  dimension: parent_campaign_id {
    type: string
    sql: ${TABLE}.parent_campaign_id ;;
  }

  dimension: recipients {
    type: string
    sql: ${TABLE}.recipients ;;
  }

  dimension: report_summary {
    type: string
    sql: ${TABLE}.report_summary ;;
  }

  dimension: resendable {
    type: yesno
    sql: ${TABLE}.resendable ;;
  }

  dimension: rss_opts {
    type: string
    sql: ${TABLE}.rss_opts ;;
  }

  dimension_group: send_time {
    type: time
    timeframes: [date,
                day_of_week,
                day_of_week_index,
                week,
                week_of_year,
                month,
                month_name,
                year,
                quarter,
                quarter_of_year]
    sql: ${TABLE}.send_time ;;
  }

  dimension: settings {
    type: string
    sql: ${TABLE}.settings ;;
  }

  dimension: social_card {
    type: string
    sql: ${TABLE}.social_card ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: subject_line {
    type: string
    sql: JSON_EXTRACT_SCALAR(${TABLE}.settings, '$.subject_line') ;;
  }

  dimension: title {
    type: string
    sql: JSON_EXTRACT_SCALAR(${TABLE}.settings, '$.title') ;;
    suggest_persist_for: "24 hours"
    # link: {
    #   label: "Campaign Detail"
    #   url: "/dashboards/63?Title={{ value }}"
    # }
  }

  dimension: tracking {
    type: string
    sql: ${TABLE}.tracking ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: variate_settings {
    type: string
    sql: ${TABLE}.variate_settings ;;
  }

  dimension: web_id {
    type: number
    sql: ${TABLE}.web_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
