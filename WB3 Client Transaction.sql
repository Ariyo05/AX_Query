select
a.created, c.cid, c.name, d.code, c.name, e.name, a.source, a.transaction_type
,a.net_weight, a.net_weight_before, a.net_weight_after, a.lien_weight_before, a.lien_weight_after
, a.total_weight_before, a.total_weight_after, extra_note
from workbench.inventory_clientinventorytransaction a
left join workbench.inventory_clientinventoryaccount b on a.client_inventory_account_id = b.id
left join workbench.crm_client c on b.client_id = c.id
left join workbench.workbench_warehouse e on b.warehouse_id = e.id 
left join workbench.workbench_product d on b.item_id = d.id
where d.code = 'CCO'
and a.is_deleted = 'false'