/**********************************************************************
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      25MAY18
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
***********************************************************************/
  data WORK.hf_info (compress = yes);
  %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
  infile 'C:\Users\rossz\OneDrive\App\R\R-Play\02-MergeHedgeFund\最终结果-csv\hf.info.sas.csv' delimiter = ','
MISSOVER DSD lrecl=32767 firstobs=2;
     informat fund_name $1000. ;
     informat ndup $1000. ;
     informat db_name $1000. ;
     informat pp_fund_id $1000. ;
     informat pp_fund_code $1000. ;
     informat pp_fund_name $1000. ;
     informat pp_fund_name_short $1000. ;
     informat pp_fund_type $1000. ;
     informat pp_currency $1000. ;
     informat pp_foundation_date $1000. ;
     informat pp_performance_start_date $1000. ;
     informat pp_lockup_period $1000. ;
     informat pp_duration $1000. ;
     informat pp_initial_size $1000. ;
     informat pp_strategy $1000. ;
     informat pp_streategy_sub $1000. ;
     informat pp_fund_status $1000. ;
     informat pp_liquidate_date $1000. ;
     informat pp_update_date $1000. ;
     informat fund_name_short $1000. ;
     informat zy_fund_id $1000. ;
     informat zy_fund_name_short $1000. ;
     informat zy_fund_name $1000. ;
     informat zy_foundation_date anydtdtm40. ;
     informat zy_end_date anydtdtm40. ;
     informat zy_init_nav $1000. ;
     informat zy_init_total_nav $1000. ;
     informat zy_init_total_asset $1000. ;
     informat zy_issuing_scale $1000. ;
     informat zy_orientation $1000. ;
     informat zy_instruction $1000. ;
     informat zy_account_number $1000. ;
     informat zy_account_name $1000. ;
     informat zy_country $1000. ;
     informat zy_prov $1000. ;
     informat zy_city $1000. ;
     informat zy_min_purchase_amount $1000. ;
     informat zy_min_append_amount $1000. ;
     informat zy_investment_idea $1000. ;
     informat zy_investment_restriction $1000. ;
     informat zy_purchase_status $1000. ;
     informat zy_redemption_status $1000. ;
     informat zy_open_date $1000. ;
     informat zy_locked_time_limit anydtdtm40. ;
     informat zy_locked_time_limit_value $1000. ;
     informat zy_locked_time_limit_unit $1000. ;
     informat zy_locked_time_limit_desc $1000. ;
     informat zy_fund_time_limit anydtdtm40. ;
     informat zy_fund_time_limit_value $1000. ;
     informat zy_fund_time_limit_unit $1000. ;
     informat zy_is_exist_fund_time_limit $1000. ;
     informat zy_duration $1000. ;
     informat zy_expected_return $1000. ;
     informat zy_data_freq_value $1000. ;
     informat zy_data_freq_unit $1000. ;
     informat zy_recommendation_start $1000. ;
     informat zy_recommendation_end $1000. ;
     informat zy_feature $1000. ;
     informat zy_appraise $1000. ;
     informat zy_investment_target $1000. ;
     informat zy_investment_strategy $1000. ;
     informat zy_investment_range $1000. ;
     informat zy_asset_allocation $1000. ;
     informat zy_comparison_datum $1000. ;
     informat zy_remark $1000. ;
     informat zy_status $1000. ;
     informat zy_entry_time anydtdtm40. ;
     informat zy_update_time anydtdtm40. ;
     informat zy_tmstamp $1000. ;
     informat zy_fund_group $1000. ;
     informat dzh_fund_id $1000. ;
     informat dzh_fund_name_short $1000. ;
     informat dzh_fund_name $1000. ;
     informat dzh_foundation_date anydtdtm40. ;
     informat dzh_manager $1000. ;
     informat dzh_manager_cv $1000. ;
     informat dzh_advisor $1000. ;
     informat dzh_liquidation_date $1000. ;
     informat dzh_fund_type $1000. ;
     informat dzh_company $1000. ;
     informat dzh_custodian $1000. ;
     informat dzh_broker $1000. ;
     informat dzh_trust_company $1000. ;
     informat wind_fund_id $1000. ;
     informat wind_fund_name $1000. ;
     informat wind_fund_name_short $1000. ;
     informat wind_f_info_corp_managementcomp $1000. ;
     informat wind_f_info_custodianbank $1000. ;
     informat wind_f_info_firstinvesttype $1000. ;
     informat wind_f_info_setupdate $1000. ;
     informat wind_f_info_maturitydate $1000. ;
     informat wind_f_issue_totalunit $1000. ;
     informat wind_f_info_managementfeeratio $1000. ;
     informat wind_f_info_custodianfeeratio $1000. ;
     informat wind_crncy_code $1000. ;
     informat wind_f_info_ptmyear $1000. ;
     informat wind_f_issue_oef_startdateinst $1000. ;
     informat wind_f_issue_oef_dnddateinst $1000. ;
     informat wind_f_info_parvalue $1000. ;
     informat wind_f_info_trusttype $1000. ;
     informat wind_f_info_trustee $1000. ;
     informat wind_f_pchredm_pchstartdate $1000. ;
     informat wind_f_info_redmstartdate $1000. ;
     informat wind_f_info_minbuyamount $1000. ;
     informat wind_f_info_expectedrateofretur $1000. ;
     informat wind_f_info_issuingplace $1000. ;
     informat wind_f_info_benchmark $1000. ;
     informat wind_f_info_status $1000. ;
     informat wind_f_info_restrictedornot $1000. ;
     informat wind_f_info_structuredornot $1000. ;
     informat wind_f_info_investscope $1000. ;
     informat wind_summary $1000. ;
     informat wind_lockperiod $1000. ;
     informat wind_unlockperiod $1000. ;
     informat wind_est_issue_size $1000. ;
     informat wind_issue_size $1000. ;
     informat wind_min_amount $1000. ;
     informat wind_float_income $1000. ;
     informat wind_fundmanagementcompid $1000. ;
     informat wind_advisor $1000. ;
     informat wind_opdate $1000. ;
     informat wind_opmode $1000. ;
     format fund_name $1000. ;
     format ndup $1000. ;
     format db_name $1000. ;
     format pp_fund_id $1000. ;
     format pp_fund_code $1000. ;
     format pp_fund_name $1000. ;
     format pp_fund_name_short $1000. ;
     format pp_fund_type $1000. ;
     format pp_currency $1000. ;
     format pp_foundation_date $1000. ;
     format pp_performance_start_date $1000. ;
     format pp_lockup_period $1000. ;
     format pp_duration $1000. ;
     format pp_initial_size $1000. ;
     format pp_strategy $1000. ;
     format pp_streategy_sub $1000. ;
     format pp_fund_status $1000. ;
     format pp_liquidate_date $1000. ;
     format pp_update_date $1000. ;
     format fund_name_short $1000. ;
     format zy_fund_id $1000. ;
     format zy_fund_name_short $1000. ;
     format zy_fund_name $1000. ;
     format zy_foundation_date datetime. ;
     format zy_end_date datetime. ;
     format zy_init_nav $1000. ;
     format zy_init_total_nav $1000. ;
     format zy_init_total_asset $1000. ;
     format zy_issuing_scale $1000. ;
     format zy_orientation $1000. ;
     format zy_instruction $1000. ;
     format zy_account_number $1000. ;
     format zy_account_name $1000. ;
     format zy_country $1000. ;
     format zy_prov $1000. ;
     format zy_city $1000. ;
     format zy_min_purchase_amount $1000. ;
     format zy_min_append_amount $1000. ;
     format zy_investment_idea $1000. ;
     format zy_investment_restriction $1000. ;
     format zy_purchase_status $1000. ;
     format zy_redemption_status $1000. ;
     format zy_open_date $1000. ;
     format zy_locked_time_limit datetime. ;
     format zy_locked_time_limit_value $1000. ;
     format zy_locked_time_limit_unit $1000. ;
     format zy_locked_time_limit_desc $1000. ;
     format zy_fund_time_limit datetime. ;
     format zy_fund_time_limit_value $1000. ;
     format zy_fund_time_limit_unit $1000. ;
     format zy_is_exist_fund_time_limit $1000. ;
     format zy_duration $1000. ;
     format zy_expected_return $1000. ;
     format zy_data_freq_value $1000. ;
     format zy_data_freq_unit $1000. ;
     format zy_recommendation_start $1000. ;
     format zy_recommendation_end $1000. ;
     format zy_feature $1000. ;
     format zy_appraise $1000. ;
     format zy_investment_target $1000. ;
     format zy_investment_strategy $1000. ;
     format zy_investment_range $1000. ;
     format zy_asset_allocation $1000. ;
     format zy_comparison_datum $1000. ;
     format zy_remark $1000. ;
     format zy_status $1000. ;
     format zy_entry_time datetime. ;
     format zy_update_time datetime. ;
     format zy_tmstamp $1000. ;
     format zy_fund_group $1000. ;
     format dzh_fund_id $1000. ;
     format dzh_fund_name_short $1000. ;
     format dzh_fund_name $1000. ;
     format dzh_foundation_date datetime. ;
     format dzh_manager $1000. ;
     format dzh_manager_cv $1000. ;
     format dzh_advisor $1000. ;
     format dzh_liquidation_date $1000. ;
     format dzh_fund_type $1000. ;
     format dzh_company $1000. ;
     format dzh_custodian $1000. ;
     format dzh_broker $1000. ;
     format dzh_trust_company $1000. ;
     format wind_fund_id $1000. ;
     format wind_fund_name $1000. ;
     format wind_fund_name_short $1000. ;
     format wind_f_info_corp_managementcomp $1000. ;
     format wind_f_info_custodianbank $1000. ;
     format wind_f_info_firstinvesttype $1000. ;
     format wind_f_info_setupdate $1000. ;
     format wind_f_info_maturitydate $1000. ;
     format wind_f_issue_totalunit $1000. ;
     format wind_f_info_managementfeeratio $1000. ;
     format wind_f_info_custodianfeeratio $1000. ;
     format wind_crncy_code $1000. ;
     format wind_f_info_ptmyear $1000. ;
     format wind_f_issue_oef_startdateinst $1000. ;
     format wind_f_issue_oef_dnddateinst $1000. ;
     format wind_f_info_parvalue $1000. ;
     format wind_f_info_trusttype $1000. ;
     format wind_f_info_trustee $1000. ;
     format wind_f_pchredm_pchstartdate $1000. ;
     format wind_f_info_redmstartdate $1000. ;
     format wind_f_info_minbuyamount $1000. ;
     format wind_f_info_expectedrateofretur $1000. ;
     format wind_f_info_issuingplace $1000. ;
     format wind_f_info_benchmark $1000. ;
     format wind_f_info_status $1000. ;
     format wind_f_info_restrictedornot $1000. ;
     format wind_f_info_structuredornot $1000. ;
     format wind_f_info_investscope $1000. ;
     format wind_summary $1000. ;
     format wind_lockperiod $1000. ;
     format wind_unlockperiod $1000. ;
     format wind_est_issue_size $1000. ;
     format wind_issue_size $1000. ;
     format wind_min_amount $1000. ;
     format wind_float_income $1000. ;
     format wind_fundmanagementcompid $1000. ;
     format wind_advisor $1000. ;
     format wind_opdate $1000. ;
     format wind_opmode $1000. ;
  input
              fund_name $
              ndup $
              db_name $
              pp_fund_id $
              pp_fund_code $
              pp_fund_name $
              pp_fund_name_short $
              pp_fund_type $
              pp_currency $
              pp_foundation_date 
              pp_performance_start_date 
              pp_lockup_period $
              pp_duration $
              pp_initial_size $
              pp_strategy $
              pp_streategy_sub $
              pp_fund_status $
              pp_liquidate_date $
              pp_update_date $
              fund_name_short $
              zy_fund_id $
              zy_fund_name_short $
              zy_fund_name $
              zy_foundation_date 
              zy_end_date 
              zy_init_nav $
              zy_init_total_nav $
              zy_init_total_asset $
              zy_issuing_scale $
              zy_orientation $
              zy_instruction $
              zy_account_number $
              zy_account_name $
              zy_country $
              zy_prov $
              zy_city $
              zy_min_purchase_amount $
              zy_min_append_amount $
              zy_investment_idea $
              zy_investment_restriction $
              zy_purchase_status $
              zy_redemption_status $
              zy_open_date $
              zy_locked_time_limit 
              zy_locked_time_limit_value $
              zy_locked_time_limit_unit $
              zy_locked_time_limit_desc $
              zy_fund_time_limit 
              zy_fund_time_limit_value $
              zy_fund_time_limit_unit $
              zy_is_exist_fund_time_limit $
              zy_duration $
              zy_expected_return $
              zy_data_freq_value $
              zy_data_freq_unit $
              zy_recommendation_start $
              zy_recommendation_end $
              zy_feature $
              zy_appraise $
              zy_investment_target $
              zy_investment_strategy $
              zy_investment_range $
              zy_asset_allocation $
              zy_comparison_datum $
              zy_remark $
              zy_status $
              zy_entry_time 
              zy_update_time 
              zy_tmstamp $
              zy_fund_group $
              dzh_fund_id $
              dzh_fund_name_short $
              dzh_fund_name $
              dzh_foundation_date 
              dzh_manager $
              dzh_manager_cv $
              dzh_advisor $
              dzh_liquidation_date $
              dzh_fund_type $
              dzh_company $
              dzh_custodian $
              dzh_broker $
              dzh_trust_company $
              wind_fund_id $
              wind_fund_name $
              wind_fund_name_short $
              wind_f_info_corp_managementcomp $
              wind_f_info_custodianbank $
              wind_f_info_firstinvesttype $
              wind_f_info_setupdate $
              wind_f_info_maturitydate $
              wind_f_issue_totalunit $
              wind_f_info_managementfeeratio $
              wind_f_info_custodianfeeratio $
              wind_crncy_code $
              wind_f_info_ptmyear $
              wind_f_issue_oef_startdateinst $
              wind_f_issue_oef_dnddateinst $
              wind_f_info_parvalue $
              wind_f_info_trusttype $
              wind_f_info_trustee $
              wind_f_pchredm_pchstartdate $
              wind_f_info_redmstartdate $
              wind_f_info_minbuyamount $
              wind_f_info_expectedrateofretur $
              wind_f_info_issuingplace $
              wind_f_info_benchmark $
              wind_f_info_status $
              wind_f_info_restrictedornot $
              wind_f_info_structuredornot $
              wind_f_info_investscope $
              wind_summary $
              wind_lockperiod $
              wind_unlockperiod $
              wind_est_issue_size $
              wind_issue_size $
              wind_min_amount $
              wind_float_income $
              wind_fundmanagementcompid $
              wind_advisor $
              wind_opdate $
              wind_opmode $
  ;
  if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
  run;



     /**********************************************************************
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      25MAY18
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
***********************************************************************/
  data WORK.hf_nv (compress = yes);
  %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
  infile 'C:\Users\rossz\OneDrive\App\R\R-Play\02-MergeHedgeFund\最终结果-csv\hf.nv.sas.csv' delimiter = ','
