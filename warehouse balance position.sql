select b.name warehouse, d.code, d.name prod, f.name as location, a.grade, a.net_weight,  a.gross_weight,
a.lien_net_weight, a.total_net_weight, a.total_gross_weight,g.name as state, h.name region
from workbench.inventory_warehouseinventoryaccount a
left join workbench.workbench_warehouse b on a.warehouse_id = b.id
left join workbench.inventory_item c on a.item_id = c.id
left join workbench.workbench_product d on c.product_id = d.id
left join workbench.location_location e on b.location_id = e.id
left join workbench.location_baselocation f on e.base_location_id = f.id
left join workbench.location_state g on f.state_id = g.id
left join workbench.location_region h on g.region_id = h.id
where a.tenant_id = 7
and a.is_deleted = 'false'