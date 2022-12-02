view: core_domo_ticket_items {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.core_domo_ticket_items`
    ;;

  dimension: cashier {
    type: string
    sql: ${TABLE}.cashier ;;
  }

  dimension: cbt_tax {
    hidden: yes
    type: number
    sql: ${TABLE}.cbt_tax ;;
  }

  dimension: classification {
    type: string
    sql: ${TABLE}.classification ;;
    drill_fields: [dim_domo_current_inventory.productbrand, dim_domo_current_inventory.productname]
  }

  dimension: cost {
    hidden: yes
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: cost_without_excise {
    hidden: yes
    type: number
    sql: ${TABLE}.cost_without_excise ;;
  }

  dimension: customer_uuid {
    type: string
    sql: ${TABLE}.customer_uuid ;;
  }

  dimension_group: date_closed {
    type: time
    timeframes: [
      raw,
      date,
      day_of_week,
      day_of_month,
      week,
      month,
      month_name,
      month_num,
      quarter,
      year,
      day_of_year,
      week_of_year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_closed ;;
  }

  dimension_group: date_opened {
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
    sql: ${TABLE}.date_opened ;;
  }

  dimension_group: date_time_closed {
    type: time
    timeframes: [
      raw,
      time,
      time_of_day,
      hour,
      minute,
      hour_of_day,
      date,
      day_of_month,
      day_of_week,
      day_of_year,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: datetime
    sql: ${TABLE}.date_time_closed ;;
  }

  dimension_group: date_time_opened {
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
    sql: ${TABLE}.date_time_opened ;;
  }

  dimension: discounts {
    hidden: yes
    type: number
    sql: ${TABLE}.discounts ;;
  }

  dimension: dynamic_tax {
    hidden: yes
    type: string
    sql: ${TABLE}.dynamic_tax ;;
  }

  dimension: excise_tax {
    hidden: yes
    type: number
    sql: ${TABLE}.excise_tax ;;
  }

  dimension: gross_income {
    hidden: yes
    type: number
    sql: ${TABLE}.gross_income ;;
  }

  dimension: gross_receipts {
    hidden: yes
    type: number
    sql: ${TABLE}.gross_receipts ;;
  }

  dimension: grosssales {
    hidden: yes
    type: number
    sql: ${TABLE}.grosssales ;;
  }

  dimension: is_arms_length {
    type: number
    sql: ${TABLE}.is_arms_length ;;
  }

  dimension: net_sales {
    hidden: yes
    type: number
    sql: ${TABLE}.net_sales ;;
  }

  dimension: rev_per_unit {
    type: number
    sql: (${net_sales}+${returns_amount})/nullif(${quantity},0) ;;
  }

  dimension: rev_per_unit_tiers {
    type: tier
    tiers: [0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100]
    style: integer
    sql: ${rev_per_unit} ;;
 }

  dimension: priceunit {
    type: number
    sql: ${TABLE}.priceunit ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_subtype {
    type: string
    sql: ${TABLE}.product_subtype ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  # dimension: productbrand {
  #   hidden: yes
  #   type: string
  #   sql: ${TABLE}.productbrand ;;
  # }

  dimension: productname {
    type: string
    sql: ${TABLE}.productname ;;
  }

  dimension: quantity {
    hidden: yes
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: register {
    type: string
    sql: ${TABLE}.register ;;
  }

  dimension: retail_brand {
    label: "Product Brand"
    type: string
    sql: ${TABLE}.retail_brand ;;
    drill_fields: [customer_uuid, retail_brand, total_units_sold_net]
  }

  filter: brand_select {
    suggest_dimension: retail_brand
  }

  dimension: brand_comparitor {
    type: string
    sql: CASE
          WHEN {% condition brand_select %} ${retail_brand} {% endcondition %}
            THEN ${retail_brand}
          ELSE 'Rest of Population'
          END ;;
  }


  dimension: returns_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.returns_amount ;;
  }

  dimension: sales_tax {
    hidden: yes
    type: number
    sql: ${TABLE}.sales_tax ;;
  }

  dimension: ticket_notes {
    type: string
    sql: ${TABLE}.ticket_notes ;;
  }

  dimension: ticket_status {
    type: string
    sql: ${TABLE}.ticket_status ;;
  }

  dimension: ticket_type {
    type: string
    sql: ${TABLE}.ticket_type ;;
  }

  dimension: ticketid {
    type: string
    sql: ${TABLE}.ticketid ;;
  }

  dimension: ticketlineid {
    primary_key: yes
    type: string
    sql: ${TABLE}.ticketlineid ;;
  }

  dimension: total_taxes {
    hidden: yes
    type: number
    sql: ${TABLE}.total_taxes ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: unitofmeasure {
    type: string
    sql: ${TABLE}.unitofmeasure ;;
  }

  dimension: weight {
    type: string
    sql: ${TABLE}.weight ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [productname]
  }

  measure: total_cost_without_excise {
    type: sum
    value_format: "$#,##0.00"
    sql: ${cost_without_excise} ;;
  }

  measure: total_discounts {
    type: sum
    value_format: "$#,##0.00"
    sql: ${discounts} ;;
  }

  measure: total_discounts_only_WESTCOASTTREES {
    type: sum
    value_format: "$#,##0.00"
    sql: ${discounts};;
    filters: [retail_brand: "WEST COAST TREES"]
    hidden: yes
  }

  measure: total_excise_tax  {
    type: sum
    value_format: "$#,##0.00"
    sql: ${excise_tax} ;;
  }

  measure: total_sales_tax {
    type: sum
    value_format: "$#,##0.00"
    sql: ${sales_tax} ;;
  }

  measure: total_cbt_tax {
    type: sum
    value_format: "$#,##0.00"
    sql: ${cbt_tax} ;;
  }

  measure: total_dynamic_tax {
    type: sum
    value_format: "$#,##0.00"
    sql: ${dynamic_tax} ;;
  }

  measure: total_gross_receipts {
    type: sum
    value_format: "$#,##0.00"
    sql: ${gross_receipts} ;;
  }

  measure: total_gross_sales_only_WESTCOASTTREES {
    type: sum
    value_format: "$#,##0.00"
    sql: ${grosssales} ;;
    filters: [retail_brand: "WEST COAST TREES"]
    hidden: yes
  }

  measure: total_gross_sales {
    type: sum
    value_format: "$#,##0.00"
    sql: ${grosssales} ;;
  }

  measure: total_net_sales {
    type: sum
    value_format: "$#,##0.00"
    sql: ${net_sales} ;;
    drill_fields: [retail_brand, total_units_sold_net]
  }

  measure: total_units_sold_net {
    type: sum
    value_format: "#,##0"
    sql: ${quantity} ;;
  }

  measure: total_units_sold_gross {
    type: sum
    value_format: "#,##0"
    sql: ${quantity} ;;
    filters: [type: "SALE"]
  }

  measure: total_units_returned {
    type: sum
    value_format: "#,##0"
    sql: ${quantity} * -1 ;;
    filters: [type: "RETURN"]
  }

  measure: total_returns_amount {
    type: sum
    value_format: "$#,##0.00"
    sql: ${returns_amount} ;;
  }

  measure: total_gross_profit{
    type: number
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${total_net_sales} - ${total_cost_without_excise} ;;
  }

  measure: gross_margin {
    type: number
    value_format_name: percent_2
    sql: ${total_gross_profit}/nullif(${total_net_sales},0) ;;
  }

  measure: discount_rate {
    type: number
    value_format_name: percent_2
    sql: ${total_discounts}/nullif(${total_gross_sales},0) ;;
  }

  measure: discount_rate_without_WESTCOASTTREES {
    type: number
    value_format_name: percent_2
    sql: (${total_discounts}-${total_discounts_only_WESTCOASTTREES})/nullif((${total_gross_sales}-${total_gross_sales_only_WESTCOASTTREES}),0) ;;
  }

  measure: count_distinct_customers {
    type: count_distinct
    value_format: "#,##0"
    sql: ${customer_uuid} ;;
    drill_fields: [customer_uuid,  total_net_sales]
  }

  measure: total_orders {
    type: count_distinct
    value_format: "#,##0"
    sql: ${ticketid} ;;
    drill_fields: [ticketid, product_type, retail_brand, productname, total_units_sold_net, total_net_sales, core_domo_customers.email]
  }

  measure: average_orders {
    type: average_distinct
    value_format: "#,##0"
    sql: ${ticketid} ;;
  }

  measure: average_order_value {
    type: number
    value_format: "$#,##0.00"
    sql: ${total_net_sales} / nullif(${total_orders},0) ;;
  }

  measure: return_rate {
    type: number
    value_format_name: percent_1
    sql: ${total_units_returned} / nullif(${total_units_sold_gross},0) ;;
  }

  measure: total_units_per_transaction {
    type: number
    value_format: "0.00"
    sql: ${total_units_sold_net}/nullif(${total_orders},0) ;;
  }

  measure: revenue_per_unit{
    type: number
    value_format: "$#,##0.00"
    sql: ${total_net_sales}/nullif(${total_units_sold_net},0) ;;
  }

  measure: gross_sales_per_unit {
    type: number
    value_format: "$#,##0.00"
    sql: ${total_gross_sales}/nullif(${total_units_sold_net},0) ;;
  }

  measure: total_cost_with_excise {
    type: sum
    value_format: "$#,##0.00"
    sql: ${cost} ;;
  }

  measure: sku_count {
    description: "Sku count by unique name/brand"
    type: count_distinct
    value_format: "#,##0"
    sql: CONCAT(${productname},${retail_brand},${product_id}) ;;
  }

  measure: brand_count{
    description: "Brand count"
    type: count_distinct
    value_format: "#,##0"
    sql: ${retail_brand} ;;
    drill_fields: [product_type, retail_brand, total_units_sold_net, total_net_sales, revenue_per_unit, count_distinct_customers]
  }

}
