# If necessary, uncomment the line below to include explore_source.
# include: "pl_data.model.lkml"

view: Stiiizy_test {
  derived_table: {
    explore_source: core_domo_ticket_items {
      column: customer_uuid {}
      filters: {
        field: domo_brand_ranking.brand_ranking
        value: "1"
      }
      filters: {
        field: domo_brand_ranking.retail_brand
        value: "STIIIZY"
      }
      filters: {
        field: core_domo_ticket_items.date_closed_date
        value: "2022/10/01 to 2023/01/01"
      }
    }
  }
  dimension: customer_uuid {
    label: "Order Items Customer Uuid"
    description: ""
  }
}
