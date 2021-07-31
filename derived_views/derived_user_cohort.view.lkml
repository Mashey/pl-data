view: derived_user_cohort {
  derived_table: {

    sql: SELECT ct.customer_uuid,
                timestamp(ct.date_closed) AS date_closed,
                sum(ct.quantity) as quantity_sold
                FROM `fivetran-purple-lotus-warehous.dbt.core_domo_ticket_items` ct

                LEFT JOIN `fivetran-purple-lotus-warehous.dbt.dim_domo_inventory` di ON di.product_id = ct.product_id
                LEFT JOIN `fivetran-purple-lotus-warehous.dbt.core_domo_customers` cc ON ct.customer_uuid = cc.customer_uuid
                WHERE ({% condition cohort_filter_item_name %} di.productname {% endcondition %})
                  AND ({% condition cohort_filter_sku %} di.product_id {% endcondition %} )
                  AND ({% condition cohort_filter_brand_name %} di.productbrand {% endcondition %} )
                  AND ({% condition cohort_filter_date_closed %} timestamp(ct.date_closed) {% endcondition %} )
                GROUP BY 1,2;;

    }



    dimension: customer_uuid {
      hidden: yes
      description: "Unique ID for each user that has ordered"
      type: number
      sql: ${TABLE}.customer_uuid ;;
    }

    dimension: PK {
      hidden: yes
      primary_key: yes
      type: string
      sql: CONCAT(${customer_uuid},${date_closed_date},${quantity_sold}) ;;
    }

    dimension_group: date_closed {
      hidden: yes
      type: time
      timeframes: [
        raw,
        time_of_day,
        hour_of_day,
        date,
        day_of_month,
        week,
        month,
        month_name,
        month_num,
        quarter,
        year,
        day_of_year
        ]
      convert_tz: no
      datatype: date
      sql: ${TABLE}.date_closed ;;
    }

    dimension: quantity_sold {
      hidden: yes
      type: number
      sql: ${TABLE}.quantity_sold ;;
    }

    measure: total_quantity_sold {
      type: sum
      value_format: "0.0"
      sql: ${quantity_sold} ;;
  }

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

  filter: cohort_filter_date_closed {
  type: date

   }
  }
