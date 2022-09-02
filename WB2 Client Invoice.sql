select a.created, a.trans_id, a.invoice_number, a.trade_id, a.invoice_type, a.is_reverted, b.first_name, b.last_name, b.folio_id
from workbench_2.payment_clientinvoice a 
inner join workbench_2.workbench_farmer b on a.client_id = b.id
where a.is_approved  = 'true'
and a.is_approval_completed = 'true'
and a.invoice_type = 'AR'