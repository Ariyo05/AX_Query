
select a.created, a.updated, a.transaction_type, a.transaction, a.amount, a.amount_before, a.amount_after, a.extra_note
, b.user_id , a.settlement_account_id , b.id, b.user_id , c.id, c.username
from workbench.cash_advance_settlementaccounttransaction a
inner join workbench.cash_advance_settlementaccount b on a.settlement_account_id = b.id
inner join workbench.account_user c on b.user_id = c.id
where b.tenant_id = 7
and c.username = 'zisuwa'