select a.created ,d.cid,  d.name, a.invoice_id, a.unit , a.price_per_unit,  a.total_value, c.code prod_code, c.name prod_name
, d.transaction_note
from workbench.invoice_clientinvoiceline a
inner join workbench.inventory_item b on a.item_id = b.id
inner join workbench.workbench_product c on b.product_id = c.id 
inner join (select a.id, a.client_id, b.cid, b.name, a.transaction_note, a.total_invoice_value from workbench.invoice_clientinvoice a 
		   inner join workbench.crm_client b on a.client_id = b.id) d on a.invoice_id = d.id
where a.tenant_id = 7
--and extract (year from a.created) = '2022'
order by a.created