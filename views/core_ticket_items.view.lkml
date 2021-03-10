# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: core_ticket_items {
  hidden: yes

  join: core_ticket_items__barcodes {
    view_label: "Core Ticket Items: Barcodes"
    sql: LEFT JOIN UNNEST(${core_ticket_items.barcodes}) as core_ticket_items__barcodes ;;
    relationship: one_to_many
  }

  join: core_ticket_items__pos_discounts {
    view_label: "Core Ticket Items: Pos Discounts"
    sql: LEFT JOIN UNNEST(${core_ticket_items.pos_discounts}) as core_ticket_items__pos_discounts ;;
    relationship: one_to_many
  }

  join: core_ticket_items__inventory_barcodes {
    view_label: "Core Ticket Items: Inventory Barcodes"
    sql: LEFT JOIN UNNEST(${core_ticket_items.inventory_barcodes}) as core_ticket_items__inventory_barcodes ;;
    relationship: one_to_many
  }
}

view: core_ticket_items {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.core_ticket_items`
    ;;

  dimension: apply_automatic_discounts {
    type: yesno
    sql: ${TABLE}.apply_automatic_discounts ;;
  }

  dimension: barcodes {
    hidden: yes
    sql: ${TABLE}.barcodes ;;
  }

  dimension: inventory_barcodes {
    hidden: yes
    sql: ${TABLE}.inventory_barcodes ;;
  }

  dimension: inventory_batch_id {
    type: string
    sql: ${TABLE}.inventory_batch_id ;;
  }

  dimension: inventory_id {
    type: string
    sql: ${TABLE}.inventory_id ;;
  }

  dimension: inventory_type {
    type: string
    sql: ${TABLE}.inventory_type ;;
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

  dimension: location_name {
    type: string
    sql: ${TABLE}.location_name ;;
  }

  dimension: pos_discounts {
    hidden: yes
    sql: ${TABLE}.POS_discounts ;;
  }

  dimension: price_sell {
    type: number
    sql: ${TABLE}.price_sell ;;
  }

  dimension: price_target {
    type: number
    sql: ${TABLE}.price_target ;;
  }

  dimension: price_target_note {
    type: string
    sql: ${TABLE}.price_target_note ;;
  }

  dimension: price_total {
    type: number
    sql: ${TABLE}.price_total ;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_size_name {
    type: string
    sql: ${TABLE}.product_size_name ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  dimension: product_unit {
    type: string
    sql: ${TABLE}.product_unit ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: size_id {
    type: string
    sql: ${TABLE}.size_id ;;
  }

  dimension: ticket_id {
    type: string
    sql: ${TABLE}.ticket_id ;;
  }

  measure: count {
    type: count
    drill_fields: [product_size_name, location_name]
  }
}

view: core_ticket_items__barcodes {
  dimension: core_ticket_items__barcodes {
    type: string
    sql: core_ticket_items__barcodes ;;
  }
}

view: core_ticket_items__pos_discounts {
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

  dimension: discount_method {
    type: string
    sql: ${TABLE}.discount_method ;;
  }

  dimension: discount_title {
    type: string
    sql: ${TABLE}.discount_title ;;
  }
}

view: core_ticket_items__inventory_barcodes {
  dimension: core_ticket_items__inventory_barcodes {
    type: string
    sql: core_ticket_items__inventory_barcodes ;;
  }
}
