select b.name warehouse, d.code, d.name prod, f.name as location,a.source, a.transaction_type, a.gross_weight, a.gross_weight_before
,a.gross_weight_after,a.net_weight, a.net_weight_before, a.net_weight_after,
a.total_net_weight_before, a.total_net_weight_after, a.lien_gross_weight_before, a.lien_gross_weight_after
,a.total_gross_weight_before, a.total_gross_weight_after,
 a.extra_note
from workbench.inventory_warehouseinventorytransaction a
left join workbench.inventory_warehouseinventoryaccount i on a.warehouse_inventory_account_id = i.id
inner join workbench.workbench_warehouse b on i.warehouse_id = b.id
inner join workbench.inventory_item c on i.item_id = c.id
left join workbench.workbench_product d on c.product_id = d.id
left join workbench.location_location e on b.location_id = e.id
left join workbench.location_baselocation f on e.base_location_id = f.id
left join workbench.location_state g on f.state_id = g.id
left join workbench.location_region h on g.region_id = h.id
where b.tenant_id = 7
and a.is_deleted = 'false'
limit 10