MISSOVER DSD lrecl=32767 firstobs=2 ;
     informat fund_name $100. ;
     informat date yymmdd10. ;
     informat db_name $6. ;
     informat pp_fund_id $100. ;
     informat pp_nv best32.  ;
     informat pp_cnv best32.  ;
     informat zy_fund_id $100. ;
     informat zy_nv best32. ;
     informat zy_cnv best32. ;
     informat zy_source $100. ;
     informat dzh_fund_id $100. ;
     informat dzh_nv best32.  ;
     informat dzh_cnv best32.  ;
     informat dzh_div $100.;
     informat dzh_distribution $100. ;
     informat wind_fund_id $100. ;
     informat wind_nv best32.  ;
     informat wind_cnv best32.  ;
     informat wind_currency $100. ;
     format fund_name $100. ;
     format date yymmdd10. ;
     format db_name $100. ;
     format pp_fund_id $100. ;
     format pp_nv best32.  ;
     format pp_cnv best32.  ;
     format zy_fund_id $100. ;
     format zy_nv best12. ;
     format zy_cnv best12. ;
     format zy_source $100. ;
     format dzh_fund_id $100. ;
     format dzh_nv best32.  ;
     format dzh_cnv best32.  ;
     format dzh_div $100. ;
     format dzh_distribution $100. ;
     format wind_fund_id $100. ;
     format wind_nv best32.  ;
     format wind_cnv best32.  ;
     format wind_currency $100. ;
  input
              fund_name $
              date
              db_name $
              pp_fund_id $
              pp_nv $
              pp_cnv $
              zy_fund_id
              zy_nv
              zy_cnv
              zy_source $
              dzh_fund_id $
              dzh_nv $
              dzh_cnv $
              dzh_div $
              dzh_distribution $
              wind_fund_id $
              wind_nv $
              wind_cnv $
              wind_currency $
  ;
  if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
  run;
