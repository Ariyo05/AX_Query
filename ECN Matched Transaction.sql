select a.created, a.matched_units, a.matched_price, c.code, c.name as security, b.order_type, b.board_type, b.brokerage_fee
,d.cid, d.first_name, d.last_name, b.volume_per_unit
from ovs.trade_matchedorder a
inner join ovs.trade_clientorderrequest b on a.order_id = b.id
inner join ovs.crm_security c on b.security_id = c.id
inner join ovs.crm_client d on a.client_id = d.id
where --a.created >= '2020-12-01 00:00:01.948504+00'
a.is_deleted = 'false'
order by a.created desc