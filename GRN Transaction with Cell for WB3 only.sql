select a.created, b.cid client_id, k.folio_id, o.name cell_name, b.name, a.gross_weight/1000::float gross_weight, a.net_weight/1000::float net_weight, a.transaction_type, d.name prod_name, d.product_type
,(case when left(cid, 3) = '001' then 'Farmer' else 'Client' end) as client_type, e.name warehouse, h.name as wh_location
, extract(year from a.created) as year
from workbench.goods_receipt_goodsreceiptline a
inner join workbench.crm_client b on a.client_id = b.id
inner join workbench.inventory_item c on a.item_id = c.id
inner join workbench.workbench_product d on c.product_id = d.id
inner join workbench.workbench_warehouse e on a.warehouse_id = e.id
left join workbench.location_location g on e.location_id = g.id
left join workbench.location_baselocation h on g.base_location_id = h.id
left join workbench.workbench_cell o on k.cell_id = o.id
where a.is_approval_completed = 'true'
and a.is_approved = 'true'
and a.is_deleted = 'false'
and a.tenant_id = 7
--and d.code = 'SGM'