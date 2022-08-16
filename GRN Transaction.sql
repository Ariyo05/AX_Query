SELECT 
a.created
,'nill' as client_id
,b.folio_id 
,f.name cell
,CONCAT (
		first_name
		,' '
		,last_name
		) AS name
	,(a.gross_weight) as gross_weight
 	,(a.net_weight) as net_weight
	,a.transaction_type
	,c.item_name prod_name
	,c.item_type as product_type
	,'Farmer' as client_type 
	,d.name AS warehouse
 	,e.name as wh_location
	,extract(year from a.created) as year
FROM workbench_2.inventory_goodsreceiptline a
INNER JOIN workbench_2.workbench_farmer b ON a.farmer_id = b.id
INNER JOIN workbench_2.inventory_item c ON a.item_id = c.id
INNER JOIN workbench_2.workbench_warehouse d ON a.warehouse_id = d.code
INNER JOIN workbench_2.workbench_location e ON d.location_id = e.code
inner join workbench_2.workbench_cell f on b.cell_id = f.code
WHERE a.is_approved = 'true'
AND a.is_approval_completed = 'true'
and c.item_code = 'SGM'

UNION ALL

select
a.created
,b.client_id
,'NULL' as folio_id
,'NULL' as cell_name
,CONCAT (
		first_name
		,' '
		,last_name
		) AS name
	,(a.gross_weight) as gross_weight
 	,(a.net_weight) as net_weight
	,a.transaction_type
	,c.item_name prod_name
	,c.item_type as product_type
	,'Client' as client_type 
	,d.name AS warehouse
 	,e.name as wh_location
	,extract(year from a.created) as year
FROM workbench_2.inventory_goodsreceiptlineclient a
INNER JOIN workbench_2.crm_client b ON a.client_id = b.id
INNER JOIN workbench_2.inventory_item c ON a.item_id = c.id
INNER JOIN workbench_2.workbench_warehouse d ON a.warehouse_id = d.code
INNER JOIN workbench_2.workbench_location e ON d.location_id = e.code
WHERE is_approved = 'true'
	AND is_approval_completed = 'true'
	and c.item_code = 'SGM'
	
UNION ALL

select a.created, b.cid client_id, k.folio_id , o.name cell_name, b.name, a.gross_weight/1000::float gross_weight, a.net_weight/1000::float net_weight, a.transaction_type, d.name prod_name, d.product_type
,(case when left(cid, 3) = '001' then 'Farmer' else 'Client' end) as client_type, e.name warehouse, h.name as wh_location
, extract(year from a.created) as year
from workbench.goods_receipt_goodsreceiptline a
inner join workbench.crm_client b on a.client_id = b.id
left join workbench.crm_farmer k on b.cid = k.folio_id
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
and d.code = 'SGM'

limit 1000