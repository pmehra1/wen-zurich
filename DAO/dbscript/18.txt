USE [FNA]
GO

delete from option3FundAssetMapping
where fundid in (14)

delete from fund_risk_profile_mapping
where fundid in (14)

delete from fund_lkp
where id in (14)
