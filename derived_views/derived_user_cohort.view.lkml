view: derived_user_cohort {
  derived_table: {

    sql: SELECT ct.customer_uuid AS customer_uuid
                FROM `fivetran-purple-lotus-warehous.dbt.core_domo_ticket_items` ct

                LEFT JOIN `fivetran-purple-lotus-warehous.dbt.dim_domo_inventory` di ON di.product_id = ct.product_id
                LEFT JOIN `fivetran-purple-lotus-warehous.dbt.core_domo_customers` cc ON ct.customer_uuid = cc.customer_uuid
                LEFT JOIN `fivetran-purple-lotus-warehous.dbt.core_domo_discount` d ON d.customer_uuid = ct.customer_uuid
                LEFT JOIN `fivetran-purple-lotus-warehous.dbt.domo_brand_ranking` br ON br.customer_uuid = ct.customer_uuid
                LEFT JOIN `fivetran-purple-lotus-warehous.dbt.core_domo_ticket_items` ct2 on ct.customer_uuid = ct2.customer_uuid
                WHERE ({% condition cohort_filter_item_name %} ct2.productname {% endcondition %})
                  AND ({% condition cohort_filter_sku %} ct2.product_id {% endcondition %} )
                  AND ({% condition cohort_filter_brand_name %} ct2.productbrand {% endcondition %} )
                  AND ({% condition cohort_filter_discount_date_closed %} timestamp(d.date_closed) {% endcondition %} )
                  AND ({% condition cohort_filter_date_closed%} timestamp(ct2.date_closed) {% endcondition %} )
                  AND ({% condition cohort_filter_discount_title %} d.discount_title {% endcondition %} )
                  AND ({% condition cohort_filter_brand_name_brandRank %} br.retail_brand {% endcondition %} )
                  AND ({% condition cohort_filter_brand_ranking %} br.brand_ranking {% endcondition %} )
                GROUP BY 1;;

    }



    dimension: customer_uuid {
      hidden: no
      primary_key: yes
      description: "Unique ID for each user that has ordered"
      type: string
      sql: ${TABLE}.customer_uuid ;;
    }

    # dimension: PK {
    #   hidden: yes
    #   primary_key: yes
    #   type: string
    #   sql: CONCAT(${customer_uuid},${date_closed_date},${quantity_sold}) ;;
    # }

    # dimension_group: date_closed {
    #   hidden: no
    #   type: time
    #   timeframes: [
    #     raw,
    #     time_of_day,
    #     hour_of_day,
    #     date,
    #     day_of_month,
    #     week,
    #     month,
    #     month_name,
    #     month_num,
    #     quarter,
    #     year,
    #     day_of_year
    #     ]
    #   convert_tz: no
    #   datatype: timestamp
    #   sql: ${TABLE}.date_closed ;;
    # }

  #   dimension: quantity_sold {
  #     hidden: yes
  #     type: number
  #     sql: ${TABLE}.quantity_sold ;;
  #   }

  #   dimension: net_sales {
  #     hidden: yes
  #     type: number
  #     sql: ${TABLE}.net_sales ;;
  #   }

  #   measure: total_quantity_sold {
  #     type: sum
  #     value_format: "0.0"
  #     sql: ${quantity_sold} ;;
  # }

  measure: distinct_customers{
    type: count_distinct
    sql: ${customer_uuid} ;;
    drill_fields: [customer_uuid]
  }

  # measure: total_net_sales {
  #   type: sum
  #   value_format: "$#,##0.00"
  #   sql: ${net_sales} ;;
  # }

    filter: cohort_filter_sku {
      description: "SKU to filter cohort - filter on all users that purchased this sku"
      type: string
      suggest_explore: `fivetran-purple-lotus-warehous.dbt.dim_domo_inventory`
      suggest_dimension: `fivetran-purple-lotus-warehous.dbt.dim_domo_inventory.productid`
    }

    filter: cohort_filter_item_name {
      description: "Item Name to filter cohort - filter on all users that purchased this item"
      type: string
      suggest_explore: `fivetran-purple-lotus-warehous.dbt.dim_domo_inventory`
      suggest_dimension: `fivetran-purple-lotus-warehous.dbt.dim_domo_inventory.productname`
    }

    filter: cohort_filter_brand_name {
      description: "Brand Name to filter cohort - filter on all users that purchased this brand"
      type: string
      suggest_explore: `fivetran-purple-lotus-warehous.dbt.dim_domo_inventory`
      suggest_dimension: `fivetran-purple-lotus-warehous.dbt.dim_domo_inventory.productbrand`
    }

    filter: cohort_filter_brand_name_brandRank {
    description: "Brand Name to filter by brank ranking - filter on all users where this is their top purchased brand"
    type: string
    suggest_explore: `fivetran-purple-lotus-warehous.dbt.domo_brand_ranking`
    suggest_dimension: `fivetran-purple-lotus-warehous.dbt.domo_brand_ranking.retail_brand`
    }

  filter: cohort_filter_brand_ranking {
    description: "Filters by brand ranking using numbers. Top filter is by 1 which represents the top purchased brand"
    type: number
    suggest_explore: `fivetran-purple-lotus-warehous.dbt.domo_brand_ranking`
    suggest_dimension: `fivetran-purple-lotus-warehous.dbt.domo_brand_ranking.brand_ranking`
  }

    filter: cohort_filter_discount_date_closed {
    type: date
      }

    filter: cohort_filter_discount_title {
    description: "Discount title to filter cohort - filter on all users that received this discount"
    type: string
    suggest_explore: `fivetran-purple-lotus-warehous.dbt.core_domo_discount`
    suggest_dimension: `fivetran-purple-lotus-warehous.dbt.core_domo_discount.discount_title`
    }



  filter: cohort_filter_date_closed {
  type: date

  }
  }
