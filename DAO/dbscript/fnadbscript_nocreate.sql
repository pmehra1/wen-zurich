USE [FNA]
GO
/****** Object:  ForeignKey [FK_familyMemberDetails_familyMemberDetails]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_familyMemberDetails_familyMemberDetails]') AND parent_object_id = OBJECT_ID(N'[dbo].[familyMemberDetails]'))
ALTER TABLE [dbo].[familyMemberDetails] DROP CONSTRAINT [FK_familyMemberDetails_familyMemberDetails]
GO
/****** Object:  ForeignKey [FK_country_educationgoals]    Script Date: 09/26/2012 00:52:26 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_country_educationgoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[educationgoals]'))
ALTER TABLE [dbo].[educationgoals] DROP CONSTRAINT [FK_country_educationgoals]
GO
/****** Object:  ForeignKey [FK_existingassetsg_savinggoals]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_existingassetsg_savinggoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[existingassetsg]'))
ALTER TABLE [dbo].[existingassetsg] DROP CONSTRAINT [FK_existingassetsg_savinggoals]
GO
/****** Object:  ForeignKey [FK_existingassetrg_retirementgoals]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_existingassetrg_retirementgoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[existingassetrg]'))
ALTER TABLE [dbo].[existingassetrg] DROP CONSTRAINT [FK_existingassetrg_retirementgoals]
GO
/****** Object:  ForeignKey [FK_existingasseteg_educationgoals]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_existingasseteg_educationgoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[existingasseteg]'))
ALTER TABLE [dbo].[existingasseteg] DROP CONSTRAINT [FK_existingasseteg_educationgoals]
GO
/****** Object:  StoredProcedure [dbo].[CloneCase]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CloneCase]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CloneCase]
GO
/****** Object:  StoredProcedure [dbo].[sp_getGapSummary]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_getGapSummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_getGapSummary]
GO
/****** Object:  Table [dbo].[existingasseteg]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_existingasseteg_educationgoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[existingasseteg]'))
ALTER TABLE [dbo].[existingasseteg] DROP CONSTRAINT [FK_existingasseteg_educationgoals]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[existingasseteg]') AND type in (N'U'))
DROP TABLE [dbo].[existingasseteg]
GO
/****** Object:  Table [dbo].[existingassetrg]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_existingassetrg_retirementgoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[existingassetrg]'))
ALTER TABLE [dbo].[existingassetrg] DROP CONSTRAINT [FK_existingassetrg_retirementgoals]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[existingassetrg]') AND type in (N'U'))
DROP TABLE [dbo].[existingassetrg]
GO
/****** Object:  Table [dbo].[existingassetsg]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_existingassetsg_savinggoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[existingassetsg]'))
ALTER TABLE [dbo].[existingassetsg] DROP CONSTRAINT [FK_existingassetsg_savinggoals]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[existingassetsg]') AND type in (N'U'))
DROP TABLE [dbo].[existingassetsg]
GO
/****** Object:  StoredProcedure [dbo].[sp_getPortFolioDetail]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_getPortFolioDetail]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_getPortFolioDetail]
GO
/****** Object:  StoredProcedure [dbo].[sp_getPortFolioDetail_With_Master]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_getPortFolioDetail_With_Master]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_getPortFolioDetail_With_Master]
GO
/****** Object:  StoredProcedure [dbo].[sp_getPortFolioMaster]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_getPortFolioMaster]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_getPortFolioMaster]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveGapSummary]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SaveGapSummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_SaveGapSummary]
GO
/****** Object:  StoredProcedure [dbo].[sp_SavePortFolioDetail]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SavePortFolioDetail]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_SavePortFolioDetail]
GO
/****** Object:  StoredProcedure [dbo].[sp_SavePortFolioMaster]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SavePortFolioMaster]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_SavePortFolioMaster]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePortFolioMaster]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_UpdatePortFolioMaster]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_UpdatePortFolioMaster]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGapSummary]    Script Date: 09/26/2012 00:52:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DeleteGapSummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DeleteGapSummary]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeletePortfolioBuilderForCP]    Script Date: 09/26/2012 00:52:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DeletePortfolioBuilderForCP]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DeletePortfolioBuilderForCP]
GO
/****** Object:  Table [dbo].[educationgoals]    Script Date: 09/26/2012 00:52:26 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_country_educationgoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[educationgoals]'))
ALTER TABLE [dbo].[educationgoals] DROP CONSTRAINT [FK_country_educationgoals]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[educationgoals]') AND type in (N'U'))
DROP TABLE [dbo].[educationgoals]
GO
/****** Object:  Table [dbo].[exceptionlog]    Script Date: 09/26/2012 00:52:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[exceptionlog]') AND type in (N'U'))
DROP TABLE [dbo].[exceptionlog]
GO
/****** Object:  Table [dbo].[clonemappingids]    Script Date: 09/26/2012 00:52:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[clonemappingids]') AND type in (N'U'))
DROP TABLE [dbo].[clonemappingids]
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertEmptyToZero]    Script Date: 09/26/2012 00:52:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConvertEmptyToZero]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ConvertEmptyToZero]
GO
/****** Object:  Table [dbo].[countrycostofeducation]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[countrycostofeducation]') AND type in (N'U'))
DROP TABLE [dbo].[countrycostofeducation]
GO
/****** Object:  Table [dbo].[activity]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[activity]') AND type in (N'U'))
DROP TABLE [dbo].[activity]
GO
/****** Object:  Table [dbo].[activitystatus]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[activitystatus]') AND type in (N'U'))
DROP TABLE [dbo].[activitystatus]
GO
/****** Object:  Table [dbo].[allocation_type_lkp]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[allocation_type_lkp]') AND type in (N'U'))
DROP TABLE [dbo].[allocation_type_lkp]
GO
/****** Object:  Table [dbo].[asset_allocation_mapping]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[asset_allocation_mapping]') AND type in (N'U'))
DROP TABLE [dbo].[asset_allocation_mapping]
GO
/****** Object:  Table [dbo].[assetAndLiability]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[assetAndLiability]') AND type in (N'U'))
DROP TABLE [dbo].[assetAndLiability]
GO
/****** Object:  Table [dbo].[assets_lkp]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[assets_lkp]') AND type in (N'U'))
DROP TABLE [dbo].[assets_lkp]
GO
/****** Object:  Table [dbo].[assumption]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[assumption]') AND type in (N'U'))
DROP TABLE [dbo].[assumption]
GO
/****** Object:  Table [dbo].[CkaAssessment]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CkaAssessment]') AND type in (N'U'))
DROP TABLE [dbo].[CkaAssessment]
GO
/****** Object:  Table [dbo].[familyMemberDetails]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_familyMemberDetails_familyMemberDetails]') AND parent_object_id = OBJECT_ID(N'[dbo].[familyMemberDetails]'))
ALTER TABLE [dbo].[familyMemberDetails] DROP CONSTRAINT [FK_familyMemberDetails_familyMemberDetails]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[familyMemberDetails]') AND type in (N'U'))
DROP TABLE [dbo].[familyMemberDetails]
GO
/****** Object:  Table [dbo].[familyNeeds]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[familyNeeds]') AND type in (N'U'))
DROP TABLE [dbo].[familyNeeds]
GO
/****** Object:  Table [dbo].[familyNeedsAssets]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[familyNeedsAssets]') AND type in (N'U'))
DROP TABLE [dbo].[familyNeedsAssets]
GO
/****** Object:  Table [dbo].[fund_lkp]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fund_lkp]') AND type in (N'U'))
DROP TABLE [dbo].[fund_lkp]
GO
/****** Object:  Table [dbo].[fund_risk_profile_mapping]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fund_risk_profile_mapping]') AND type in (N'U'))
DROP TABLE [dbo].[fund_risk_profile_mapping]
GO
/****** Object:  Table [dbo].[gapSummary]    Script Date: 09/26/2012 00:52:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gapSummary]') AND type in (N'U'))
DROP TABLE [dbo].[gapSummary]
GO
/****** Object:  Table [dbo].[gapSummaryNeedTypes]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gapSummaryNeedTypes]') AND type in (N'U'))
DROP TABLE [dbo].[gapSummaryNeedTypes]
GO
/****** Object:  Table [dbo].[incomeExpense]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[incomeExpense]') AND type in (N'U'))
DROP TABLE [dbo].[incomeExpense]
GO
/****** Object:  Table [dbo].[incomeExpenseOthers]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[incomeExpenseOthers]') AND type in (N'U'))
DROP TABLE [dbo].[incomeExpenseOthers]
GO
/****** Object:  Table [dbo].[insuranceArrangementEducation]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[insuranceArrangementEducation]') AND type in (N'U'))
DROP TABLE [dbo].[insuranceArrangementEducation]
GO
/****** Object:  Table [dbo].[insuranceArrangementRetirement]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[insuranceArrangementRetirement]') AND type in (N'U'))
DROP TABLE [dbo].[insuranceArrangementRetirement]
GO
/****** Object:  Table [dbo].[insuranceArrangementSaving]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[insuranceArrangementSaving]') AND type in (N'U'))
DROP TABLE [dbo].[insuranceArrangementSaving]
GO
/****** Object:  Table [dbo].[investedAssetOthers]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[investedAssetOthers]') AND type in (N'U'))
DROP TABLE [dbo].[investedAssetOthers]
GO
/****** Object:  Table [dbo].[liabilityOthers]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[liabilityOthers]') AND type in (N'U'))
DROP TABLE [dbo].[liabilityOthers]
GO
/****** Object:  Table [dbo].[myNeeds]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[myNeeds]') AND type in (N'U'))
DROP TABLE [dbo].[myNeeds]
GO
/****** Object:  Table [dbo].[myNeedsCriticalAssets]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[myNeedsCriticalAssets]') AND type in (N'U'))
DROP TABLE [dbo].[myNeedsCriticalAssets]
GO
/****** Object:  Table [dbo].[myNeedsDisabilityAssets]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[myNeedsDisabilityAssets]') AND type in (N'U'))
DROP TABLE [dbo].[myNeedsDisabilityAssets]
GO
/****** Object:  Table [dbo].[myzurichadviser]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[myzurichadviser]') AND type in (N'U'))
DROP TABLE [dbo].[myzurichadviser]
GO
/****** Object:  Table [dbo].[option3FundAssetMapping]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[option3FundAssetMapping]') AND type in (N'U'))
DROP TABLE [dbo].[option3FundAssetMapping]
GO
/****** Object:  Table [dbo].[personaldetails]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[personaldetails]') AND type in (N'U'))
DROP TABLE [dbo].[personaldetails]
GO
/****** Object:  Table [dbo].[personalUseAssetsOthers]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[personalUseAssetsOthers]') AND type in (N'U'))
DROP TABLE [dbo].[personalUseAssetsOthers]
GO
/****** Object:  Table [dbo].[portFolioBuilderDetail]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portFolioBuilderDetail]') AND type in (N'U'))
DROP TABLE [dbo].[portFolioBuilderDetail]
GO
/****** Object:  Table [dbo].[portFolioBuilderMaster]    Script Date: 09/26/2012 00:52:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portFolioBuilderMaster]') AND type in (N'U'))
DROP TABLE [dbo].[portFolioBuilderMaster]
GO
/****** Object:  Table [dbo].[priorityDetails]    Script Date: 09/26/2012 00:52:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[priorityDetails]') AND type in (N'U'))
DROP TABLE [dbo].[priorityDetails]
GO
/****** Object:  Table [dbo].[retirementgoals]    Script Date: 09/26/2012 00:52:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[retirementgoals]') AND type in (N'U'))
DROP TABLE [dbo].[retirementgoals]
GO
/****** Object:  Table [dbo].[risk_profile_lkp]    Script Date: 09/26/2012 00:52:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[risk_profile_lkp]') AND type in (N'U'))
DROP TABLE [dbo].[risk_profile_lkp]
GO
/****** Object:  Table [dbo].[riskprofile]    Script Date: 09/26/2012 00:52:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[riskprofile]') AND type in (N'U'))
DROP TABLE [dbo].[riskprofile]
GO
/****** Object:  Table [dbo].[RiskProfileAnalysis]    Script Date: 09/26/2012 00:52:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RiskProfileAnalysis]') AND type in (N'U'))
DROP TABLE [dbo].[RiskProfileAnalysis]
GO
/****** Object:  Table [dbo].[salesportalinfo]    Script Date: 09/26/2012 00:52:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[salesportalinfo]') AND type in (N'U'))
DROP TABLE [dbo].[salesportalinfo]
GO
/****** Object:  Table [dbo].[savinggoals]    Script Date: 09/26/2012 00:52:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[savinggoals]') AND type in (N'U'))
DROP TABLE [dbo].[savinggoals]
GO
/****** Object:  Table [dbo].[savinggoals]    Script Date: 09/26/2012 00:52:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[savinggoals]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[savinggoals](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[caseid] [nvarchar](50) NOT NULL,
	[goal] [nvarchar](50) NULL,
	[yrstoaccumulate] [nvarchar](5) NULL,
	[amtneededfv] [nvarchar](50) NULL,
	[maturityvalue] [nvarchar](50) NULL,
	[total] [nvarchar](50) NULL,
	[regularannualcontrib] [nvarchar](50) NULL,
	[deleted] [bit] NULL,
	[existingassetstotal] [nvarchar](50) NULL,
	[inflationrate] [nvarchar](50) NULL,
 CONSTRAINT [PK_savinggoals] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[savinggoals]') AND name = N'IX_savinggoals')
CREATE NONCLUSTERED INDEX [IX_savinggoals] ON [dbo].[savinggoals] 
(
	[caseid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[salesportalinfo]    Script Date: 09/26/2012 00:52:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[salesportalinfo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[salesportalinfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[caseid] [nvarchar](50) NULL,
	[activityid] [nvarchar](50) NULL,
	[casestatus] [nvarchar](500) NULL,
	[userid] [nvarchar](500) NULL,
	[activitytype] [nvarchar](500) NULL,
	[redirecturl] [nvarchar](500) NULL,
	[salesportalurl] [nvarchar](500) NULL,
	[userfirstname] [nvarchar](500) NULL,
	[userlastname] [nvarchar](500) NULL,
	[roletype] [nvarchar](500) NULL,
	[usertype] [nvarchar](500) NULL,
	[country] [nvarchar](500) NULL,
	[saleschannel] [nvarchar](500) NULL,
 CONSTRAINT [PK_salesportalinfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[salesportalinfo]') AND name = N'IX_salesportalinfo')
CREATE NONCLUSTERED INDEX [IX_salesportalinfo] ON [dbo].[salesportalinfo] 
(
	[caseid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RiskProfileAnalysis]    Script Date: 09/26/2012 00:52:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RiskProfileAnalysis]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RiskProfileAnalysis](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[riskApetiteQuestion1option1] [nvarchar](10) NULL,
	[riskApetiteQuestion1option2] [nvarchar](10) NULL,
	[riskApetiteQuestion1option3] [nvarchar](10) NULL,
	[riskApetiteQuestion1option4] [nvarchar](10) NULL,
	[riskApetiteQuestion1option5] [nvarchar](10) NULL,
	[riskApetiteQuestion1option6] [nvarchar](10) NULL,
	[riskApetiteQuestion2option1] [nvarchar](10) NULL,
	[riskApetiteQuestion2option2] [nvarchar](10) NULL,
	[riskApetiteQuestion2option3] [nvarchar](10) NULL,
	[riskApetiteQuestion2option4] [nvarchar](10) NULL,
	[riskApetiteQuestion3option1] [nvarchar](10) NULL,
	[riskApetiteQuestion3option2] [nvarchar](10) NULL,
	[riskApetiteQuestion3option3] [nvarchar](10) NULL,
	[riskApetiteQuestion3option4] [nvarchar](10) NULL,
	[riskApetiteQuestion3option5] [nvarchar](10) NULL,
	[riskApetiteQuestion4option1] [nvarchar](10) NULL,
	[riskApetiteQuestion4option2] [nvarchar](10) NULL,
	[riskApetiteQuestion4option3] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion1option1] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion1option2] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion1option3] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion1option4] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion2option1] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion2option2] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion2option3] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion3option1] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion3option2] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion3option3] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion3option4] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion4option1] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion4option2] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion4option3] [nvarchar](10) NULL,
	[measuringRiskTakingAbilityQuestion4option4] [nvarchar](10) NULL,
	[agreeWithRiskProfileoption1] [nvarchar](10) NULL,
	[agreeWithRiskProfileoption2] [nvarchar](10) NULL,
	[riskProfileValue] [nvarchar](10) NULL,
	[caseId] [varchar](50) NULL,
	[riskProfileName] [varchar](50) NULL,
 CONSTRAINT [PK_RiskProfileAnalysis] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RiskProfileAnalysis]') AND name = N'IX_RiskProfileAnalysis')
CREATE NONCLUSTERED INDEX [IX_RiskProfileAnalysis] ON [dbo].[RiskProfileAnalysis] 
(
	[caseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[riskprofile]    Script Date: 09/26/2012 00:52:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[riskprofile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[riskprofile](
	[ID] [numeric](18, 0) NOT NULL,
	[RiskProfiletype] [nvarchar](50) NULL,
 CONSTRAINT [PK_riskprofile] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[riskprofile] ([ID], [RiskProfiletype]) VALUES (CAST(1 AS Numeric(18, 0)), N'Low risk')
INSERT [dbo].[riskprofile] ([ID], [RiskProfiletype]) VALUES (CAST(2 AS Numeric(18, 0)), N'Medium Risk')
INSERT [dbo].[riskprofile] ([ID], [RiskProfiletype]) VALUES (CAST(3 AS Numeric(18, 0)), N'High risk')
/****** Object:  Table [dbo].[risk_profile_lkp]    Script Date: 09/26/2012 00:52:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[risk_profile_lkp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[risk_profile_lkp](
	[id] [smallint] NOT NULL,
	[fullName] [nvarchar](90) NULL,
 CONSTRAINT [PK__risk_pro__3213E83F4B780056] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[risk_profile_lkp] ([id], [fullName]) VALUES (0, N'Capital Preservation')
INSERT [dbo].[risk_profile_lkp] ([id], [fullName]) VALUES (1, N'Cautious')
INSERT [dbo].[risk_profile_lkp] ([id], [fullName]) VALUES (2, N'Moderately Cautious')
INSERT [dbo].[risk_profile_lkp] ([id], [fullName]) VALUES (3, N'Balanced')
INSERT [dbo].[risk_profile_lkp] ([id], [fullName]) VALUES (4, N'Moderately Adventurous')
INSERT [dbo].[risk_profile_lkp] ([id], [fullName]) VALUES (5, N'Adventurous')
/****** Object:  Table [dbo].[retirementgoals]    Script Date: 09/26/2012 00:52:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[retirementgoals]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[retirementgoals](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[caseid] [nvarchar](50) NOT NULL,
	[intendedretirementage] [nvarchar](5) NULL,
	[incomerequired] [nvarchar](50) NULL,
	[yrstoretirement] [nvarchar](5) NULL,
	[futureincome] [nvarchar](50) NULL,
	[sourcesofincome] [nvarchar](50) NULL,
	[totalfirstyrincome] [nvarchar](50) NULL,
	[durationretirement] [nvarchar](5) NULL,
	[lumpsumrequired] [nvarchar](50) NULL,
	[maturityvalue] [nvarchar](50) NULL,
	[total] [nvarchar](50) NULL,
	[selforspouse] [nvarchar](10) NULL,
	[existingassetstotal] [nvarchar](50) NULL,
	[inflationrate] [nvarchar](50) NULL,
	[inflationreturnrate] [nvarchar](50) NULL,
 CONSTRAINT [PK_retirementgoals] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[retirementgoals]') AND name = N'IX_retirementgoals')
CREATE NONCLUSTERED INDEX [IX_retirementgoals] ON [dbo].[retirementgoals] 
(
	[caseid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[priorityDetails]    Script Date: 09/26/2012 00:52:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[priorityDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[priorityDetails](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[protection1] [nchar](10) NULL,
	[protection2] [nchar](10) NULL,
	[protection3] [nchar](10) NULL,
	[savings1] [nchar](10) NULL,
	[savings2] [nchar](10) NULL,
	[savings3] [nchar](10) NULL,
	[caseid] [nvarchar](50) NULL,
	[protection4] [nchar](10) NULL,
 CONSTRAINT [PK_priorityDetails] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[priorityDetails]') AND name = N'IX_priorityDetails')
CREATE NONCLUSTERED INDEX [IX_priorityDetails] ON [dbo].[priorityDetails] 
(
	[caseid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[portFolioBuilderMaster]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portFolioBuilderMaster]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portFolioBuilderMaster](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[caseId] [nvarchar](50) NOT NULL,
	[riskProfileId] [int] NOT NULL,
	[followAssetAllocationOnRiskProfileYesNo] [bit] NOT NULL,
	[agreeWithRiskProfile] [bit] NULL,
	[preferredRiskProfile] [int] NULL,
	[assetAllocationOnRiskProfileYesNo] [bit] NOT NULL,
	[includeNonCoreFundsYesNo] [bit] NOT NULL,
	[premiumSelect] [int] NULL,
	[premiumAmount] [decimal](25, 5) NULL,
	[paymentMode] [int] NULL,
	[premiumPercent] [decimal](10, 5) NULL,
	[premiumTotalAmount] [decimal](25, 5) NULL,
 CONSTRAINT [PK_portFolioBuilderMaster] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[portFolioBuilderMaster]') AND name = N'IX_portFolioBuilderMaster')
CREATE NONCLUSTERED INDEX [IX_portFolioBuilderMaster] ON [dbo].[portFolioBuilderMaster] 
(
	[caseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[portFolioBuilderDetail]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portFolioBuilderDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portFolioBuilderDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[portFolioBuilderId] [int] NOT NULL,
	[assetClassId] [int] NOT NULL,
	[fundId] [int] NOT NULL,
	[allocationPercentage] [int] NULL,
	[amount] [decimal](25, 5) NULL,
 CONSTRAINT [PK_portFolioBuilderDetail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[personalUseAssetsOthers]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[personalUseAssetsOthers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[personalUseAssetsOthers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[assetLiabilityId] [int] NOT NULL,
	[caseId] [nvarchar](50) NULL,
	[assetDesc] [nvarchar](50) NULL,
	[cpf] [nvarchar](50) NULL,
	[cash] [nvarchar](50) NULL,
	[date] [date] NULL,
 CONSTRAINT [PK_personalUseAssetsOthers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[personalUseAssetsOthers]') AND name = N'IX_personalUseAssetsOthers')
CREATE NONCLUSTERED INDEX [IX_personalUseAssetsOthers] ON [dbo].[personalUseAssetsOthers] 
(
	[caseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[personaldetails]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[personaldetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[personaldetails](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](5) NULL,
	[titleothers] [nvarchar](50) NULL,
	[name] [nvarchar](500) NULL,
	[gender] [nvarchar](10) NULL,
	[nric] [nvarchar](500) NULL,
	[nationality] [nvarchar](50) NULL,
	[nationalityothers] [nvarchar](50) NULL,
	[datepicker] [nvarchar](50) NULL,
	[maritalstatus] [nvarchar](50) NULL,
	[issmoker] [nvarchar](5) NULL,
	[address] [nvarchar](1000) NULL,
	[employmentstatus] [nvarchar](20) NULL,
	[occupation] [nvarchar](1000) NULL,
	[companyname] [nvarchar](1000) NULL,
	[contactnumber] [nvarchar](50) NULL,
	[contactnumberfax] [nvarchar](50) NULL,
	[contactnumberhp] [nvarchar](50) NULL,
	[contactnumberoffice] [nvarchar](50) NULL,
	[email] [nvarchar](500) NULL,
	[educationlevel] [nvarchar](50) NULL,
	[medicalcondition] [nvarchar](50) NULL,
	[medicalconditiondetails] [nvarchar](1000) NULL,
	[nominee] [nvarchar](5) NULL,
	[caseid] [nvarchar](50) NULL,
	[will] [nvarchar](5) NULL,
	[surname] [nvarchar](500) NULL,
 CONSTRAINT [PK_personaldetails] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[personaldetails]') AND name = N'IX_personaldetails')
CREATE NONCLUSTERED INDEX [IX_personaldetails] ON [dbo].[personaldetails] 
(
	[caseid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[option3FundAssetMapping]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[option3FundAssetMapping]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[option3FundAssetMapping](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](130) NULL,
	[fundId] [smallint] NULL,
	[sorting_order] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[option3FundAssetMapping] ON
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (1, N'Asian Bond (H)', 1, 8)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (4, N'Emerging Market Debt (H)', 4, 4)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (5, N'Emerging Market Equities', 5, 7)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (6, N'Emerging Markets Equities', 6, 7)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (7, N'Global Bond (H)', 7, 3)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (8, N'Global Equity (U)', 8, 6)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (9, N'Global Equity (U)', 9, 6)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (10, N'Global Real Asset Equity', 10, 8)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (11, N'Money Market', 11, 1)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (13, N'Asian Small Cap Equity', 13, 8)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (14, N'Latin America Equity', 14, 8)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (15, N'Natural Resource Equity Sector', 15, 8)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (16, N'Gold and Precious Metals Equity', 16, 8)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (17, N'Biotechnology Equity Sector', 17, 8)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (18, N'Pharma & Health Equity Sector', 18, 8)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (19, N'Natural Resource Equity Sector', 19, 8)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (20, N'ASEAN Equity', 20, 8)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (21, N'Greater China Equity', 21, 8)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (22, N'Singapore Bond', 22, 2)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (24, N'Singapore Bond', 24, 2)
INSERT [dbo].[option3FundAssetMapping] ([id], [name], [fundId], [sorting_order]) VALUES (25, N'Singapore Equities', 25, 5)
SET IDENTITY_INSERT [dbo].[option3FundAssetMapping] OFF
/****** Object:  Table [dbo].[myzurichadviser]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[myzurichadviser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[myzurichadviser](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[caseid] [nvarchar](50) NULL,
	[selectedoptionid] [int] NULL,
	[selectedoptionothers] [nvarchar](250) NULL,
 CONSTRAINT [PK_myzurichadviser] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[myzurichadviser]') AND name = N'IX_myzurichadviser')
CREATE NONCLUSTERED INDEX [IX_myzurichadviser] ON [dbo].[myzurichadviser] 
(
	[caseid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[myNeedsDisabilityAssets]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[myNeedsDisabilityAssets]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[myNeedsDisabilityAssets](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[myNeedId] [int] NOT NULL,
	[asset] [nvarchar](50) NULL,
	[presentValue] [nvarchar](50) NULL,
 CONSTRAINT [PK_protectionGoalsMyNeedsDisbtyAssets] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[myNeedsCriticalAssets]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[myNeedsCriticalAssets]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[myNeedsCriticalAssets](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[myNeedId] [int] NOT NULL,
	[asset] [nvarchar](50) NULL,
	[presentValue] [nvarchar](50) NULL,
 CONSTRAINT [PK_protectionGoalsMyNeedsCrtlAssets] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[myNeeds]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[myNeeds]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[myNeeds](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[caseId] [nvarchar](50) NOT NULL,
	[lumpSumRequiredForTreatment] [nvarchar](50) NULL,
	[criticalIllnessInsurance] [nvarchar](50) NULL,
	[existingAssetsMyneeds] [nvarchar](50) NULL,
	[totalShortfallSurplusMyNeeds] [nvarchar](50) NULL,
	[lumpSumMyNeeds] [nvarchar](50) NULL,
	[existingSumMyNeeds] [nvarchar](50) NULL,
	[shortfallSumMyNeeds] [nvarchar](50) NULL,
	[monthlyIncomeDisabilityIncome] [nvarchar](50) NULL,
	[percentOfIncomeCoverageRequired] [nvarchar](50) NULL,
	[monthlyCoverageRequired] [nvarchar](50) NULL,
	[disabilityInsuranceMyNeeds] [nvarchar](50) NULL,
	[existingAssetsMyneedsDisability] [nvarchar](50) NULL,
	[shortfallSurplusMyNeeds] [nvarchar](50) NULL,
	[monthlyAmountMyNeeds] [nvarchar](50) NULL,
	[existingMyNeeds] [nvarchar](50) NULL,
	[shortfallMyNeeds] [nvarchar](50) NULL,
	[typeOfHospitalCoverage] [nvarchar](50) NULL,
	[anyExistingPlans] [bit] NULL,
	[typeOfRoomCoverage] [int] NULL,
	[coverageOldageYesNo] [bit] NULL,
	[epOldageYesNo] [bit] NULL,
	[coverageIncomeYesNo] [bit] NULL,
	[epIncomeYesNo] [bit] NULL,
	[coverageOutpatientYesNo] [bit] NULL,
	[epOutpatientYesNo] [bit] NULL,
	[coverageDentalYesNo] [bit] NULL,
	[epDentalYesNo] [bit] NULL,
	[coveragePersonalYesNo] [bit] NULL,
	[epPersonalYesNo] [bit] NULL,
	[detailsOfExistingPlans] [nvarchar](4000) NULL,
	[replacementIncomePercentage] [nvarchar](50) NULL,
	[replacementIncomeRequired] [nvarchar](50) NULL,
	[yearsOfSupportRequired] [nvarchar](50) NULL,
	[inflatedAdjustedReturns] [nvarchar](50) NULL,
	[replacementAmountRequired] [nvarchar](50) NULL,
	[totalRequired] [nvarchar](50) NULL,
	[txtExistingAssetsFamilyneeds] [nvarchar](50) NULL,
	[disabilityProtectionReplacementIncomeRequiredPercentage] [nvarchar](50) NULL,
	[disabilityProtectionReplacementIncomeRequired] [nvarchar](50) NULL,
	[disabilityYearsOfSupport] [nvarchar](50) NULL,
	[inflationAdjustedReturns] [nvarchar](50) NULL,
	[disabilityReplacementAmountRequired] [nvarchar](50) NULL,
	[disabilityInsurance] [nvarchar](50) NULL,
	[existingPlansDetail] [nvarchar](2000) NULL,
 CONSTRAINT [PK_protectionGoalsMyNeeds] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[myNeeds]') AND name = N'IX_myNeeds')
CREATE NONCLUSTERED INDEX [IX_myNeeds] ON [dbo].[myNeeds] 
(
	[caseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[liabilityOthers]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[liabilityOthers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[liabilityOthers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[assetLiabilityId] [int] NOT NULL,
	[caseId] [nvarchar](50) NULL,
	[liabilityDesc] [nvarchar](50) NULL,
	[cash] [nvarchar](50) NULL,
	[date] [date] NULL,
 CONSTRAINT [PK_liabilityOthers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[liabilityOthers]') AND name = N'IX_liabilityOthers')
CREATE NONCLUSTERED INDEX [IX_liabilityOthers] ON [dbo].[liabilityOthers] 
(
	[caseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[investedAssetOthers]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[investedAssetOthers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[investedAssetOthers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[assetLiabilityId] [int] NOT NULL,
	[caseId] [nvarchar](50) NULL,
	[assetDesc] [nvarchar](50) NULL,
	[cash] [nvarchar](50) NULL,
	[cpf] [nvarchar](50) NULL,
	[date] [date] NULL,
 CONSTRAINT [PK_investedAssetOthers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[investedAssetOthers]') AND name = N'IX_investedAssetOthers')
CREATE NONCLUSTERED INDEX [IX_investedAssetOthers] ON [dbo].[investedAssetOthers] 
(
	[caseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[insuranceArrangementSaving]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[insuranceArrangementSaving]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[insuranceArrangementSaving](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[caseId] [varchar](50) NULL,
	[policyOwnerName] [nvarchar](100) NULL,
	[company] [nvarchar](50) NULL,
	[contribution] [nvarchar](50) NULL,
	[term] [nvarchar](50) NULL,
	[fundValue] [nvarchar](50) NULL,
	[natureOfPlan] [nvarchar](150) NULL,
	[incomeExpenseId] [int] NULL,
 CONSTRAINT [PK_insuranceArrangementSaving] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[insuranceArrangementSaving]') AND name = N'IX_insuranceArrangementSaving')
CREATE NONCLUSTERED INDEX [IX_insuranceArrangementSaving] ON [dbo].[insuranceArrangementSaving] 
(
	[caseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[insuranceArrangementRetirement]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[insuranceArrangementRetirement]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[insuranceArrangementRetirement](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[caseId] [varchar](50) NULL,
	[policyOwnerName] [nvarchar](100) NULL,
	[company] [nvarchar](50) NULL,
	[contribution] [nvarchar](50) NULL,
	[maturityDate] [varchar](50) NULL,
	[projectedLumpSumMaturity] [nvarchar](50) NULL,
	[projectedIncomeMaturity] [nvarchar](50) NULL,
	[incomeExpenseId] [int] NULL,
 CONSTRAINT [PK_insuranceArrangementRetirement] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[insuranceArrangementRetirement]') AND name = N'IX_insuranceArrangementRetirement')
CREATE NONCLUSTERED INDEX [IX_insuranceArrangementRetirement] ON [dbo].[insuranceArrangementRetirement] 
(
	[caseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[insuranceArrangementEducation]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[insuranceArrangementEducation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[insuranceArrangementEducation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[caseId] [varchar](50) NULL,
	[policyOwnerName] [nvarchar](100) NULL,
	[company] [nvarchar](50) NULL,
	[contribution] [nvarchar](50) NULL,
	[maturityDate] [varchar](50) NULL,
	[projectedLumpSumMaturity] [nvarchar](50) NULL,
	[projectedIncomeMaturity] [nvarchar](50) NULL,
	[incomeExpenseId] [int] NULL,
 CONSTRAINT [PK_insuranceArrangementEducation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[insuranceArrangementEducation]') AND name = N'IX_insuranceArrangementEducation')
CREATE NONCLUSTERED INDEX [IX_insuranceArrangementEducation] ON [dbo].[insuranceArrangementEducation] 
(
	[caseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[incomeExpenseOthers]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[incomeExpenseOthers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[incomeExpenseOthers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[incomeExpenseId] [int] NOT NULL,
	[sumAssured] [nvarchar](50) NULL,
	[maturedValue] [nvarchar](50) NULL,
	[expiry] [nvarchar](50) NULL,
	[premium] [nvarchar](50) NULL,
	[remarks] [nvarchar](150) NULL,
	[name] [nvarchar](150) NULL,
 CONSTRAINT [PK_incomeExpenseOthers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[incomeExpense]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[incomeExpense]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[incomeExpense](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[emergencyFundsNeeded] [nvarchar](50) NULL,
	[shortTermGoals] [nvarchar](50) NULL,
	[extraDetails] [nvarchar](500) NULL,
	[netMonthlyIncomeAfterCpf] [nvarchar](50) NULL,
	[netMonthlyExpenses] [nvarchar](50) NULL,
	[monthlySavings] [nvarchar](50) NULL,
	[lifeInsuranceSA] [nvarchar](50) NULL,
	[lifeInsuranceMV] [nvarchar](50) NULL,
	[expiry1] [nvarchar](50) NULL,
	[lifeInsurancePremium] [nvarchar](50) NULL,
	[lifeInsuranceRemarks] [nvarchar](150) NULL,
	[tpdcSA] [nvarchar](50) NULL,
	[tpdcMV] [nvarchar](50) NULL,
	[expiry2] [nvarchar](50) NULL,
	[tpdcPremium] [nvarchar](50) NULL,
	[tpdcRemarks] [nvarchar](150) NULL,
	[criticalIllnessSA] [nvarchar](50) NULL,
	[criticalIllnessMV] [nvarchar](50) NULL,
	[expiry3] [nvarchar](50) NULL,
	[criticalIllnessPremium] [nvarchar](50) NULL,
	[criticalIllnessRemarks] [nvarchar](150) NULL,
	[disabilityIncomeSA] [nvarchar](50) NULL,
	[disabilityIncomeMV] [nvarchar](50) NULL,
	[expiry4] [nvarchar](50) NULL,
	[disabilityIncomePremium] [nvarchar](50) NULL,
	[disabilityIncomeRemarks] [nvarchar](150) NULL,
	[mortgageSA] [nvarchar](50) NULL,
	[mortgageMV] [nvarchar](50) NULL,
	[expiry5] [nvarchar](50) NULL,
	[mortgagePremium] [nvarchar](50) NULL,
	[mortgageRemarks] [nvarchar](150) NULL,
	[others1A] [nvarchar](50) NULL,
	[others1V] [nvarchar](50) NULL,
	[expiry6] [nvarchar](50) NULL,
	[others1Premium] [nvarchar](50) NULL,
	[others1Remarks] [nvarchar](150) NULL,
	[others2] [nvarchar](50) NULL,
	[others2A] [nvarchar](50) NULL,
	[others2V] [nvarchar](50) NULL,
	[expiry7] [nvarchar](50) NULL,
	[others2Premium] [nvarchar](50) NULL,
	[others2Remarks] [nvarchar](150) NULL,
	[caseId] [varchar](50) NULL,
	[DeathTermInsuranceSA] [varchar](50) NULL,
	[DeathWholeLifeInsuranceSA] [varchar](50) NULL,
	[DeathTermInsuranceTerm] [varchar](50) NULL,
	[DeathWholeLifeInsuranceTerm] [varchar](50) NULL,
	[DeathTermInsurancePremium] [varchar](50) NULL,
	[DeathWholeLifeInsurancePremium] [varchar](50) NULL,
	[otherSourcesOfIncome] [nvarchar](50) NULL,
 CONSTRAINT [PK_incomeExpense] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[incomeExpense]') AND name = N'IX_incomeExpense')
CREATE NONCLUSTERED INDEX [IX_incomeExpense] ON [dbo].[incomeExpense] 
(
	[caseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gapSummaryNeedTypes]    Script Date: 09/26/2012 00:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gapSummaryNeedTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[gapSummaryNeedTypes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[gapSummaryType] [nvarchar](200) NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[gapSummary]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gapSummary]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[gapSummary](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[caseId] [nvarchar](50) NOT NULL,
	[needId] [int] NOT NULL,
	[needTypeId] [int] NOT NULL,
	[myPriorities] [nvarchar](500) NULL,
 CONSTRAINT [PK_gapSummary] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[fund_risk_profile_mapping]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fund_risk_profile_mapping]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fund_risk_profile_mapping](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[fundid] [smallint] NULL,
	[riskprofileid] [smallint] NULL,
	[allocation_type_id] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[fund_risk_profile_mapping] ON
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (1, 1, 2, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (2, 1, 3, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (3, 1, 4, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (4, 1, 5, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (5, 1, 1, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (10, 4, 3, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (11, 4, 4, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (12, 4, 5, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (13, 4, 1, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (14, 4, 2, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (16, 5, 3, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (17, 5, 4, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (18, 5, 5, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (19, 6, 3, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (20, 6, 4, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (21, 6, 5, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (22, 7, 1, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (23, 7, 2, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (24, 7, 3, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (25, 7, 4, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (26, 7, 5, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (28, 8, 2, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (29, 8, 3, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (30, 8, 4, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (31, 8, 5, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (33, 9, 2, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (34, 9, 3, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (35, 9, 4, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (36, 9, 5, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (37, 10, 5, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (38, 11, 1, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (39, 11, 2, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (40, 11, 3, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (41, 11, 4, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (42, 11, 5, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (48, 13, 5, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (49, 14, 5, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (50, 15, 5, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (51, 16, 5, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (52, 17, 4, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (53, 17, 5, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (54, 18, 4, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (55, 18, 5, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (56, 19, 5, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (57, 20, 4, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (58, 20, 5, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (59, 21, 5, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (60, 22, 1, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (61, 22, 2, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (62, 22, 3, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (63, 22, 4, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (64, 22, 5, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (70, 24, 1, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (71, 24, 2, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (72, 24, 3, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (73, 24, 4, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (74, 24, 5, 4)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (75, 25, 4, 5)
INSERT [dbo].[fund_risk_profile_mapping] ([id], [fundid], [riskprofileid], [allocation_type_id]) VALUES (76, 25, 5, 5)
SET IDENTITY_INSERT [dbo].[fund_risk_profile_mapping] OFF
/****** Object:  Table [dbo].[fund_lkp]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fund_lkp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fund_lkp](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[fullName] [nvarchar](90) NULL,
	[middleName] [nvarchar](90) NULL,
	[asset_id] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[fund_lkp] ON
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (1, N'Schroder ISF Asian Bond Absolute Return', N'Schroder ISF Asian Bond Absolute Return', 6)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (4, N'Pimco Funds - Emerging Markets Bond Fund', N'Pimco Funds - Emerging Markets Bond Fund', 3)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (5, N'JPMorgan Funds - Emerging Markets Equity Fund', N'JPMorgan Funds - Emerging Markets Equity Fund', 7)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (6, N'Templeton Emerging Markets Fund', N'Templeton Emerging Markets Fund', 7)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (7, N'Pimco Funds - Total Return Bond Fund', N'Pimco Funds - Total Return Bond Fund', 2)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (8, N'Franklin Global Growth Fund', N'Franklin Global Growth Fund', 5)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (9, N'JPMorgan Funds - Global Dynamic', N'JPMorgan Funds - Global Dynamic', 5)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (10, N'Fidelity Funds - Global Real Asset Securities Fund', N'Fidelity Funds - Global Real Asset Securities Fund', 6)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (11, N'Fullerton Singapore Dollar Cash Fund', N'Fullerton Singapore Dollar Cash Fund', 6)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (13, N'Templeton Asian Smaller Companies Fund', N'Templeton Asian Smaller Companies Fund', 6)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (14, N'JPMorgan Funds - Latin America Equity Fund', N'JPMorgan Funds - Latin America Equity Fund', 6)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (15, N'BlackRock Global Funds - World Energy Fund', N'BlackRock Global Funds - World Energy Fund', 6)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (16, N'BlackRock Global Funds - World Gold Fund', N'BlackRock Global Funds - World Gold Fund', 6)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (17, N'Franklin Biotechnology Discovery Fund', N'Franklin Biotechnology Discovery Fund', 6)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (18, N'United Global Healthcare Fund', N'United Global Healthcare Fund', 6)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (19, N'JPMorgan Funds - Global Natural Resources Fund', N'JPMorgan Funds - Global Natural Resources Fund', 6)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (20, N'JPMorgan Funds - JF Asean Equity Fund', N'JPMorgan Funds - JF Asean Equity Fund', 6)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (21, N'Henderson Horizon Fund - China Fund', N'Henderson Horizon Fund - China Fund', 6)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (22, N'LionGlobal Singapore Fixed Income Investment Fund', N'LionGlobal Singapore Fixed Income Investment Fund', 1)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (24, N'Legg Mason Western Asset Singapore Bond Fund', N'Legg Mason Western Asset Singapore Bond Fund', 1)
INSERT [dbo].[fund_lkp] ([id], [fullName], [middleName], [asset_id]) VALUES (25, N'JPMorgan Funds - JF Singapore Fund', N'JPMorgan Funds - JF Singapore Fund', 4)
SET IDENTITY_INSERT [dbo].[fund_lkp] OFF
/****** Object:  Table [dbo].[familyNeedsAssets]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[familyNeedsAssets]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[familyNeedsAssets](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[familyNeedId] [int] NOT NULL,
	[asset] [nvarchar](50) NULL,
	[presentValue] [nvarchar](50) NULL,
 CONSTRAINT [PK_protectionGoalsFmlyNeedsAssets] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[familyNeeds]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[familyNeeds]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[familyNeeds](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[caseId] [nvarchar](50) NOT NULL,
	[replacementIncomeRequired] [nvarchar](50) NULL,
	[yearsOfSupportRequired] [nvarchar](50) NULL,
	[inflationAdjustedReturns] [nvarchar](50) NULL,
	[lumpSumRequired] [nvarchar](50) NULL,
	[otherLiabilities] [nvarchar](50) NULL,
	[emergencyFundsNeeded] [nvarchar](50) NULL,
	[finalExpenses] [nvarchar](50) NULL,
	[otherFundingNeeds] [nvarchar](50) NULL,
	[otherComments] [nvarchar](50) NULL,
	[totalRequired] [nvarchar](50) NULL,
	[existingLifeInsurance] [nvarchar](50) NULL,
	[existingAssetsFamilyneeds] [nvarchar](50) NULL,
	[totalShortfallSurplus] [nvarchar](50) NULL,
	[lumpSumRequiredChart] [nvarchar](50) NULL,
	[existingSumRequiredChart] [nvarchar](50) NULL,
	[shortfallSumRequiredChart] [nvarchar](50) NULL,
	[inflationAdjustedReturnsGraph] [nvarchar](50) NULL,
	[yearsOfSupportRequiredGraph] [nvarchar](50) NULL,
	[replacementIncomeChart] [nvarchar](50) NULL,
	[mortgageProtectionOutstanding] [nvarchar](50) NULL,
	[mortgageProtectionInsurances] [nvarchar](50) NULL,
	[mortgageProtectionTotal] [nvarchar](50) NULL,
	[mortgageLoan] [nvarchar](50) NULL,
	[mortgageInsurance] [nvarchar](50) NULL,
	[mortgageShortfall] [nvarchar](50) NULL,
	[replacementIncomePercentage] [nvarchar](50) NULL,
 CONSTRAINT [PK_protectionGoalsFamilyNeeds] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[familyNeeds]') AND name = N'IX_familyNeeds')
CREATE NONCLUSTERED INDEX [IX_familyNeeds] ON [dbo].[familyNeeds] 
(
	[caseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[familyMemberDetails]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[familyMemberDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[familyMemberDetails](
	[memberId] [int] IDENTITY(1,1) NOT NULL,
	[personalDetailId] [int] NOT NULL,
	[name] [nvarchar](max) NULL,
	[occupation] [nvarchar](50) NULL,
	[relationship] [nvarchar](50) NULL,
	[dob] [nvarchar](50) NULL,
	[yrstosupport] [int] NULL,
	[monthlyIncome] [nvarchar](50) NULL,
 CONSTRAINT [PK_familyMemberDetails] PRIMARY KEY CLUSTERED 
(
	[memberId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CkaAssessment]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CkaAssessment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CkaAssessment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[agreeCKA] [nvarchar](10) NULL,
	[disagreeCKA] [nvarchar](10) NULL,
	[financeRelatedKnowledgeOption1] [nvarchar](10) NULL,
	[financeRelatedKnowledgeOption2] [nvarchar](10) NULL,
	[investmentExperienceOption1] [nvarchar](10) NULL,
	[investmentExperienceOption2] [nvarchar](10) NULL,
	[workingExperienceOption1] [nvarchar](10) NULL,
	[workingExperienceOption2] [nvarchar](10) NULL,
	[educationalExperienceOption1] [nvarchar](10) NULL,
	[educationalExperienceOption2] [nvarchar](10) NULL,
	[csaOutcomeOption1] [nvarchar](10) NULL,
	[csaOutcomeOption2] [nvarchar](10) NULL,
	[caseId] [varchar](50) NULL,
 CONSTRAINT [PK_CkaAssessment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CkaAssessment]') AND name = N'IX_CkaAssessment')
CREATE NONCLUSTERED INDEX [IX_CkaAssessment] ON [dbo].[CkaAssessment] 
(
	[caseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[assumption]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[assumption]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[assumption](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](90) NULL,
	[desc] [nvarchar](90) NULL,
	[code] [nchar](10) NULL,
	[percentage] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[assumption] ON
INSERT [dbo].[assumption] ([id], [name], [desc], [code], [percentage]) VALUES (1, N'Inflation', N'Inflation', N'code01    ', 4)
INSERT [dbo].[assumption] ([id], [name], [desc], [code], [percentage]) VALUES (2, N'Investment', N'Investment', N'code02    ', 8)
INSERT [dbo].[assumption] ([id], [name], [desc], [code], [percentage]) VALUES (3, N'Education', N'Education', N'code03    ', 6)
INSERT [dbo].[assumption] ([id], [name], [desc], [code], [percentage]) VALUES (4, N'Inflation Return', N'Inflation Adjusted Return', N'code04    ', 1.94)
INSERT [dbo].[assumption] ([id], [name], [desc], [code], [percentage]) VALUES (5, N'Lowest Return', N'Lowest Return', N'code05    ', 2)
INSERT [dbo].[assumption] ([id], [name], [desc], [code], [percentage]) VALUES (6, N'Low Return', N'Low Return', N'code06    ', 4)
INSERT [dbo].[assumption] ([id], [name], [desc], [code], [percentage]) VALUES (7, N'High Return', N'High Return', N'code07    ', 6)
INSERT [dbo].[assumption] ([id], [name], [desc], [code], [percentage]) VALUES (8, N'Highest Return', N'Highest Return', N'code08    ', 8)
INSERT [dbo].[assumption] ([id], [name], [desc], [code], [percentage]) VALUES (9, N'Family Income Protection', N'Family Income Protection', N'code09    ', 70)
INSERT [dbo].[assumption] ([id], [name], [desc], [code], [percentage]) VALUES (10, N'Critical Illness Protection', N'Critical Illness Protection', N'code10    ', 100)
INSERT [dbo].[assumption] ([id], [name], [desc], [code], [percentage]) VALUES (11, N'Disability Protection', N'Disability Protection', N'code11    ', 75)
SET IDENTITY_INSERT [dbo].[assumption] OFF
/****** Object:  Table [dbo].[assets_lkp]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[assets_lkp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[assets_lkp](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[fullName] [nvarchar](90) NULL,
	[middleName] [nvarchar](90) NULL,
	[asset_type] [smallint] NULL,
	[colour] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[assets_lkp] ON
INSERT [dbo].[assets_lkp] ([id], [fullName], [middleName], [asset_type], [colour]) VALUES (1, N'Singapore Bond', N'Singapore Bond', 1, N'#F2F2F2')
INSERT [dbo].[assets_lkp] ([id], [fullName], [middleName], [asset_type], [colour]) VALUES (2, N'Global Bond', N'Global Bond', 1, N'#FABA9A')
INSERT [dbo].[assets_lkp] ([id], [fullName], [middleName], [asset_type], [colour]) VALUES (3, N'Emerging Market Bond', N'Emerging Market Bond', 1, N'#FAE6E5')
INSERT [dbo].[assets_lkp] ([id], [fullName], [middleName], [asset_type], [colour]) VALUES (4, N'Singapore Equity', N'Singapore Equity', 1, N'#FEF8B6')
INSERT [dbo].[assets_lkp] ([id], [fullName], [middleName], [asset_type], [colour]) VALUES (5, N'Global Equity', N'Global Equity', 1, N'#F0E68C')
INSERT [dbo].[assets_lkp] ([id], [fullName], [middleName], [asset_type], [colour]) VALUES (6, N'Non-Core Asset Classes', N'Non-Core Asset Classes', 2, N'#DAE4F6')
INSERT [dbo].[assets_lkp] ([id], [fullName], [middleName], [asset_type], [colour]) VALUES (7, N'Emerging Market Equity', N'Emerging Market Equity', 1, N'#F3F5F9')
INSERT [dbo].[assets_lkp] ([id], [fullName], [middleName], [asset_type], [colour]) VALUES (20, N'Expected Return (%)', N'Expected Return (%)', 3, NULL)
INSERT [dbo].[assets_lkp] ([id], [fullName], [middleName], [asset_type], [colour]) VALUES (21, N'Risk (%)', N'Risk (%)', 3, NULL)
INSERT [dbo].[assets_lkp] ([id], [fullName], [middleName], [asset_type], [colour]) VALUES (22, N'5th Percentile', N'5th Percentile', 3, NULL)
INSERT [dbo].[assets_lkp] ([id], [fullName], [middleName], [asset_type], [colour]) VALUES (23, N'95th Percentile', N'95th Percentile', 3, NULL)
INSERT [dbo].[assets_lkp] ([id], [fullName], [middleName], [asset_type], [colour]) VALUES (24, N'Bonds', N'Bonds', 3, NULL)
INSERT [dbo].[assets_lkp] ([id], [fullName], [middleName], [asset_type], [colour]) VALUES (25, N'Equity', N'Equity', 2, NULL)
SET IDENTITY_INSERT [dbo].[assets_lkp] OFF
/****** Object:  Table [dbo].[assetAndLiability]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[assetAndLiability]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[assetAndLiability](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[bankAcctCash] [nvarchar](50) NULL,
	[cpfoaBal] [nvarchar](50) NULL,
	[cpfsaBal] [nvarchar](50) NULL,
	[srsBal] [nvarchar](50) NULL,
	[stocksSharesCash] [nvarchar](50) NULL,
	[stocksSharesCpf] [nvarchar](50) NULL,
	[unitTrustsCash] [nvarchar](50) NULL,
	[unitTrustsCpf] [nvarchar](50) NULL,
	[ilpCash] [nvarchar](50) NULL,
	[ilpCpf] [nvarchar](50) NULL,
	[srsInvCash] [nvarchar](50) NULL,
	[invPropCash] [nvarchar](50) NULL,
	[invPropCpf] [nvarchar](50) NULL,
	[resPropCash] [nvarchar](50) NULL,
	[resPropCpf] [nvarchar](50) NULL,
	[homeMortgage] [nvarchar](50) NULL,
	[vehicleLoan] [nvarchar](50) NULL,
	[cashLoan] [nvarchar](50) NULL,
	[creditCard] [nvarchar](50) NULL,
	[netWorth] [nvarchar](50) NULL,
	[regularSumCash] [nvarchar](50) NULL,
	[lumpSumCash] [nvarchar](50) NULL,
	[regularSumCpf] [nvarchar](50) NULL,
	[lumpSumCpf] [nvarchar](50) NULL,
	[submissionDate] [date] NULL,
	[caseId] [varchar](50) NULL,
	[cpfMediSaveBalance] [nvarchar](50) NULL,
 CONSTRAINT [PK_assetAndLiability] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[assetAndLiability]') AND name = N'IX_assetAndLiability')
CREATE NONCLUSTERED INDEX [IX_assetAndLiability] ON [dbo].[assetAndLiability] 
(
	[caseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[asset_allocation_mapping]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[asset_allocation_mapping]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[asset_allocation_mapping](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[asset_id] [smallint] NULL,
	[risk_profile_id] [smallint] NULL,
	[allocation_type_id] [smallint] NULL,
	[percentage] [numeric](22, 8) NULL,
	[per] [decimal](18, 0) NULL,
	[percenta] [numeric](3, 2) NULL,
	[perc] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[asset_allocation_mapping] ON
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (1, 1, 1, 1, CAST(58.00000000 AS Numeric(22, 8)), CAST(58 AS Decimal(18, 0)), NULL, CAST(58 AS Decimal(18, 0)))
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (2, 1, 2, 1, CAST(46.00000000 AS Numeric(22, 8)), CAST(46 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (3, 1, 3, 1, CAST(28.00000000 AS Numeric(22, 8)), CAST(28 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (4, 1, 4, 1, CAST(18.00000000 AS Numeric(22, 8)), CAST(18 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (5, 1, 5, 1, CAST(7.00000000 AS Numeric(22, 8)), CAST(7 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (6, 1, 1, 6, CAST(58.00000000 AS Numeric(22, 8)), CAST(58 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (7, 1, 2, 6, CAST(46.00000000 AS Numeric(22, 8)), CAST(46 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (8, 1, 3, 6, CAST(28.00000000 AS Numeric(22, 8)), CAST(28 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (9, 1, 4, 6, CAST(18.00000000 AS Numeric(22, 8)), CAST(18 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (10, 2, 1, 1, CAST(24.00000000 AS Numeric(22, 8)), CAST(24 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (11, 2, 2, 1, CAST(20.00000000 AS Numeric(22, 8)), CAST(20 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (12, 2, 3, 1, CAST(17.00000000 AS Numeric(22, 8)), CAST(17 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (13, 2, 4, 1, CAST(11.00000000 AS Numeric(22, 8)), CAST(11 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (14, 2, 5, 1, CAST(4.00000000 AS Numeric(22, 8)), CAST(4 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (15, 2, 1, 6, CAST(24.00000000 AS Numeric(22, 8)), CAST(24 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (16, 2, 2, 6, CAST(20.00000000 AS Numeric(22, 8)), CAST(20 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (17, 2, 3, 6, CAST(17.00000000 AS Numeric(22, 8)), CAST(17 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (18, 2, 4, 6, CAST(11.00000000 AS Numeric(22, 8)), CAST(11 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (20, 3, 1, 1, CAST(0.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (21, 3, 2, 1, CAST(0.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (22, 3, 3, 1, CAST(11.00000000 AS Numeric(22, 8)), CAST(11 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (23, 3, 4, 1, CAST(7.00000000 AS Numeric(22, 8)), CAST(7 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (24, 3, 5, 1, CAST(3.00000000 AS Numeric(22, 8)), CAST(3 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (25, 3, 1, 6, CAST(0.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (26, 3, 2, 6, CAST(0.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (27, 3, 3, 6, CAST(11.00000000 AS Numeric(22, 8)), CAST(11 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (28, 3, 4, 6, CAST(7.00000000 AS Numeric(22, 8)), CAST(7 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (30, 4, 1, 1, CAST(4.00000000 AS Numeric(22, 8)), CAST(4 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (31, 4, 2, 1, CAST(9.00000000 AS Numeric(22, 8)), CAST(9 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (32, 4, 3, 1, CAST(12.00000000 AS Numeric(22, 8)), CAST(12 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (33, 4, 4, 1, CAST(18.00000000 AS Numeric(22, 8)), CAST(18 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (34, 4, 5, 1, CAST(24.00000000 AS Numeric(22, 8)), CAST(24 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (35, 4, 1, 6, CAST(4.00000000 AS Numeric(22, 8)), CAST(4 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (36, 4, 2, 6, CAST(9.00000000 AS Numeric(22, 8)), CAST(9 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (37, 4, 3, 6, CAST(12.00000000 AS Numeric(22, 8)), CAST(12 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (38, 4, 4, 6, CAST(18.00000000 AS Numeric(22, 8)), CAST(8 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (40, 5, 1, 1, CAST(9.00000000 AS Numeric(22, 8)), CAST(9 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (41, 5, 2, 1, CAST(15.00000000 AS Numeric(22, 8)), CAST(15 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (42, 5, 3, 1, CAST(19.00000000 AS Numeric(22, 8)), CAST(19 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (43, 5, 4, 1, CAST(28.00000000 AS Numeric(22, 8)), CAST(28 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (44, 5, 5, 1, CAST(37.00000000 AS Numeric(22, 8)), CAST(37 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (45, 5, 1, 6, CAST(9.00000000 AS Numeric(22, 8)), CAST(9 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (46, 5, 2, 6, CAST(15.00000000 AS Numeric(22, 8)), CAST(15 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (47, 5, 3, 6, CAST(19.00000000 AS Numeric(22, 8)), CAST(19 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (48, 5, 4, 6, CAST(28.00000000 AS Numeric(22, 8)), CAST(28 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (50, 6, 1, 6, CAST(5.00000000 AS Numeric(22, 8)), CAST(5 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (51, 6, 2, 6, CAST(10.00000000 AS Numeric(22, 8)), CAST(10 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (52, 6, 3, 6, CAST(13.00000000 AS Numeric(22, 8)), CAST(13 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (53, 6, 4, 6, CAST(18.00000000 AS Numeric(22, 8)), CAST(18 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (54, 6, 5, 6, CAST(22.00000000 AS Numeric(22, 8)), CAST(22 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (55, 6, 1, 2, CAST(0.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (56, 6, 2, 2, CAST(0.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (57, 6, 3, 2, CAST(0.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (58, 6, 4, 2, CAST(0.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (59, 6, 5, 2, CAST(3.00000000 AS Numeric(22, 8)), CAST(3 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (60, 7, 1, 1, CAST(5.00000000 AS Numeric(22, 8)), CAST(5 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (61, 7, 2, 1, CAST(10.00000000 AS Numeric(22, 8)), CAST(10 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (62, 7, 3, 1, CAST(13.00000000 AS Numeric(22, 8)), CAST(13 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (63, 7, 4, 1, CAST(18.00000000 AS Numeric(22, 8)), CAST(18 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (64, 7, 5, 1, CAST(25.00000000 AS Numeric(22, 8)), CAST(25 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (65, 7, 1, 6, CAST(0.00000000 AS Numeric(22, 8)), CAST(5 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (66, 7, 2, 6, CAST(0.00000000 AS Numeric(22, 8)), CAST(10 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (67, 7, 3, 6, CAST(0.00000000 AS Numeric(22, 8)), CAST(13 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (68, 7, 4, 6, CAST(0.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (70, 8, 1, 1, CAST(4.90000000 AS Numeric(22, 8)), CAST(5 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (71, 8, 2, 1, CAST(6.00000000 AS Numeric(22, 8)), CAST(6 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (72, 8, 3, 1, CAST(6.80000000 AS Numeric(22, 8)), CAST(7 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (73, 8, 4, 1, CAST(8.00000000 AS Numeric(22, 8)), CAST(8 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (74, 8, 5, 1, CAST(9.30000000 AS Numeric(22, 8)), CAST(9 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (75, 8, 1, 6, CAST(5.00000000 AS Numeric(22, 8)), CAST(5 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (76, 8, 2, 6, CAST(6.10000000 AS Numeric(22, 8)), CAST(6 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (77, 8, 3, 6, CAST(7.10000000 AS Numeric(22, 8)), CAST(7 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (78, 8, 4, 6, CAST(8.30000000 AS Numeric(22, 8)), CAST(8 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (79, 8, 5, 1, CAST(9.70000000 AS Numeric(22, 8)), CAST(10 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (80, 10, 1, 1, CAST(-2.90000000 AS Numeric(22, 8)), CAST(-3 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (81, 10, 2, 1, CAST(-5.80000000 AS Numeric(22, 8)), CAST(-6 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (82, 10, 3, 1, CAST(-8.90000000 AS Numeric(22, 8)), CAST(-9 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (83, 10, 4, 1, CAST(-12.90000000 AS Numeric(22, 8)), CAST(-13 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (84, 10, 5, 1, CAST(-17.70000000 AS Numeric(22, 8)), CAST(-18 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (85, 10, 1, 6, CAST(-3.20000000 AS Numeric(22, 8)), CAST(-3 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (86, 10, 2, 6, CAST(-6.50000000 AS Numeric(22, 8)), CAST(-7 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (87, 10, 3, 6, CAST(-10.00000000 AS Numeric(22, 8)), CAST(-10 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (88, 10, 4, 6, CAST(-14.40000000 AS Numeric(22, 8)), CAST(-14 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (89, 10, 5, 1, CAST(-19.50000000 AS Numeric(22, 8)), CAST(-20 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (90, 11, 1, 1, CAST(12.80000000 AS Numeric(22, 8)), CAST(13 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (91, 11, 2, 1, CAST(17.70000000 AS Numeric(22, 8)), CAST(18 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (92, 11, 3, 1, CAST(22.50000000 AS Numeric(22, 8)), CAST(23 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (93, 11, 4, 1, CAST(28.90000000 AS Numeric(22, 8)), CAST(29 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (94, 11, 5, 1, CAST(36.30000000 AS Numeric(22, 8)), CAST(36 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (95, 11, 1, 6, CAST(13.30000000 AS Numeric(22, 8)), CAST(13 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (96, 11, 2, 6, CAST(18.80000000 AS Numeric(22, 8)), CAST(19 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (97, 11, 3, 6, CAST(24.10000000 AS Numeric(22, 8)), CAST(24 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (98, 11, 4, 6, CAST(31.00000000 AS Numeric(22, 8)), CAST(31 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (99, 11, 5, 1, CAST(38.90000000 AS Numeric(22, 8)), CAST(39 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (100, 12, 1, 1, CAST(82.00000000 AS Numeric(22, 8)), CAST(82 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (101, 12, 2, 1, CAST(66.00000000 AS Numeric(22, 8)), CAST(66 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (102, 12, 3, 1, CAST(56.00000000 AS Numeric(22, 8)), CAST(56 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (103, 12, 4, 1, CAST(36.00000000 AS Numeric(22, 8)), CAST(36 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (104, 12, 5, 1, CAST(14.00000000 AS Numeric(22, 8)), CAST(14 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (105, 12, 1, 6, CAST(82.00000000 AS Numeric(22, 8)), CAST(82 AS Decimal(18, 0)), NULL, NULL)
GO
print 'Processed 100 total records'
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (106, 12, 2, 6, CAST(66.00000000 AS Numeric(22, 8)), CAST(66 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (107, 12, 3, 6, CAST(56.00000000 AS Numeric(22, 8)), CAST(56 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (108, 12, 4, 6, CAST(36.00000000 AS Numeric(22, 8)), CAST(36 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (110, 13, 1, 1, CAST(18.00000000 AS Numeric(22, 8)), CAST(18 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (111, 13, 2, 1, CAST(34.00000000 AS Numeric(22, 8)), CAST(34 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (112, 13, 3, 1, CAST(44.00000000 AS Numeric(22, 8)), CAST(44 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (113, 13, 4, 1, CAST(64.00000000 AS Numeric(22, 8)), CAST(64 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (114, 13, 5, 1, CAST(86.00000000 AS Numeric(22, 8)), CAST(86 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (115, 13, 1, 6, CAST(18.00000000 AS Numeric(22, 8)), CAST(18 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (116, 13, 2, 6, CAST(34.00000000 AS Numeric(22, 8)), CAST(34 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (117, 13, 3, 6, CAST(44.00000000 AS Numeric(22, 8)), CAST(44 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (118, 13, 4, 6, CAST(64.00000000 AS Numeric(22, 8)), CAST(64 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (120, 1, 5, 6, CAST(7.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (121, 2, 5, 6, CAST(4.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (122, 3, 5, 6, CAST(3.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (123, 4, 5, 6, CAST(24.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (124, 5, 5, 6, CAST(37.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
INSERT [dbo].[asset_allocation_mapping] ([id], [asset_id], [risk_profile_id], [allocation_type_id], [percentage], [per], [percenta], [perc]) VALUES (125, 7, 5, 6, CAST(3.00000000 AS Numeric(22, 8)), CAST(0 AS Decimal(18, 0)), NULL, NULL)
SET IDENTITY_INSERT [dbo].[asset_allocation_mapping] OFF
/****** Object:  Table [dbo].[allocation_type_lkp]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[allocation_type_lkp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[allocation_type_lkp](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](90) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[allocation_type_lkp] ON
INSERT [dbo].[allocation_type_lkp] ([id], [description]) VALUES (1, N'Core Allocation')
INSERT [dbo].[allocation_type_lkp] ([id], [description]) VALUES (2, N'Non Core Allocation')
INSERT [dbo].[allocation_type_lkp] ([id], [description]) VALUES (3, N'Others')
INSERT [dbo].[allocation_type_lkp] ([id], [description]) VALUES (4, N'Primary')
INSERT [dbo].[allocation_type_lkp] ([id], [description]) VALUES (5, N'Secondary')
SET IDENTITY_INSERT [dbo].[allocation_type_lkp] OFF
/****** Object:  Table [dbo].[activitystatus]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[activitystatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[activitystatus](
	[caseid] [nvarchar](50) NOT NULL,
	[activity] [nvarchar](25) NOT NULL,
	[status] [nvarchar](25) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_activitystatus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[activitystatus]') AND name = N'IX_activitystatus')
CREATE NONCLUSTERED INDEX [IX_activitystatus] ON [dbo].[activitystatus] 
(
	[caseid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[activity]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[activity]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[activity](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[activity] [nvarchar](25) NULL,
 CONSTRAINT [PK_activity] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[activity] ON
INSERT [dbo].[activity] ([id], [activity]) VALUES (1, N'personaldetail')
INSERT [dbo].[activity] ([id], [activity]) VALUES (2, N'prioritydetail')
INSERT [dbo].[activity] ([id], [activity]) VALUES (3, N'assetliability')
INSERT [dbo].[activity] ([id], [activity]) VALUES (4, N'incomeexpense')
INSERT [dbo].[activity] ([id], [activity]) VALUES (5, N'protectiongoalfamily')
INSERT [dbo].[activity] ([id], [activity]) VALUES (6, N'savinggoal')
INSERT [dbo].[activity] ([id], [activity]) VALUES (7, N'retirementgoal')
INSERT [dbo].[activity] ([id], [activity]) VALUES (8, N'educationgoal')
INSERT [dbo].[activity] ([id], [activity]) VALUES (9, N'riskprofile')
INSERT [dbo].[activity] ([id], [activity]) VALUES (10, N'cka')
INSERT [dbo].[activity] ([id], [activity]) VALUES (11, N'portfoliobuilder')
INSERT [dbo].[activity] ([id], [activity]) VALUES (12, N'gapanalysis')
INSERT [dbo].[activity] ([id], [activity]) VALUES (13, N'myzurichadviser')
INSERT [dbo].[activity] ([id], [activity]) VALUES (14, N'protectiongoalmyneeds')
SET IDENTITY_INSERT [dbo].[activity] OFF
/****** Object:  Table [dbo].[countrycostofeducation]    Script Date: 09/26/2012 00:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[countrycostofeducation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[countrycostofeducation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[country] [nvarchar](50) NOT NULL,
	[costofeducation] [nvarchar](50) NULL,
 CONSTRAINT [PK_countrycostofeducation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[countrycostofeducation] ON
INSERT [dbo].[countrycostofeducation] ([id], [country], [costofeducation]) VALUES (1, N'Australia', N'266240')
INSERT [dbo].[countrycostofeducation] ([id], [country], [costofeducation]) VALUES (2, N'Singapore', N'63560')
INSERT [dbo].[countrycostofeducation] ([id], [country], [costofeducation]) VALUES (3, N'United Kingdom', N'281570')
INSERT [dbo].[countrycostofeducation] ([id], [country], [costofeducation]) VALUES (4, N'United States', N'264360')
INSERT [dbo].[countrycostofeducation] ([id], [country], [costofeducation]) VALUES (5, N'Others', N'')
SET IDENTITY_INSERT [dbo].[countrycostofeducation] OFF
/****** Object:  UserDefinedFunction [dbo].[ConvertEmptyToZero]    Script Date: 09/26/2012 00:52:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConvertEmptyToZero]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ConvertEmptyToZero](@val nvarchar(100))
RETURNS nvarchar(100)
AS 
BEGIN
    DECLARE @ret nvarchar(100);
    IF (RTRIM(LTRIM(@val)) = '''')     
		SET @ret = ''0''	
	ELSE	
		SET @ret = isnull(@val, 0)
    
    RETURN @ret
END;' 
END
GO
/****** Object:  Table [dbo].[clonemappingids]    Script Date: 09/26/2012 00:52:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[clonemappingids]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[clonemappingids](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[clonedfrom] [nvarchar](50) NULL,
	[newid] [nvarchar](50) NULL,
 CONSTRAINT [PK_clonemappingids] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[exceptionlog]    Script Date: 09/26/2012 00:52:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[exceptionlog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[exceptionlog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[message] [nvarchar](2000) NULL,
	[source] [nvarchar](2000) NULL,
	[stacktrace] [nvarchar](4000) NULL,
	[targetsitename] [nvarchar](2000) NULL,
 CONSTRAINT [PK_exceptionlog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[educationgoals]    Script Date: 09/26/2012 00:52:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[educationgoals]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[educationgoals](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[caseid] [nvarchar](50) NOT NULL,
	[nameofchild] [nvarchar](50) NULL,
	[currentage] [nvarchar](5) NULL,
	[agefundsneeded] [nvarchar](5) NULL,
	[noofyrstosave] [nvarchar](5) NULL,
	[countryofstudyid] [int] NULL,
	[maturityvalue] [nvarchar](50) NULL,
	[total] [nvarchar](50) NULL,
	[deleted] [bit] NULL,
	[existingassetstotal] [nvarchar](50) NULL,
	[futurecost] [nvarchar](50) NULL,
	[presentcost] [nvarchar](50) NULL,
	[inflationrate] [nvarchar](50) NULL,
 CONSTRAINT [PK_educationgoals] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[educationgoals]') AND name = N'IX_educationgoals')
CREATE NONCLUSTERED INDEX [IX_educationgoals] ON [dbo].[educationgoals] 
(
	[caseid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeletePortfolioBuilderForCP]    Script Date: 09/26/2012 00:52:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DeletePortfolioBuilderForCP]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_DeletePortfolioBuilderForCP]  
@CaseID nvarchar(50)
AS
BEGIN
	IF NOT EXISTS (SELECT riskProfileValue from RiskProfileAnalysis a, portFolioBuilderMaster b
			   WHERE a.caseId = @CaseID
			   AND b.caseId = @CaseID
			   AND isnull(a.riskProfileValue, 0) = isnull(b.riskProfileId, 0))  
	BEGIN  
		DELETE FROM portFolioBuilderDetail   
		WHERE portFolioBuilderId in (SELECT DISTINCT Id FROM portFolioBuilderMaster   
		WHERE caseId = @CaseId)  

		DELETE FROM portFolioBuilderMaster  
		WHERE caseId = @CaseID  
	END     
END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGapSummary]    Script Date: 09/26/2012 00:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DeleteGapSummary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_DeleteGapSummary]  
@CaseID nvarchar(50)
AS
BEGIN
	IF EXISTS (SELECT CASEID FROM gapSummary WHERE caseId = @CaseID)  
	BEGIN  
		DELETE FROM gapSummary   
		WHERE caseId = @CaseId    
	END   
END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePortFolioMaster]    Script Date: 09/26/2012 00:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_UpdatePortFolioMaster]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_UpdatePortFolioMaster]
@CaseId nvarchar(50) 
AS
BEGIN
	 DECLARE @TOTALAMT INT
	 IF EXISTS(SELECT amount FROM portFolioBuilderDetail
	 WHERE portFolioBuilderId in (SELECT id FROM portFolioBuilderMaster WHERE caseId = @CaseId))
	 BEGIN 
		SELECT @TOTALAMT = SUM(amount) FROM portFolioBuilderDetail
		WHERE portFolioBuilderId in (SELECT id FROM portFolioBuilderMaster WHERE caseId = @CaseId) 
	 END 
	 ELSE
		SET @TOTALAMT = 0

	UPDATE portFolioBuilderMaster
	SET premiumTotalAmount = @TOTALAMT
	WHERE caseId = @CaseId
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SavePortFolioMaster]    Script Date: 09/26/2012 00:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SavePortFolioMaster]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_SavePortFolioMaster]  
@CaseID nvarchar(50),  
@RiskProfileId int,  
@AgreeRiskProfile int,
@NewRiskProfile int,
@FollowAssetAllocationOnRiskProfileYesNo int,  
@AssetAllocationOnRiskProfileYesNo int,  
@IncludeNonCoreFundsYesNo int,  
@PremiumSelect int,  
@PremiumAmount decimal(25,5),
@PaymentMode int,
@PremiumPercent decimal(10,5),  
@TotalPremiumAmount decimal(25,5),  
@PortFolioBuilderId int OUTPUT  
AS  
BEGIN  
   
 IF EXISTS (SELECT CASEID FROM portFolioBuilderMaster WHERE caseId = @CaseID)  
 BEGIN  
  DELETE FROM portFolioBuilderDetail   
  WHERE portFolioBuilderId in (SELECT DISTINCT Id FROM portFolioBuilderMaster   
  WHERE caseId = @CaseId)  
   
  DELETE FROM portFolioBuilderMaster  
  WHERE caseId = @CaseID  
 END   
   
 INSERT INTO portFolioBuilderMaster (caseId, 
									 riskProfileId, 
									 followAssetAllocationOnRiskProfileYesNo, 
									 agreeWithRiskProfile, 
									 preferredRiskProfile,  
									 assetAllocationOnRiskProfileYesNo, 
									 includeNonCoreFundsYesNo, 
									 premiumSelect, 
									 premiumAmount, 
									 paymentMode, 
									 premiumPercent, 
									 premiumTotalAmount)  
							VALUES (@CaseID, 
							@RiskProfileId, 
							@FollowAssetAllocationOnRiskProfileYesNo, 
							@AgreeRiskProfile,
							@NewRiskProfile,
							@AssetAllocationOnRiskProfileYesNo,  
							@IncludeNonCoreFundsYesNo, 
							@PremiumSelect, 
							@PremiumAmount,
							@PaymentMode,
							@PremiumPercent,
							@TotalPremiumAmount)  
    
 SELECT @PortFolioBuilderId = SCOPE_IDENTITY()  
  
 SELECT @PortFolioBuilderId AS Id  
  
 RETURN  
END 
' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SavePortFolioDetail]    Script Date: 09/26/2012 00:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SavePortFolioDetail]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_SavePortFolioDetail]
@PortFolioBuilderId int,
@AssetClassId int,
@FundId int, 
@AllocationPercentage decimal(10,5),
@Amount decimal(25, 5)
AS
BEGIN
	DECLARE @PREMIUM INT
 
	IF EXISTS(SELECT premiumAmount FROM portFolioBuilderMaster 
	WHERE id = @PortFolioBuilderId) 
	BEGIN
		SELECT @PREMIUM = premiumAmount FROM portFolioBuilderMaster 
		WHERE id = @PortFolioBuilderId
	END
	ELSE
		SET @PREMIUM = 0
	
	INSERT INTO portFolioBuilderDetail (portFolioBuilderId, assetClassId, fundId, allocationPercentage, amount)
	VALUES (@PortFolioBuilderId, @AssetClassId, @FundId, @AllocationPercentage, (@PREMIUM * @AllocationPercentage)/100)
END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveGapSummary]    Script Date: 09/26/2012 00:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SaveGapSummary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create PROCEDURE [dbo].[sp_SaveGapSummary]  
@CaseID nvarchar(50),  
@NeedId int,  
@NeedTypeId int,  
@myPriorities nvarchar(500)
AS  
BEGIN

 INSERT INTO gapSummary (caseId, needId, needTypeId, myPriorities)
 VALUES (@CaseId, @NeedId, @NeedTypeId, @myPriorities)
   
END  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getPortFolioMaster]    Script Date: 09/26/2012 00:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_getPortFolioMaster]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_getPortFolioMaster]  
@CaseId nvarchar(50)  
AS  
BEGIN  

 DECLARE @TOTALPERCENT INT
 IF EXISTS(SELECT allocationPercentage FROM portFolioBuilderDetail
 WHERE portFolioBuilderId in (SELECT id FROM portFolioBuilderMaster WHERE caseId = @CaseId))
 BEGIN 
	SELECT @TOTALPERCENT = SUM(allocationPercentage) FROM portFolioBuilderDetail
	WHERE portFolioBuilderId in (SELECT id FROM portFolioBuilderMaster WHERE caseId = @CaseId) 
 END 
 ELSE
	SET @TOTALPERCENT = 0
 
 SELECT pfm.riskProfileId, 
 rpl.fullName as riskProfileName, 
 pfm.followAssetAllocationOnRiskProfileYesNo,  
 pfm.assetAllocationOnRiskProfileYesNo, 
 isnull(pfm.agreeWithRiskProfile, 0) as agreeWithRiskProfile, 
 isnull(pfm.preferredRiskPRofile, -1) as preferredRiskPRofile, 
 prl.fullName as preferredRiskProfileName,
 pfm.includeNonCoreFundsYesNo, 
 isnull(pfm.premiumSelect, 0) as premiumSelect,   
 convert(integer, isnull(pfm.premiumAmount, 0)) as premiumAmount, 
 isnull(pfm.paymentMode, -1) as paymentMode,
 @TOTALPERCENT as premiumPercent,
 convert(integer, isnull(pfm.premiumTotalAmount, 0)) as premiumTotalAmount
 FROM portFolioBuilderMaster pfm  
 INNER JOIN risk_profile_lkp rpl on rpl.id = pfm.riskProfileId   
 LEFT OUTER JOIN risk_profile_lkp prl on prl.id = pfm.preferredRiskProfile 
 WHERE caseId = @CaseId  
  
END  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getPortFolioDetail_With_Master]    Script Date: 09/26/2012 00:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_getPortFolioDetail_With_Master]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create PROCEDURE [dbo].[sp_getPortFolioDetail_With_Master]
@CaseId nvarchar(50)
AS
BEGIN	
	SELECT flkp.fullName as Fund,       
	pfd.allocationPercentage as FundAllocationPercentage, 
	(pfb.premiumAmount * allocationPercentage)/100 as FundAllocationAmount,
	pfb.premiumAmount as PremiumAmount, '''' PremiumFrequency
	FROM portFolioBuilderDetail pfd
	INNER JOIN fund_lkp flkp ON flkp.id = pfd.fundId
	INNER JOIN portFolioBuilderMaster pfb ON pfb.id = pfd.portFolioBuilderId
	WHERE pfb.caseId = @CaseId
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getPortFolioDetail]    Script Date: 09/26/2012 00:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_getPortFolioDetail]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_getPortFolioDetail]    
@CaseId nvarchar(50)    
AS    
BEGIN    
 SELECT pfd.portFolioBuilderId, pfd.assetClassId as assetId, astlkp.fullName as assetName,     
 pfd.fundId, flkp.fullName as fundName,     
 pfd.allocationPercentage, convert(integer, pfd.amount) as amount,
 ''0'' isPrimary,    
 ''0'' isSecondary    
 FROM portFolioBuilderDetail pfd    
 INNER JOIN assets_lkp astlkp ON astlkp.id = pfd.assetClassId    
 INNER JOIN fund_lkp flkp ON flkp.id = pfd.fundId     
 WHERE portFolioBuilderId in (SELECT DISTINCT Id FROM portFolioBuilderMaster     
 WHERE caseId = @CaseId)    
END   

' 
END
GO
/****** Object:  Table [dbo].[existingassetsg]    Script Date: 09/26/2012 00:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[existingassetsg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[existingassetsg](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[asset] [nvarchar](50) NULL,
	[presentvalue] [nvarchar](50) NULL,
	[percentpa] [nvarchar](50) NULL,
	[savinggoalsid] [int] NOT NULL,
 CONSTRAINT [PK_existingassetsg] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[existingassetrg]    Script Date: 09/26/2012 00:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[existingassetrg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[existingassetrg](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[asset] [nvarchar](50) NULL,
	[presentvalue] [nvarchar](50) NULL,
	[percentpa] [nvarchar](50) NULL,
	[retirementgoalsid] [int] NOT NULL,
 CONSTRAINT [PK_existingassetrg] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[existingasseteg]    Script Date: 09/26/2012 00:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[existingasseteg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[existingasseteg](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[asset] [nvarchar](50) NULL,
	[presentvalue] [nvarchar](50) NULL,
	[percentpa] [nvarchar](50) NULL,
	[educationgoalsid] [int] NOT NULL,
 CONSTRAINT [PK_existingasseteg] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getGapSummary]    Script Date: 09/26/2012 00:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_getGapSummary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_getGapSummary]    
@CaseId nvarchar(50)
AS
BEGIN
 
DECLARE @FIP AS NVARCHAR(10)
DECLARE @MORTGAGEPTN AS NVARCHAR(10)
DECLARE @CRITICALILLNESS AS NVARCHAR(10)
DECLARE @DISABILITYPTN AS NVARCHAR(10)
DECLARE @SAVINGGOAL AS NVARCHAR(10)
DECLARE @CHILDEDUGOAL AS NVARCHAR(10)
DECLARE @RETIREMENTGOAL AS NVARCHAR(10)

IF EXISTS (SELECT ID FROM priorityDetails where caseid = @CaseId)
BEGIN
	SELECT @FIP = ISNULL(pd.protection3, ''''),
	@MORTGAGEPTN = ISNULL(pd.protection1, ''''),
	@CRITICALILLNESS = ISNULL(pd.protection2, ''''),
	@DISABILITYPTN = ISNULL(pd.protection4, ''''),
	@SAVINGGOAL = ISNULL(savings3, ''''),
	@CHILDEDUGOAL = ISNULL(pd.savings2, ''''),
	@RETIREMENTGOAL = ISNULL(pd.savings1, '''')
	FROM priorityDetails pd
	WHERE caseid = @CaseId
END
ELSE
BEGIN
	SET @FIP = ''''
	SET @MORTGAGEPTN = ''''
	SET @CRITICALILLNESS = ''''
	SET @DISABILITYPTN = ''''
	SET @SAVINGGOAL =  ''''
	SET @CHILDEDUGOAL =  ''''
	SET @RETIREMENTGOAL =  ''''
END

PRINT @FIP
PRINT @MORTGAGEPTN
PRINT @CRITICALILLNESS
PRINT @DISABILITYPTN
PRINT @SAVINGGOAL
PRINT @CHILDEDUGOAL
PRINT @RETIREMENTGOAL

DECLARE @GAPSUMMARYTABLE AS TABLE(
	Id INT,
	gapSummaryTypeId INT,
	Title NVARCHAR(50),
	Needs NVARCHAR(50),
	AmountRequired NVARCHAR(50),
	ExistingArrangements NVARCHAR(50),
	CurrentShortfall NVARCHAR(50),
	MyPriorities NVARCHAR(100)
)

--PROTECTION GOALS (FAMILY NEEDS)  
 INSERT INTO @GAPSUMMARYTABLE  
 SELECT   
 fn.id as Id,  
 1 AS gapSummaryTypeId,  
 ''PROTECTION'' AS Title,   
 ''Family Income Protection'' Needs,   
 CONVERT(VARCHAR(20), CONVERT(DECIMAL(25, 2), dbo.ConvertEmptyToZero(fn.totalRequired))) AS AmountRequired,
 CONVERT(VARCHAR(20), CONVERT(DECIMAL(25, 2), dbo.ConvertEmptyToZero(fn.existingLifeInsurance)) + SUM(convert(DECIMAL(25, 2), dbo.ConvertEmptyToZero(fnea.presentValue)))) AS ExistingArrangements, 
 CONVERT(DECIMAL(25, 2), dbo.ConvertEmptyToZero(fn.totalShortfallSurplus)) AS CurrentShortfall,   
 @FIP AS MyPriorities  
 FROM familyNeeds fn   
  LEFT OUTER JOIN familyNeedsAssets fnea ON fn.id = fnea.familyNeedId    
   WHERE fn.id = (SELECT MAX(id) FROM familyNeeds WHERE caseId = @CaseId)  
   GROUP BY fn.id, fn.totalRequired, fn.existingLifeInsurance, fn.totalShortfallSurplus

   
 --PROTECTION GOALS (MORTGAGE PROTECTION)  
 INSERT INTO @GAPSUMMARYTABLE  
 SELECT   
 fn.id as Id,  
 2 AS gapSummaryTypeId,  
 '''' AS Title,   
 ''Mortgage Protection'' Needs,   
 CONVERT(VARCHAR(20), CONVERT(DECIMAL(25, 2), dbo.ConvertEmptyToZero(fn.mortgageProtectionOutstanding))) AS AmountRequired,   
 CONVERT(VARCHAR(20), CONVERT(DECIMAL(25, 2), dbo.ConvertEmptyToZero(fn.mortgageProtectionInsurances))) AS ExistingArrangements,   
 CONVERT(DECIMAL(25, 2), dbo.ConvertEmptyToZero(fn.mortgageProtectionTotal)) AS CurrentShortfall,   
 @MORTGAGEPTN AS MyPriorities  
 FROM familyNeeds fn
  WHERE fn.id = (SELECT MAX(id) FROM familyNeeds WHERE caseId = @CaseId)
   
 --PROTECTION GOALS (CRITICAL ILLNESS)  
 INSERT INTO @GAPSUMMARYTABLE  
 SELECT   
 mn.id as Id,  
 3 AS gapSummaryTypeId,  
 '''' AS Title,   
 ''Critical Illness'' Needs,   
 CONVERT(VARCHAR(20), CONVERT(DECIMAL(25, 2), dbo.ConvertEmptyToZero(mn.totalRequired))) AS AmountRequired,   
 CONVERT(VARCHAR(20), CONVERT(DECIMAL(25, 2), dbo.ConvertEmptyToZero(mn.criticalIllnessInsurance)) + SUM(CONVERT(DECIMAL(25, 2), dbo.ConvertEmptyToZero(mnea.presentValue)))) AS ExistingArrangements,     
 CONVERT(DECIMAL(25, 2), dbo.ConvertEmptyToZero(mn.totalShortfallSurplusMyNeeds)) AS CurrentShortfall,   
 @CRITICALILLNESS AS MyPriorities  
 FROM myNeeds mn   
  LEFT OUTER JOIN myNeedsCriticalAssets mnea ON mn.id = mnea.myNeedId     
  WHERE mn.id = (SELECT MAX(id) FROM myNeeds WHERE caseId = @CaseId)  
  GROUP BY mn.id, mn.totalRequired, mn.criticalIllnessInsurance, mn.totalShortfallSurplusMyNeeds
   
 --PROTECTION GOALS (DISABILITY PROTECTION)  
 INSERT INTO @GAPSUMMARYTABLE  
 SELECT   
 mn.id as Id,  
 4 AS gapSummaryTypeId,  
 '''' AS Title,   
 ''Disability Protection'' Needs,   
 CONVERT(VARCHAR(20), CONVERT(DECIMAL(25, 2), dbo.ConvertEmptyToZero(mn.disabilityReplacementAmountRequired))) AS AmountRequired,   
 CONVERT(VARCHAR(20), CONVERT(DECIMAL(25, 2), dbo.ConvertEmptyToZero(mn.disabilityInsurance)) + SUM(CONVERT(DECIMAL(25, 2), dbo.ConvertEmptyToZero(mnda.presentValue))))  AS ExistingArrangements,   
 CONVERT(DECIMAL(25, 2), dbo.ConvertEmptyToZero(mn.shortfallSurplusMyNeeds)) AS CurrentShortfall,   
 @DISABILITYPTN AS MyPriorities  
 FROM myNeeds mn   
  LEFT OUTER JOIN myNeedsDisabilityAssets mnda ON mn.id = mnda.myNeedId    
  WHERE mn.id = (SELECT MAX(id) FROM myNeeds WHERE caseId = @CaseId)      
  GROUP BY mn.id, mn.disabilityReplacementAmountRequired, mn.disabilityInsurance, mn.shortfallSurplusMyNeeds
   
 --PROTECTION GOALS (HOSPITALIZATION)  
 INSERT INTO @GAPSUMMARYTABLE  
 SELECT   
 mn.id as Id,  
 5 AS gapSummaryTypeId,  
 '''' AS Title,   
 ''Hospitalization - Type of Hospital'' Needs,   
 CONVERT(VARCHAR(20), mn.typeOfHospitalCoverage) AS AmountRequired,   
 CASE   
  WHEN mn.anyExistingPlans = 1 THEN ''YES''  
  ELSE  
  ''NO''  
 END AS ExistingArrangements,   
 '''' AS CurrentShortfall,   
 '''' AS MyPriorities  
 FROM myNeeds mn 
  WHERE mn.id = (select MAX(id) from myNeeds where caseId = @CaseId)      
   
 INSERT INTO @GAPSUMMARYTABLE  
 SELECT   
 mn.id as Id,  
 6 AS gapSummaryTypeId,  
 '''' AS Title,   
 ''Hospitalization - Type Of Room'' Needs,   
 CONVERT(VARCHAR(20), mn.typeOfRoomCoverage) + '' Bed'' AS AmountRequired,   
 CONVERT(VARCHAR(20), '''') AS ExistingArrangements,   
 '''' AS CurrentShortfall,   
 '''' AS MyPriorities  
 FROM myNeeds mn    
 WHERE mn.id = (select MAX(id) from myNeeds where caseId = @CaseId)
   
 --SAVING GOALS  
 INSERT INTO @GAPSUMMARYTABLE     
 SELECT   
 sg.id as Id,  
 7 AS gapSummaryTypeId,  
 ''SAVINGS'' AS Title,   
 ''Goal '' + convert(varchar(10), row_number () over (order by sg.id)) + '' : '' + ISNULL(sg.goal, '''') as Needs,
 CONVERT(VARCHAR(20), CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(sg.amtneededfv))) AS AmountRequired,
 CONVERT(VARCHAR(20), CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(sg.existingassetstotal)) + CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(sg.maturityvalue))) AS ExistingArrangements,
 CASE WHEN ((CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(sg.existingassetstotal)) + CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(sg.maturityvalue))) > CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(sg.amtneededfv))) THEN
	CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(sg.total))
 ELSE
	(-1) * CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(sg.total))
 END AS CurrentShortfall,
 @SAVINGGOAL AS MyPriorities  
 FROM savinggoals sg     
 WHERE sg.caseid = @CaseId
 AND deleted = 0    
   
 --EDUCATION GOALS  
 INSERT INTO @GAPSUMMARYTABLE  
 SELECT   
 eg.id as Id,  
 8 AS gapSummaryTypeId,  
 '''' AS Title,   
 ''Child''''s Education '' /*+ convert(varchar(10), row_number () over (order by eg.nameofchild)) */ + '' - '' + eg.nameofchild as Needs,   
 CONVERT(VARCHAR(20), CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(eg.futurecost))) AS AmountRequired,   
 CONVERT(VARCHAR(20), CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(eg.existingassetstotal)) + CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(eg.maturityvalue))) AS ExistingArrangements,   
 CASE WHEN ((CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(eg.existingassetstotal)) + CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(eg.maturityvalue))) > CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(eg.futurecost))) THEN 
	CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(eg.total))
 ELSE
	(-1) * CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(eg.total)) 
 END AS CurrentShortfall,   
 @CHILDEDUGOAL AS MyPriorities  
 FROM educationgoals eg     
 WHERE eg.caseid = @CaseId
 AND deleted = 0 
    
 --RETIREMENT GOALS  
 INSERT INTO @GAPSUMMARYTABLE  
 SELECT   
 rg.id as Id,  
 9 AS gapSummaryTypeId,  
 '''' AS Title,   
 ''Retirement ''/* + convert(varchar(10), row_number() over (order by rg.id))*/ Needs,   
 CONVERT(VARCHAR(20), CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(rg.lumpsumrequired))) AS AmountRequired,   
 CONVERT(VARCHAR(20), CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(rg.existingassetstotal)) + CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(rg.maturityvalue))) AS ExistingArrangements,   
 CASE WHEN ((CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(rg.existingassetstotal)) + CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(rg.maturityvalue))) > CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(rg.lumpsumrequired))) THEN 
	CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(rg.total))
 ELSE
	(-1) * CONVERT(DECIMAL(25,2), dbo.ConvertEmptyToZero(rg.total))
 END AS CurrentShortfall,    
 @RETIREMENTGOAL AS MyPriorities  
 FROM retirementgoals rg    
 WHERE rg.caseid = @CaseId
  
  IF NOT EXISTS (SELECT ID FROM @GAPSUMMARYTABLE WHERE gapSummaryTypeId = 1)
  BEGIN
	INSERT INTO @GAPSUMMARYTABLE VALUES (0, 1, ''PROTECTION'', ''Family Income Protection'', '''', '''', '''', '''')
  END
  IF NOT EXISTS (SELECT ID FROM @GAPSUMMARYTABLE WHERE gapSummaryTypeId = 2)
  BEGIN
	INSERT INTO @GAPSUMMARYTABLE VALUES (0, 2, '''', ''Mortgage Protection'', '''', '''', '''', '''')
  END
  IF NOT EXISTS (SELECT ID FROM @GAPSUMMARYTABLE WHERE gapSummaryTypeId = 3)
  BEGIN
	INSERT INTO @GAPSUMMARYTABLE VALUES (0, 3, '''', ''Critical Illness'', '''', '''', '''', '''')
  END
  IF NOT EXISTS (SELECT ID FROM @GAPSUMMARYTABLE WHERE gapSummaryTypeId = 4)
  BEGIN
	INSERT INTO @GAPSUMMARYTABLE VALUES (0, 4, '''', ''Disability Protection'', '''', '''', '''', '''')	
  END
  IF NOT EXISTS (SELECT ID FROM @GAPSUMMARYTABLE WHERE gapSummaryTypeId = 5)
  BEGIN
	INSERT INTO @GAPSUMMARYTABLE VALUES (0, 5, '''', ''Hospitalization - Type of Hospital'', '''', '''', '''', '''')	
  END
  IF NOT EXISTS (SELECT ID FROM @GAPSUMMARYTABLE WHERE gapSummaryTypeId = 6)
  BEGIN
	INSERT INTO @GAPSUMMARYTABLE VALUES (0, 6, '''', ''Hospitalization - Type Of Room'', '''', '''', '''', '''')	
  END
  IF NOT EXISTS (SELECT ID FROM @GAPSUMMARYTABLE WHERE gapSummaryTypeId = 7)
  BEGIN
	INSERT INTO @GAPSUMMARYTABLE VALUES (0, 7, ''SAVINGS'', ''Goal 1'', '''', '''', '''', '''')	
  END  
  IF NOT EXISTS (SELECT ID FROM @GAPSUMMARYTABLE WHERE gapSummaryTypeId = 8)
  BEGIN
	INSERT INTO @GAPSUMMARYTABLE VALUES (0, 8, '''', ''Child ''''s Education'', '''', '''', '''', '''')	
  END
  IF NOT EXISTS (SELECT ID FROM @GAPSUMMARYTABLE WHERE gapSummaryTypeId = 9)
  BEGIN
	INSERT INTO @GAPSUMMARYTABLE VALUES (0, 9, '''', ''Retirement'', '''', '''', '''', '''')	
  END
  
  SELECT Id, 
	 	 gapSummaryTypeId, 
		 Title, 
		 Needs, 
	     AmountRequired, 
	     ExistingArrangements, 
	     CurrentShortfall, 
	     MyPriorities 
  FROM @GAPSUMMARYTABLE
  ORDER BY gapSummaryTypeId
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CloneCase]    Script Date: 09/26/2012 00:52:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CloneCase]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CloneCase] 
	-- Add the parameters for the stored procedure here
	@CloneFromID nvarchar(50),
	@NewCaseID nvarchar(50)
AS
BEGIN
	
	/* clone my zurich adviser */
	if exists (select caseid from myzurichadviser where caseId = @CloneFromID)
	begin
		
		insert into myzurichadviser (caseId, selectedoptionid, selectedoptionothers)
		(select @NewCaseID, selectedoptionid, selectedoptionothers from myzurichadviser where caseId = @CloneFromID)
		
	end
	
	/* clone personal details and family member details */
	if exists (select caseid from personaldetails where caseId = @CloneFromID)
	begin
		
		insert into personaldetails (caseId, address, companyname, contactnumber, contactnumberfax, contactnumberhp, contactnumberoffice, datepicker, educationlevel, email, employmentstatus, gender, issmoker, maritalstatus, medicalcondition, medicalconditiondetails, name, nationality, nominee, nric, occupation, surname, title, will)
		(select @NewCaseID, address, companyname, contactnumber, contactnumberfax, contactnumberhp, contactnumberoffice, datepicker, educationlevel, email, employmentstatus, gender, issmoker, maritalstatus, medicalcondition, medicalconditiondetails, name, nationality, nominee, nric, occupation, surname, title, will from personaldetails where caseId = @CloneFromID)
		
		declare @personaldetailId int
		select @personaldetailId = id from personaldetails where caseId = @CloneFromID
		
		declare @newpersonaldetailId int
		select @newpersonaldetailId = id from personaldetails where caseId = @NewCaseID
		
		if exists (select personalDetailId from familyMemberDetails where personalDetailId = @personaldetailId)
		begin
			insert into familyMemberDetails (personalDetailId, dob, monthlyIncome, name, occupation, relationship, yrstosupport)
			(select @newpersonaldetailId, dob, monthlyIncome, name, occupation, relationship, yrstosupport from familyMemberDetails where personalDetailId = @personaldetailId)
		end
		
	end
	
	/* clone priority details */
	if exists (select caseid from priorityDetails where caseId = @CloneFromID)
	begin
		
		insert into priorityDetails (caseId, protection1, protection2, protection3, protection4, savings1, savings2, savings3)
		(select @NewCaseID, protection1, protection2, protection3, protection4, savings1, savings2, savings3 from priorityDetails where caseId = @CloneFromID)
		
	end
	
	/* clone income expense and its details */
	if exists (select caseid from incomeExpense where caseId = @CloneFromID)
	begin
		
		insert into incomeExpense (caseId, DeathTermInsurancePremium, DeathTermInsuranceSA, DeathTermInsuranceTerm, DeathWholeLifeInsurancePremium, DeathWholeLifeInsuranceSA, DeathWholeLifeInsuranceTerm, criticalIllnessMV, criticalIllnessPremium, criticalIllnessRemarks, criticalIllnessSA, disabilityIncomeMV, disabilityIncomePremium, disabilityIncomeRemarks, disabilityIncomeSA, emergencyFundsNeeded, expiry1, expiry2, expiry3, expiry4, expiry5, expiry6, expiry7, extraDetails, lifeInsuranceMV, lifeInsurancePremium, lifeInsuranceRemarks, lifeInsuranceSA, monthlySavings, mortgageMV, mortgagePremium, mortgageRemarks, mortgageSA, netMonthlyExpenses, netMonthlyIncomeAfterCpf, otherSourcesOfIncome, others1A, others1Premium, others1Remarks, others1V, others2, others2A, others2Premium, others2Remarks, others2V, shortTermGoals, tpdcMV, tpdcPremium, tpdcRemarks, tpdcSA)
		(select @NewCaseID, DeathTermInsurancePremium, DeathTermInsuranceSA, DeathTermInsuranceTerm, DeathWholeLifeInsurancePremium, DeathWholeLifeInsuranceSA, DeathWholeLifeInsuranceTerm, criticalIllnessMV, criticalIllnessPremium, criticalIllnessRemarks, criticalIllnessSA, disabilityIncomeMV, disabilityIncomePremium, disabilityIncomeRemarks, disabilityIncomeSA, emergencyFundsNeeded, expiry1, expiry2, expiry3, expiry4, expiry5, expiry6, expiry7, extraDetails, lifeInsuranceMV, lifeInsurancePremium, lifeInsuranceRemarks, lifeInsuranceSA, monthlySavings, mortgageMV, mortgagePremium, mortgageRemarks, mortgageSA, netMonthlyExpenses, netMonthlyIncomeAfterCpf, otherSourcesOfIncome, others1A, others1Premium, others1Remarks, others1V, others2, others2A, others2Premium, others2Remarks, others2V, shortTermGoals, tpdcMV, tpdcPremium, tpdcRemarks, tpdcSA from incomeExpense where caseId = @CloneFromID)
		
		declare @incomeexpenseId int
		select @incomeexpenseId = id from incomeExpense where caseId = @CloneFromID
		
		declare @newincomeexpenseId int
		select @newincomeexpenseId = id from incomeExpense where caseId = @NewCaseID
		
		if exists (select incomeExpenseId from insuranceArrangementSaving where incomeExpenseId = @incomeexpenseId)
		begin
			insert into insuranceArrangementSaving (incomeExpenseId, company, contribution, fundValue, natureOfPlan, policyOwnerName, term)
			(select @newincomeexpenseId, company, contribution, fundValue, natureOfPlan, policyOwnerName, term from insuranceArrangementSaving where incomeExpenseId = @incomeexpenseId)
		end
		
		if exists (select incomeExpenseId from insuranceArrangementRetirement where incomeExpenseId = @incomeexpenseId)
		begin
			insert into insuranceArrangementRetirement (incomeExpenseId, company, contribution, maturityDate, policyOwnerName, projectedIncomeMaturity, projectedLumpSumMaturity)
			(select @newincomeexpenseId, company, contribution, maturityDate, policyOwnerName, projectedIncomeMaturity, projectedLumpSumMaturity from insuranceArrangementRetirement where incomeExpenseId = @incomeexpenseId)
		end
		
		if exists (select incomeExpenseId from insuranceArrangementEducation where incomeExpenseId = @incomeexpenseId)
		begin
			insert into insuranceArrangementEducation (incomeExpenseId, company, contribution, maturityDate, policyOwnerName, projectedIncomeMaturity, projectedLumpSumMaturity)
			(select @newincomeexpenseId, company, contribution, maturityDate, policyOwnerName, projectedIncomeMaturity, projectedLumpSumMaturity from insuranceArrangementEducation where incomeExpenseId = @incomeexpenseId)
		end
		
	end
	
	/* clone asset liability and asset liability others */
	if exists (select caseid from assetAndLiability where caseId = @CloneFromID)
	begin
		
		insert into assetAndLiability (caseId, bankAcctCash, cashLoan, cpfMediSaveBalance, cpfoaBal, cpfsaBal, creditCard, homeMortgage, ilpCash, ilpCpf, invPropCash, invPropCpf, lumpSumCash, lumpSumCpf, netWorth, regularSumCash, regularSumCpf, resPropCash, resPropCpf, srsBal, srsInvCash, stocksSharesCash, stocksSharesCpf, unitTrustsCash, unitTrustsCpf, vehicleLoan)
		(select @NewCaseID, bankAcctCash, cashLoan, cpfMediSaveBalance, cpfoaBal, cpfsaBal, creditCard, homeMortgage, ilpCash, ilpCpf, invPropCash, invPropCpf, lumpSumCash, lumpSumCpf, netWorth, regularSumCash, regularSumCpf, resPropCash, resPropCpf, srsBal, srsInvCash, stocksSharesCash, stocksSharesCpf, unitTrustsCash, unitTrustsCpf, vehicleLoan from assetAndLiability where caseId = @CloneFromID)
		
		declare @assetliabilityId int
		select @assetliabilityId = id from assetAndLiability where caseId = @CloneFromID
		
		declare @newassetliabilityId int
		select @newassetliabilityId = id from assetAndLiability where caseId = @NewCaseID
		
		if exists (select assetLiabilityId from investedAssetOthers where assetLiabilityId = @assetliabilityId)
		begin
			insert into investedAssetOthers (assetDesc, assetLiabilityId, cash, cpf)
			(select assetDesc, @newassetliabilityId, cash, cpf from investedAssetOthers where assetLiabilityId = @assetliabilityId)
		end
		
		if exists (select assetLiabilityId from personalUseAssetsOthers where assetLiabilityId = @assetliabilityId)
		begin
			insert into personalUseAssetsOthers (assetDesc, assetLiabilityId, cash, cpf)
			(select assetDesc, @newassetliabilityId, cash, cpf from personalUseAssetsOthers where assetLiabilityId = @assetliabilityId)
		end
		
		if exists (select assetLiabilityId from liabilityOthers where assetLiabilityId = @assetliabilityId)
		begin
			insert into liabilityOthers (liabilityDesc, assetLiabilityId, cash)
			(select liabilityDesc, @newassetliabilityId, cash from liabilityOthers where assetLiabilityId = @assetliabilityId)
		end
		
	end
	
	/* clone protection goals - family needs and existing assets */
	if exists (select caseid from familyNeeds where caseId = @CloneFromID)
	begin
		
		insert into familyNeeds (caseId, emergencyFundsNeeded, existingAssetsFamilyneeds, existingLifeInsurance, existingSumRequiredChart, finalExpenses, inflationAdjustedReturns, inflationAdjustedReturnsGraph, lumpSumRequired, lumpSumRequiredChart, mortgageInsurance, mortgageLoan, mortgageProtectionInsurances, mortgageProtectionOutstanding, mortgageProtectionTotal, mortgageShortfall, otherComments, otherFundingNeeds, otherLiabilities, replacementIncomeChart, replacementIncomePercentage, replacementIncomeRequired, shortfallSumRequiredChart, totalRequired, totalShortfallSurplus, yearsOfSupportRequired, yearsOfSupportRequiredGraph)
		(select @NewCaseID, emergencyFundsNeeded, existingAssetsFamilyneeds, existingLifeInsurance, existingSumRequiredChart, finalExpenses, inflationAdjustedReturns, inflationAdjustedReturnsGraph, lumpSumRequired, lumpSumRequiredChart, mortgageInsurance, mortgageLoan, mortgageProtectionInsurances, mortgageProtectionOutstanding, mortgageProtectionTotal, mortgageShortfall, otherComments, otherFundingNeeds, otherLiabilities, replacementIncomeChart, replacementIncomePercentage, replacementIncomeRequired, shortfallSumRequiredChart, totalRequired, totalShortfallSurplus, yearsOfSupportRequired, yearsOfSupportRequiredGraph from familyNeeds where caseId = @CloneFromID)
		
		declare @familyneedsId int
		select @familyneedsId = id from familyNeeds where caseId = @CloneFromID
		
		declare @newfamilyneedsId int
		select @newfamilyneedsId = id from familyNeeds where caseId = @NewCaseID
		
		if exists (select familyNeedId from familyNeedsAssets where familyNeedId = @familyneedsId)
		begin
			insert into familyNeedsAssets (familyNeedId, asset, presentValue)
			(select @newfamilyneedsId, asset, presentValue from familyNeedsAssets where familyNeedId = @familyneedsId)
		end
		
	end
	
	/* clone protection goals - my needs and existing assets */
	if exists (select caseid from myNeeds where caseId = @CloneFromID)
	begin
		
		insert into myNeeds (caseId, anyExistingPlans, coverageDentalYesNo, coverageIncomeYesNo, coverageOldageYesNo, coverageOutpatientYesNo, coveragePersonalYesNo, criticalIllnessInsurance, detailsOfExistingPlans, disabilityInsurance, disabilityInsuranceMyNeeds, disabilityProtectionReplacementIncomeRequired, disabilityProtectionReplacementIncomeRequiredPercentage, disabilityReplacementAmountRequired, disabilityYearsOfSupport, epDentalYesNo, epIncomeYesNo, epOldageYesNo, epOutpatientYesNo, epPersonalYesNo, existingAssetsMyneeds, existingAssetsMyneedsDisability, existingMyNeeds, existingPlansDetail, existingSumMyNeeds, inflatedAdjustedReturns, inflationAdjustedReturns, lumpSumMyNeeds, lumpSumRequiredForTreatment, monthlyAmountMyNeeds, monthlyCoverageRequired, monthlyIncomeDisabilityIncome, percentOfIncomeCoverageRequired, replacementAmountRequired, replacementIncomePercentage, replacementIncomeRequired, shortfallMyNeeds, shortfallSumMyNeeds, shortfallSurplusMyNeeds, totalRequired, totalShortfallSurplusMyNeeds, txtExistingAssetsFamilyneeds, typeOfHospitalCoverage, typeOfRoomCoverage, yearsOfSupportRequired)
		(select @NewCaseID, anyExistingPlans, coverageDentalYesNo, coverageIncomeYesNo, coverageOldageYesNo, coverageOutpatientYesNo, coveragePersonalYesNo, criticalIllnessInsurance, detailsOfExistingPlans, disabilityInsurance, disabilityInsuranceMyNeeds, disabilityProtectionReplacementIncomeRequired, disabilityProtectionReplacementIncomeRequiredPercentage, disabilityReplacementAmountRequired, disabilityYearsOfSupport, epDentalYesNo, epIncomeYesNo, epOldageYesNo, epOutpatientYesNo, epPersonalYesNo, existingAssetsMyneeds, existingAssetsMyneedsDisability, existingMyNeeds, existingPlansDetail, existingSumMyNeeds, inflatedAdjustedReturns, inflationAdjustedReturns, lumpSumMyNeeds, lumpSumRequiredForTreatment, monthlyAmountMyNeeds, monthlyCoverageRequired, monthlyIncomeDisabilityIncome, percentOfIncomeCoverageRequired, replacementAmountRequired, replacementIncomePercentage, replacementIncomeRequired, shortfallMyNeeds, shortfallSumMyNeeds, shortfallSurplusMyNeeds, totalRequired, totalShortfallSurplusMyNeeds, txtExistingAssetsFamilyneeds, typeOfHospitalCoverage, typeOfRoomCoverage, yearsOfSupportRequired from myNeeds where caseId = @CloneFromID)
		
		declare @myneedsId int
		select @myneedsId = id from myNeeds where caseId = @CloneFromID
		
		declare @newmyneedsId int
		select @newmyneedsId = id from myNeeds where caseId = @NewCaseID
		
		if exists (select myNeedId from myNeedsCriticalAssets where myNeedId = @myneedsId)
		begin
			insert into myNeedsCriticalAssets (myNeedId, asset, presentValue)
			(select @newmyneedsId, asset, presentValue from myNeedsCriticalAssets where myNeedId = @myneedsId)
		end
		
		if exists (select myNeedId from myNeedsDisabilityAssets where myNeedId = @myneedsId)
		begin
			insert into myNeedsDisabilityAssets (myNeedId, asset, presentValue)
			(select @newmyneedsId, asset, presentValue from myNeedsDisabilityAssets where myNeedId = @myneedsId)
		end
		
	end
	
	/* clone education goals and existing assets */
	if exists (select caseid from educationgoals where caseId = @CloneFromID)
	begin
		
		insert into educationgoals (caseid, agefundsneeded, countryofstudyid, currentage, deleted, existingassetstotal, futurecost, inflationrate, maturityvalue, nameofchild, noofyrstosave, presentcost, total)
		(select @NewCaseID, agefundsneeded, countryofstudyid, currentage, deleted, existingassetstotal, futurecost, inflationrate, maturityvalue, nameofchild, noofyrstosave, presentcost, total from educationgoals where caseId = @CloneFromID)
		
		declare @educationgoalId int
		declare @neweducationgoalId int
		
		declare cursor_educationgoalids cursor for  
		select id from educationgoals where caseid = @CloneFromID
		
		declare cursor_neweducationgoalids cursor for  
		select id from educationgoals where caseid = @NewCaseID
		
		declare @existingrowcount int = 0
		declare @newcount int = 0  

		open cursor_educationgoalids   
		fetch next from cursor_educationgoalids into @educationgoalId 
		
		while @@FETCH_STATUS = 0   
		begin   
			   set @existingrowcount = @existingrowcount + 1   
			   set @newcount = 0
			   
			   if exists (select educationgoalsid from existingasseteg where educationgoalsid = @educationgoalId)
			   begin
					open cursor_neweducationgoalids   
					while @newcount!=@existingrowcount
					begin
						set @newcount = @newcount + 1
						fetch next from cursor_neweducationgoalids into @neweducationgoalId
					end
					close cursor_neweducationgoalids
					
					insert into existingasseteg (asset, educationgoalsid, percentpa, presentvalue)
					(select asset, @neweducationgoalId, percentpa, presentvalue from existingasseteg where educationgoalsid = @educationgoalId)
			   end

			   fetch next from cursor_educationgoalids into @educationgoalId   
		end   

		close cursor_educationgoalids
		
	end
	
	/* clone saving goals and existing assets */
	if exists (select caseid from savinggoals where caseId = @CloneFromID)
	begin
		
		insert into savinggoals (caseid, amtneededfv, deleted, existingassetstotal, goal, inflationrate, maturityvalue, regularannualcontrib, total, yrstoaccumulate)
		(select @NewCaseID, amtneededfv, deleted, existingassetstotal, goal, inflationrate, maturityvalue, regularannualcontrib, total, yrstoaccumulate from savinggoals where caseId = @CloneFromID)
		
		declare @savinggoalId int
		declare @newsavinggoalId int
		
		declare cursor_savinggoalids cursor for  
		select id from savinggoals where caseid = @CloneFromID
		
		declare cursor_newsavinggoalids cursor for  
		select id from savinggoals where caseid = @NewCaseID
		
		declare @existingrowcountsg int = 0
		declare @newcountsg int = 0  

		open cursor_savinggoalids   
		fetch next from cursor_savinggoalids into @savinggoalId 
		
		while @@FETCH_STATUS = 0   
		begin   
			   set @existingrowcountsg = @existingrowcountsg + 1   
			   set @newcountsg = 0
			   
			   if exists (select savinggoalsid from existingassetsg where savinggoalsid = @savinggoalId)
			   begin
					open cursor_newsavinggoalids   
					while @newcountsg!=@existingrowcountsg
					begin
						set @newcountsg = @newcountsg + 1
						fetch next from cursor_newsavinggoalids into @newsavinggoalId
					end
					close cursor_newsavinggoalids
					
					insert into existingassetsg (asset, savinggoalsid, percentpa, presentvalue)
					(select asset, @newsavinggoalId, percentpa, presentvalue from existingassetsg where savinggoalsid = @savinggoalId)
			   end

			   fetch next from cursor_savinggoalids into @savinggoalId   
		end   

		close cursor_savinggoalids
		
	end
	
	/* clone retirement goal and existing assets */
	if exists (select caseid from retirementgoals where caseId = @CloneFromID)
	begin
		
		insert into retirementgoals (caseId, durationretirement, existingassetstotal, futureincome, incomerequired, inflationrate, inflationreturnrate, intendedretirementage, lumpsumrequired, maturityvalue, selforspouse, sourcesofincome, total, totalfirstyrincome, yrstoretirement)
		(select @NewCaseID, durationretirement, existingassetstotal, futureincome, incomerequired, inflationrate, inflationreturnrate, intendedretirementage, lumpsumrequired, maturityvalue, selforspouse, sourcesofincome, total, totalfirstyrincome, yrstoretirement from retirementgoals where caseId = @CloneFromID)
		
		declare @retirementgoalId int
		select @retirementgoalId = id from retirementgoals where caseId = @CloneFromID
		
		declare @newretirementgoalId int
		select @newretirementgoalId = id from retirementgoals where caseId = @NewCaseID
		
		if exists (select retirementgoalsid from existingassetrg where retirementgoalsid = @retirementgoalId)
		begin
			insert into existingassetrg (asset, percentpa, presentvalue, retirementgoalsid)
			(select asset, percentpa, presentvalue, @newretirementgoalId from existingassetrg where retirementgoalsid = @retirementgoalId)
		end
		
	end
	
	/* clone risk profile */
	if exists (select caseid from RiskProfileAnalysis where caseId = @CloneFromID)
	begin
		
		insert into RiskProfileAnalysis (caseId, agreeWithRiskProfileoption1, agreeWithRiskProfileoption2, measuringRiskTakingAbilityQuestion1option1, measuringRiskTakingAbilityQuestion1option2, measuringRiskTakingAbilityQuestion1option3, measuringRiskTakingAbilityQuestion1option4, measuringRiskTakingAbilityQuestion2option1, measuringRiskTakingAbilityQuestion2option2, measuringRiskTakingAbilityQuestion2option3, measuringRiskTakingAbilityQuestion3option1, measuringRiskTakingAbilityQuestion3option2, measuringRiskTakingAbilityQuestion3option3, measuringRiskTakingAbilityQuestion3option4, measuringRiskTakingAbilityQuestion4option1, measuringRiskTakingAbilityQuestion4option2, measuringRiskTakingAbilityQuestion4option3, measuringRiskTakingAbilityQuestion4option4, riskApetiteQuestion1option1, riskApetiteQuestion1option2, riskApetiteQuestion1option3, riskApetiteQuestion1option4, riskApetiteQuestion1option5, riskApetiteQuestion1option6, riskApetiteQuestion2option1, riskApetiteQuestion2option2, riskApetiteQuestion2option3, riskApetiteQuestion2option4, riskApetiteQuestion3option1, riskApetiteQuestion3option2, riskApetiteQuestion3option3, riskApetiteQuestion3option4, riskApetiteQuestion3option5, riskApetiteQuestion4option1, riskApetiteQuestion4option2, riskApetiteQuestion4option3, riskProfileName, riskProfileValue)
		(select @NewCaseID, agreeWithRiskProfileoption1, agreeWithRiskProfileoption2, measuringRiskTakingAbilityQuestion1option1, measuringRiskTakingAbilityQuestion1option2, measuringRiskTakingAbilityQuestion1option3, measuringRiskTakingAbilityQuestion1option4, measuringRiskTakingAbilityQuestion2option1, measuringRiskTakingAbilityQuestion2option2, measuringRiskTakingAbilityQuestion2option3, measuringRiskTakingAbilityQuestion3option1, measuringRiskTakingAbilityQuestion3option2, measuringRiskTakingAbilityQuestion3option3, measuringRiskTakingAbilityQuestion3option4, measuringRiskTakingAbilityQuestion4option1, measuringRiskTakingAbilityQuestion4option2, measuringRiskTakingAbilityQuestion4option3, measuringRiskTakingAbilityQuestion4option4, riskApetiteQuestion1option1, riskApetiteQuestion1option2, riskApetiteQuestion1option3, riskApetiteQuestion1option4, riskApetiteQuestion1option5, riskApetiteQuestion1option6, riskApetiteQuestion2option1, riskApetiteQuestion2option2, riskApetiteQuestion2option3, riskApetiteQuestion2option4, riskApetiteQuestion3option1, riskApetiteQuestion3option2, riskApetiteQuestion3option3, riskApetiteQuestion3option4, riskApetiteQuestion3option5, riskApetiteQuestion4option1, riskApetiteQuestion4option2, riskApetiteQuestion4option3, riskProfileName, riskProfileValue from RiskProfileAnalysis where caseId = @CloneFromID)
		
	end
	
	/* clone cka assessment */
	if exists (select caseid from CkaAssessment where caseId = @CloneFromID)
	begin
		
		insert into CkaAssessment (caseId, agreeCKA, csaOutcomeOption1, csaOutcomeOption2, disagreeCKA, educationalExperienceOption1, educationalExperienceOption2, financeRelatedKnowledgeOption1, financeRelatedKnowledgeOption2, investmentExperienceOption1, investmentExperienceOption2, workingExperienceOption1, workingExperienceOption2)
		(select @NewCaseID, agreeCKA, csaOutcomeOption1, csaOutcomeOption2, disagreeCKA, educationalExperienceOption1, educationalExperienceOption2, financeRelatedKnowledgeOption1, financeRelatedKnowledgeOption2, investmentExperienceOption1, investmentExperienceOption2, workingExperienceOption1, workingExperienceOption2 from CkaAssessment where caseId = @CloneFromID)
		
	end
	
	/* clone portfolio builder */
	if exists (select caseid from portFolioBuilderMaster where caseId = @CloneFromID)
	begin
		
		insert into portFolioBuilderMaster (caseId, agreeWithRiskProfile, assetAllocationOnRiskProfileYesNo, followAssetAllocationOnRiskProfileYesNo, includeNonCoreFundsYesNo, paymentMode, preferredRiskProfile, premiumAmount, premiumPercent, premiumSelect, premiumTotalAmount, riskProfileId)
		(select @NewCaseID, agreeWithRiskProfile, assetAllocationOnRiskProfileYesNo, followAssetAllocationOnRiskProfileYesNo, includeNonCoreFundsYesNo, paymentMode, preferredRiskProfile, premiumAmount, premiumPercent, premiumSelect, premiumTotalAmount, riskProfileId from portFolioBuilderMaster where caseId = @CloneFromID)
		
		declare @portfoliobuilderId int
		select @portfoliobuilderId = id from portFolioBuilderMaster where caseId = @CloneFromID
		
		declare @newportfoliobuilderId int
		select @newportfoliobuilderId = id from portFolioBuilderMaster where caseId = @NewCaseID
		
		if exists (select portFolioBuilderId from portFolioBuilderDetail where portFolioBuilderId = @portfoliobuilderId)
		begin
			insert into portFolioBuilderDetail (portFolioBuilderId, allocationPercentage, amount, assetClassId, fundId)
			(select @newportfoliobuilderId, allocationPercentage, amount, assetClassId, fundId from portFolioBuilderDetail where portFolioBuilderId = @portfoliobuilderId)
		end
		
	end
	
END
' 
END
GO
/****** Object:  ForeignKey [FK_familyMemberDetails_familyMemberDetails]    Script Date: 09/26/2012 00:52:25 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_familyMemberDetails_familyMemberDetails]') AND parent_object_id = OBJECT_ID(N'[dbo].[familyMemberDetails]'))
ALTER TABLE [dbo].[familyMemberDetails]  WITH CHECK ADD  CONSTRAINT [FK_familyMemberDetails_familyMemberDetails] FOREIGN KEY([memberId])
REFERENCES [dbo].[familyMemberDetails] ([memberId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_familyMemberDetails_familyMemberDetails]') AND parent_object_id = OBJECT_ID(N'[dbo].[familyMemberDetails]'))
ALTER TABLE [dbo].[familyMemberDetails] CHECK CONSTRAINT [FK_familyMemberDetails_familyMemberDetails]
GO
/****** Object:  ForeignKey [FK_country_educationgoals]    Script Date: 09/26/2012 00:52:26 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_country_educationgoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[educationgoals]'))
ALTER TABLE [dbo].[educationgoals]  WITH CHECK ADD  CONSTRAINT [FK_country_educationgoals] FOREIGN KEY([countryofstudyid])
REFERENCES [dbo].[countrycostofeducation] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_country_educationgoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[educationgoals]'))
ALTER TABLE [dbo].[educationgoals] CHECK CONSTRAINT [FK_country_educationgoals]
GO
/****** Object:  ForeignKey [FK_existingassetsg_savinggoals]    Script Date: 09/26/2012 00:52:28 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_existingassetsg_savinggoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[existingassetsg]'))
ALTER TABLE [dbo].[existingassetsg]  WITH CHECK ADD  CONSTRAINT [FK_existingassetsg_savinggoals] FOREIGN KEY([savinggoalsid])
REFERENCES [dbo].[savinggoals] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_existingassetsg_savinggoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[existingassetsg]'))
ALTER TABLE [dbo].[existingassetsg] CHECK CONSTRAINT [FK_existingassetsg_savinggoals]
GO
/****** Object:  ForeignKey [FK_existingassetrg_retirementgoals]    Script Date: 09/26/2012 00:52:28 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_existingassetrg_retirementgoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[existingassetrg]'))
ALTER TABLE [dbo].[existingassetrg]  WITH CHECK ADD  CONSTRAINT [FK_existingassetrg_retirementgoals] FOREIGN KEY([retirementgoalsid])
REFERENCES [dbo].[retirementgoals] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_existingassetrg_retirementgoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[existingassetrg]'))
ALTER TABLE [dbo].[existingassetrg] CHECK CONSTRAINT [FK_existingassetrg_retirementgoals]
GO
/****** Object:  ForeignKey [FK_existingasseteg_educationgoals]    Script Date: 09/26/2012 00:52:28 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_existingasseteg_educationgoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[existingasseteg]'))
ALTER TABLE [dbo].[existingasseteg]  WITH CHECK ADD  CONSTRAINT [FK_existingasseteg_educationgoals] FOREIGN KEY([educationgoalsid])
REFERENCES [dbo].[educationgoals] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_existingasseteg_educationgoals]') AND parent_object_id = OBJECT_ID(N'[dbo].[existingasseteg]'))
ALTER TABLE [dbo].[existingasseteg] CHECK CONSTRAINT [FK_existingasseteg_educationgoals]
GO
