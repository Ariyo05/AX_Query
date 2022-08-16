select a.created, a.updated, b.name warehouse, d.code, d.name prod, f.name as location,a.source, a.transaction_type, a.units, a.units_before
,a.units_after, a.lien_units_before, a.lien_units_after
,a.total_units_before, a.total_units_after,
 a.extra_note
from workbench.inventory_warehouseinputtransaction a
left join workbench.inventory_warehouseinputaccount i on a.input_account_id = i.id
inner join workbench.workbench_warehouse b on i.warehouse_id = b.id
inner join workbench.inventory_item c on i.item_id = c.id
left join workbench.workbench_product d on c.product_id = d.id
left join workbench.location_location e on b.location_id = e.id
left join workbench.location_baselocation f on e.base_location_id = f.id
left join workbench.location_state g on f.state_id = g.id
left join workbench.location_region h on g.region_id = h.id
where b.tenant_id = 7
and d.code = 'CPP_HKT'
and a.is_deleted = 'false'