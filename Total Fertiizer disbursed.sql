SELECT a.ln_id
	,a.hectare
	,a.repayment_value
	,a.total_loan_value
	,a.insurance
	,a.admin_fee
	,a.crg
	,a.interest
	,a.data_identification_verification
	,a.equity
	,a.value_chain_management
	,a.farmer_id
	,a.created
	,b.folio_id
	,CONCAT (
		b.first_name
		,' '
		,b.last_name
		) AS farmer_name
	,b.gender
	,e.name AS state_of_residence
	,d.name AS warehouse
	,j.name AS warehouse_location
	,k.name AS warehouse_state
	,d.tenant_id
	,c.created as project_start_date
	,c.code project_code
	,c.name AS project
	,c.maturity_date 
	,f.name AS cooperative
	,f.code AS cooperative_code
	,g.name AS cell
	,g.code AS cell_code
	,l.name as region
	,a.is_rejected
    , a.is_deleted
	, a.is_approved
    , a.is_approval_completed
    , a.amount_repaid
FROM workbench.loan_loan a
LEFT JOIN workbench.crm_farmer b ON a.farmer_id = b.id
LEFT JOIN workbench.project_project c ON a.project_id = c.id
LEFT JOIN workbench.workbench_warehouse d ON a.warehouse_id = d.id
LEFT JOIN workbench.location_state e ON b.state_of_residence_id = e.id
LEFT JOIN workbench.workbench_cooperative f ON b.cooperative_id = f.id
LEFT JOIN workbench.workbench_cell g ON b.cell_id = g.id
LEFT JOIN workbench.location_location h ON d.location_id = h.id
LEFT JOIN workbench.location_baselocation j ON h.base_location_id = j.id
LEFT JOIN workbench.location_state k ON j.state_id = k.id
LEFT JOIN workbench.location_region l on k.region_id = l.id
    where a.is_approval_completed = 'True'
	and a.is_approved = 'True'