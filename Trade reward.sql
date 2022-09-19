select 
 j.tid, j.board_type, j.volume, j.value, j.current_price, j.percentage_increase, round((j.value *j.percentage_increase)/ 100::numeric, 2) price_increase
 ,(round((j.value *j.percentage_increase)/ 100::numeric, 2) + j.value) as total_value
 ,j.community_name, j.community_creation
 ,j.code, j.name
, j.first_name , j.last_name, j.created, j.security_type, j.status , j.client_name, j.phone, j.email
from
(
select a.tid, a.board_type, a.units as volume, (a.order_price * a.units) as value, h.price as current_price
,round(abs((a.order_price - h.price)/a.order_price)*100::numeric, 3) as percentage_increase
, b.name as community_name, b.created as community_creation,c.code, c.name
, d.first_name , d.last_name, a.created, c.security_type, a.status , k.client_name, k.phone, k.email
from comx.trading_trade a
left join comx.crm_community b on a.promoter_community_id = b.id
left join comx.crm_security c on a.security_id = c.id
left join comx.crm_client d on b.owner_id = d.id
left join 
(select a.created, a.tid, a.board_type, a.units as volume, (a.order_price * a.units) as value, a.security_id
,concat(b.first_name,' ',b.last_name) client_name, b.phone, b.email, c.code, c.name
from comx.trading_trade a
inner join comx.crm_client b on a.client_id = b.id
inner join comx.crm_security c on a.security_id = c.id) k on a.tid = k.tid
left join (
select b.code, b.name, b.id,
a.created , a.price, a.lowest_price, a.highest_price 
from comx.trading_securityprice a
left join comx.crm_security b on a.security_id = b.id
where is_closing_price = 'true' 
and a.created::date = (current_date - INTERVAL '1 day')
) h on a.security_id = h.id
where a.status = 'Matched'
and K.client_name = 'Kabir Ariyo'
) as j