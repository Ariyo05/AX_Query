select a.created ,concat(b.first_name,' ',b.last_name) initiator_name, a.amount, a.transaction_type, a.transaction_desc, a.transaction_status
, c.cid, c.name client_name, d.name staff_name
from workbench.central_payment_centralpaymentdirective a
left join workbench.account_user b on a.initiator_id = b.id
left join workbench.crm_client c on a.client_id = c.id
left join 
( select a.user_id, concat(b.first_name,' ',b.last_name) as name from workbench.central_payment_centralpaymentdirective a
 inner join workbench.account_user b on a.user_id = b.id ) d on a.user_id = d.user_id
order by a.created desc
limit 10