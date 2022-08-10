SELECT e.ln_id
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
	,b.folio_id
	,CONCAT (
		b.first_name
		,' '
		,b.last_name
		) AS farmer_name
	,e.created
	,e.id
	,e.line_id
	,e.units
	,e.unit_price
	,e.total_price
	,f.product_id
	,g.name
	,g.code
	,d.name AS warehouse
	,c.name AS project
	,(
		CASE 
			WHEN g.code IN (
					'SMZ_HPY'
					,'SHM'
					,'SPL_F44'
					,'SMZ_OVW'
					,'SMZ_HPW'
					,'SSG_S14'
					,'SMZ_OVY'
					)
				THEN 'Seed'
			WHEN g.code IN (
					'NPK_ALR'
					,'NPK_CTL'
					,'NPK_CRZ'
					,'FTZ_DAP'
					,'FTZ_NPK'
					,'NPK_LKD'
					,'NPK_MTR'
					,'NPK_ALU'
					,'NPK_BJFT'
					,'MXN1'
					,'MXN3'
					,'ABN1'
					,'NPK_SFC'
					,'NPK_TAK'
					,'NPK_GDN'
					,'ABN3'
					,'URE_DGT'
					)
				THEN 'NPK'
			WHEN g.code IN (
					'CPP_AFS'
					,'CPP_AVN'
					,'CPP_CWD'
					,'CPP_ATZ'
					,'CPP_LAG'
					,'CPP_CLT'
					,'CPP_FTP'
					,'CPP_NOD'
					,'CPP_LFC'
					,'CPP_FUP'
					,'CPP_PFC'
					,'CPP_KAR'
					,'CPP_TDF'
					,'CPP_SOL'
					,'CPP_AMP'
					,'CPP_APS'
					,'CPP_PMX'
					,'CPP_RID'
					,'CPP_STG'
					,'CPP_DRG'
					,'CPP_KOM'
					,'CPP_MKG'
					,'CPP_PRQ'
					,'CPP_PEH'
					,'CPP_RDF'
					,'CPP_SS'
					,'CPP_UMX'
					,'CPP_VNS'
					,'CPP_HKT'
					,'CPP_UPT'
					,'CPP_VGR'
					,'CPP_PTS'
              		,'CPP_ATA'
					)
				THEN 'CPP'
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
				THEN 'Services'
			WHEN g.code IN (
					'FTZ_URE'
					,'URE_IND'
					,'URE_NTR'
					,'URE_DGT'
					)
				THEN 'Urea'
			ELSE 'Other'
			END
		) AS Input_type