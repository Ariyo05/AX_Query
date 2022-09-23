SELECT 
    a.created, a.updated, a.is_deleted, a.folio_id, a.title, a.first_name, a.last_name,a.middle_name, a.address, a.gender, a.marital_status, a.dob, a.phone, a.village
	,a.farm_size, a.passport_type, a.passport_number, a.nok_phone, a.nok_name, a.nok_relationship
	, a.bvn, a.farm_coordinates, a.is_blacklist, a.languages, a.client_id, a.is_farm_coordinate_verified, a.is_phone_verified
	,d.name AS warehouse_name
	,d.code AS warehouse_code
	,d.tenant_id
	, (Case when a.bvn <> '' then 'have_bvn' 
	   		when a.bvn = '' then 'no_bvn' else 'nil' end) as bvn_state 
    , (Case when a.passport_type <> '' then 'have_id' 
	   		when a.passport_type = '' then 'no_id' else 'nil' end) as id_state 
    ,z.crop_name
	,z.crop_code
	,z.crop_type
	,l.name AS warehouse_location
	,m.name AS warehouse_state
	,o.name as region
	,q.name as feo_name
	,q.code as feo_code
	 ,r.name as cooporative_name
	 ,r.code as cooporative_code
	 ,w.maxx
	 ,( case when w.maxx = '1' then 'true' else 'false' end) collect_loan
FROM workbench.crm_farmer a
LEFT JOIN workbench.workbench_warehouse d ON a.warehouse_id = d.id
LEFT JOIN workbench.location_location k ON d.location_id = k.id
LEFT JOIN workbench.location_baselocation l ON k.base_location_id = l.id
LEFT JOIN workbench.location_state m ON l.state_id = m.id
LEFT JOIN workbench.location_region o ON m.region_id = o.id  
left join workbench.workbench_cell q on a.cell_id = q.id
left join workbench.workbench_cooperative r on a.cooperative_id = r.id
left join (select farmer_id, max(row_num) maxx
from (
select farmer_id
	,'1' collected_loan
	,row_number () over (partition by farmer_id) row_num
from workbench.loan_loan
	) as a
group by a.farmer_id ) w on a.id = w.farmer_id
LEFT JOIN (
	SELECT DISTINCT a.farmer_id
		,string_agg(c.code, ', ') AS crop_code
		,string_agg(c.name, ', ') AS crop_name
		,string_agg(c.product_type, ', ') AS crop_type
	FROM workbench.crm_farmer_crop_type a
	INNER JOIN workbench.inventory_item b ON a.item_id = b.id
	INNER JOIN workbench.workbench_product c ON b.product_id = c.id
	GROUP BY a.farmer_id
	) z ON a.id = z.farmer_id



-- SELECT 
--     a.created, a.updated, a.is_deleted, a.folio_id, a.title, a.first_name, a.last_name,a.middle_name, a.address, a.gender, a.marital_status, a.dob, a.phone, a.village
-- 	,a.farm_size, a.passport_type, a.passport_number, a.nok_phone, a.nok_name, a.nok_relationship
-- 	, a.bvn, a.farm_coordinates, a.is_blacklist, a.languages, a.client_id, a.is_farm_coordinate_verified, a.is_phone_verified
-- 	,d.name AS warehouse_name
-- 	,d.code AS warehouse_code
-- 	,d.tenant_id
--     ,p.collect_loan
-- 	, (Case when a.bvn <> '' then 'have_bvn' 
-- 	   		when a.bvn = '' then 'no_bvn' else 'nil' end) as bvn_state 
--     , (Case when a.passport_type <> '' then 'have_id' 
-- 	   		when a.passport_type = '' then 'no_id' else 'nil' end) as id_state 
--     ,z.crop_name
-- 	,z.crop_code
-- 	,z.crop_type
-- 	,l.name AS warehouse_location
-- 	,m.name AS warehouse_state
-- 	,o.name as region
-- 	,q.name as feo_name
-- 	,q.code as feo_code
--      ,p.is_approved , p.is_approval_completed
-- 	 ,r.name as cooporative_name
-- 	 ,r.code as cooporative_code
-- FROM workbench.crm_farmer a
-- LEFT JOIN workbench.workbench_warehouse d ON a.warehouse_id = d.id
-- LEFT JOIN workbench.location_location k ON d.location_id = k.id
-- LEFT JOIN workbench.location_baselocation l ON k.base_location_id = l.id
-- LEFT JOIN workbench.location_state m ON l.state_id = m.id
-- LEFT JOIN workbench.location_region o ON m.region_id = o.id  
-- left join workbench.workbench_cell q on a.cell_id = q.id
-- left join workbench.workbench_cooperative r on a.cooperative_id = r.id
-- LEFT JOIN 
-- 	(select count(a.farmer_id) as collect_loan, b.folio_id, a.repayment_value, a.total_loan_value, a.project_id, a.warehouse_id  ,a.is_approved , a.is_approval_completed
-- from workbench.loan_loan a
-- inner join workbench.crm_farmer b on a.farmer_id = b.id
-- group by a.farmer_id, b.folio_id, a.repayment_value, a.total_loan_value, a.project_id, a.warehouse_id ,a.is_approved , a.is_approval_completed 
-- 	 ) as p on a.folio_id = p.folio_id
-- LEFT JOIN (
-- 	SELECT DISTINCT a.farmer_id
-- 		,string_agg(c.code, ', ') AS crop_code
-- 		,string_agg(c.name, ', ') AS crop_name
-- 		,string_agg(c.product_type, ', ') AS crop_type
-- 	FROM workbench.crm_farmer_crop_type a
-- 	INNER JOIN workbench.inventory_item b ON a.item_id = b.id
-- 	INNER JOIN workbench.workbench_product c ON b.product_id = c.id
-- 	GROUP BY a.farmer_id
-- 	) z ON a.id = z.farmer_id
