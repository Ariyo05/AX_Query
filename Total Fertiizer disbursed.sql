SELECT DISTINCT a.ln_id
	,a.created
	,a.hectare
	,a.is_rejected
	,a.is_reverted
	,a.is_approved
	,a.is_approval_completed
	,a.approval_date
	,a.repayment_value
	,a.total_loan_value
	,a.insurance
	,a.admin_fee
	,a.crg
	,a.interest
	,a.admin_fee
	,a.equity
	,a.value_chain_management
	,a.maturity_date
	,a.farmer_id
	,a.data_identification_verification
	,b.folio_id
	,CONCAT (
		b.first_name
		,' '
		,b.last_name
		) AS farmer_name
	,b.phone
	,b.gender
	,b.dob
	,b.address
	,z.crop_list
	,i.name AS state_of_residence
	,j.name AS lga
	,d.name AS warehouse
	,m.name AS warehouse_state
	,l.name AS location
	,o.name AS Region
	,c.name AS project
	,k.name AS cooperative
	,SUM(CASE 
			WHEN g.code IN (
					'SMZ_HPY'
					,'SHM'
					,'SPL_F44'
					,'SMZ_OVW'
					,'SMZ_HPW'
					,'SSG_S14'
					,'SMZ_OVY'
					)
				THEN e.units
			ELSE 0
			END) AS SEED
	,SUM(CASE 
			WHEN g.code IN (
					'FTZ_NPK'
					,'FTZ_URE'
					,'NPK_CTL'
					,'URE_NTR'
					,'URE_IND'
					,'NPK_CRZ'
					,'NPK_MTR'
					,'NPK_ALR'
					,'NPK_BJFT'
					,'NPK_SFC'
					,'NPK_ALU'
					,'FTZ_DAP'
					,'NPK_LKD'
					)
				THEN e.units
			ELSE 0
			END) AS Fertilizer
	,SUM(CASE 
			WHEN g.code IN (
					'CPP_SOL'
					,'CPP_FUP'
					,'CPP_AMP'
					,'CPP_AVN'
					,'CPP_LAG'
					,'CPP_KOM'
					,'CPP_UMX'
					,'CPP_APS'
					,'CPP_PMX'
					,'CPP_PFC'
					,'CPP_CLT'
					,'CPP_AFS'
					,'CPP_PEH'
					,'CPP_KAR'
					,'CPP_DRG'
					,'CPP_VNS'
					,'CPP_LFC'
					,'CPP_TDF'
					,'CPP_STG'
					,'CPP_RDF'
					,'CPP_ATZ'
					,'CPP_PRQ'
					,'CPP_FTP'
					,'CPP_SS'
					,'CPP_RID'
					,'CPP_MKG'
					,'CPP_ATA'
					,'CPP_NOD'
					,'CPP_CWD'
					)
				THEN e.units
			ELSE 0
			END) AS CPP
	,SUM(CASE 
			WHEN g.code IN (
					'MPG'
					,'FDB'
					,'MCH_P&R'
					,'HMF'
					,'LFE'
					,'DCV'
					,'WUP'
					,'LMC'
					,'DML'
					,'AGG'
					,'VCM'
					)
				THEN e.units
			ELSE 0
			END) AS Services
FROM workbench.loan_loan a
LEFT JOIN workbench.loan_loanline e ON a.ln_id = e.ln_id
LEFT JOIN workbench.inventory_item f ON e.item_id = f.id
LEFT JOIN workbench.workbench_product g ON f.product_id = g.id
LEFT JOIN workbench.crm_farmer b ON a.farmer_id = b.id
LEFT JOIN workbench.project_project c ON a.project_id = c.id
LEFT JOIN workbench.workbench_warehouse d ON a.warehouse_id = d.id
LEFT JOIN workbench.location_lga j ON b.lga_of_residence_id = j.id
LEFT JOIN workbench.workbench_cooperative k ON b.cooperative_id = k.id
LEFT JOIN workbench.workbench_cell h ON b.cooperative_id = h.id
LEFT JOIN workbench.location_state i ON b.state_of_residence_id = i.id
LEFT JOIN workbench.location_location n ON d.location_id = n.id
LEFT JOIN workbench.location_baselocation l ON n.base_location_id = l.id
LEFT JOIN workbench.location_state m ON l.state_id = m.id
LEFT JOIN workbench.location_region o on m.region_id = n.id
LEFT JOIN (
	SELECT DISTINCT a.farmer_id
		,string_agg(c.name, ', ') AS crop_list
	FROM workbench.crm_farmer_crop_type a
	INNER JOIN workbench.inventory_item b ON a.item_id = b.id
	INNER JOIN workbench.workbench_product c ON b.product_id = c.id
	GROUP BY a.farmer_id
	) z ON a.farmer_id = z.farmer_id
WHERE a.is_approved = true
	AND a.is_approval_completed = true
GROUP BY e.ln_id
	,a.id
	,b.folio_id
	,b.first_name
	,b.last_name
	,d.name
	,c.name
	,b.phone
	,b.gender
	,b.dob
	,b.address
	,i.name
	,k.name
	,m.name
	,j.name
	,l.name
	,z.crop_list
    ,o.name
	limit 10
