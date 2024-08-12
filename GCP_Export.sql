
-- Account Export Query
gcloud sql export csv beta-master-db-instance gs://da-local-files/userExport/all_account_export_Aug_26_Master.csv \
--async \
--database=da-db \
--offload \
--query="Select \"id\",\"domain\",\"name\",\"website\" from \"Accounts\";" \
--quote="22" \
--escape="5C" \
--fields-terminated-by="2C"

gcloud sql export csv beta-da-db-instance-21aec72f gs://da-local-files/userExport/full_account_export_07_OCT_2022.csv \                  
--async \         
--database=da-db \
--offload \
--query="Select \"id\", \"name\", \"researchStatus\", \"callingStatus\", \"complianceStatus\", \"stage\", \"zoomInfoName\", \"domain\", \"website\", \"description\", \"nsId\", \"zoomInfoContactId\", \"sicCode\", \"naicsCode\", \"sicDescription\", \"naicsDescription\", \"source\", \"employeeSourceLI\", \"employeeSourceZ_plus\", \"phoneHQ\", \"email\", \"industry\", \"subIndustry\", \"locationLI\", addr.*,\"linkedInUrl\", \"revenue\", \"revenue_M_B_K\", \"employeeSize\", \"employeeSizeLI\", \"employeeSizeZ_plus\", \"employeeSizeFinalBucket\", \"employeeSize_others\", \"employeeRangeLI\", \"disposition\", \"comments\", \"upperRevenue\", \"lowerRevenue\", \"upperEmployeeSize\", \"lowerEmployeeSize\", \"custom1\", \"custom2\", \"custom3\", \"custom4\", \"custom5\", \"custom6\", \"custom7\", \"custom8\", \"custom9\", \"custom10\", \"custom11\", \"custom12\", \"custom13\", \"custom14\", \"custom15\", \"createdAt\", \"updatedAt\", \"ProjectId\", \"createdBy\", \"updatedBy\", \"aliasName\", \"tokens\", \"scrubbedName\", \"label\", \"segment_technology\", \"emailDomain\", \"duplicateOf\", \"complianceComments\", \"deliveryStatus\", \"employeeSize_others_source\", \"qualifiedContacts\", \"potential\", \"finalDisposition\", \"ClientId\", \"parentDomain\", \"masterDisposition\" From \"Accounts\",json_to_record(\"addressHQ\") AS addr (\"address1HQ\"  TEXT,\"address2HQ\"  TEXT,\"cityHQ\" TEXT,\"stateHQ\" TEXT,\"countryHQ\" TEXT,\"zipCodeHQ\" TEXT);" \
--quote="22" \
--escape="5C" \
--fields-terminated-by="2C"

--------------------------------------------------------------------------------------------------------------------------------------------------
-- Contcat Export Querys

    SELECT * FROM \"Contacts\" where \"jobTitle\" ILIKE '%Corporate%' limit 1

-- Contact Export with Account Name Detail Join
WITH ctc_con AS ( SELECT DISTINCT ON (email) email,\"id\", \"researchStatus\", \"callingStatus\", \"complianceStatus\", \"prefix\", \"firstName\", \"middleName\", \"lastName\", addr.*, \"genericEmail\", \"phone\", \"directPhone\", \"jobTitle\", \"jobLevel\", \"jobDepartment\", \"nsId\", \"zoomInfoContactId\", \"linkedInUrl\", \"screenshot\", \"handles\", \"website\", \"comments\", \"source\", \"stage\", \"functions\", \"disposition\", \"zb\", \"gmailStatus\", \"mailTesterStatus\", \"custom1\", \"custom2\", \"custom3\", \"custom4\", \"custom5\", \"custom6\", \"custom7\", \"custom8\", \"custom9\", \"custom10\", \"custom11\", \"custom12\", \"custom13\", \"custom14\", \"custom15\", \"createdAt\", \"updatedAt\", \"AccountId\", \"createdBy\", \"updatedBy\", \"emailDedupeKey\", \"phoneDedupeKey\", \"companyDedupeKey\", \"label\", \"gmailStatusDateAndTime\", \"zbDateAndTime\", \"phoneExtension\", \"duplicateOf\", \"complianceComments\", \"deliveryStatus\", \"mobile\", \"emailNameDedupeKey\", \"emailDomainDedupeKey\", \"ClientId\", \"ProjectId\" FROM \"Contacts\" ,json_to_record(\"address\") AS addr (\"street1\"  TEXT,\"street2\"  TEXT,\"city\" TEXT,\"state\" TEXT,\"country\" TEXT,\"zipCode\" TEXT) limit 2) Select \"a\".\"name\" as \"Account_Name\",\"a\".\"website\" as \"Account_WebSite\",\"a\".\"domain\" as \"Account_Domain\",\"c\".* from ctc_con as \"c\" left outer join \"Accounts\" as \"a\" on \"c\".\"AccountId\" = \"a\".\"id\"

gcloud sql export csv beta-da-db-instance-21aec72f gs://da-local-files/userExport/contact_CIO2_20_OCT_2022.csv \
--async \
--database=da-db \
--offload \
--query="Select \"id\", \"researchStatus\", \"callingStatus\", \"complianceStatus\", \"prefix\", \"firstName\", \"middleName\", \"lastName\", addr.*, \"email\", \"genericEmail\", \"phone\", \"directPhone\", \"jobTitle\", \"jobLevel\", \"jobDepartment\", \"nsId\", \"zoomInfoContactId\", \"linkedInUrl\", \"screenshot\", \"handles\", \"website\", \"comments\", \"source\", \"stage\", \"functions\", \"disposition\", \"zb\", \"gmailStatus\", \"mailTesterStatus\", \"custom1\", \"custom2\", \"custom3\", \"custom4\", \"custom5\", \"custom6\", \"custom7\", \"custom8\", \"custom9\", \"custom10\", \"custom11\", \"custom12\", \"custom13\", \"custom14\", \"custom15\", \"createdAt\", \"updatedAt\", \"AccountId\", \"createdBy\", \"updatedBy\", \"emailDedupeKey\", \"phoneDedupeKey\", \"companyDedupeKey\", \"label\", \"gmailStatusDateAndTime\", \"zbDateAndTime\", \"phoneExtension\", \"duplicateOf\", \"complianceComments\", \"deliveryStatus\", \"mobile\", \"emailNameDedupeKey\", \"emailDomainDedupeKey\", \"ClientId\", \"ProjectId\" From \"Contacts\",json_to_record(\"address\") AS addr (\"street1\"  TEXT,\"street2\" TEXT,\"city\"  TEXT,\"state\" TEXT,\"country\" TEXT,\"zipCode\" TEXT) where \"jobTitle\" ILIKE '%Chief Information Officer%';" \
--quote="22" \
--escape="5C" \
--fields-terminated-by="2C"


--- All Contact Export with Account Details

gcloud sql export csv beta-da-db-instance-21aec72f gs://da-local-files/userExport/all_contact_01_APR_2023.csv \
--async \
--database=da-db \
--offload \
--query="Select \"a\".\"name\" as \"Account_Name\",\"a\".\"website\" as \"Account_WebSite\",\"a\".\"domain\" as \"Account_Domain\",\"c\".* from ( SELECT DISTINCT ON (email) email,\"id\", \"researchStatus\", \"callingStatus\", \"complianceStatus\", \"prefix\", \"firstName\", \"middleName\", \"lastName\", addr.*, \"genericEmail\", \"phone\", \"directPhone\", \"jobTitle\", \"jobLevel\", \"jobDepartment\", \"nsId\", \"zoomInfoContactId\", \"linkedInUrl\", \"screenshot\", \"handles\", \"website\", \"comments\", \"source\", \"stage\", \"functions\", \"disposition\", \"zb\", \"gmailStatus\", \"mailTesterStatus\", \"custom1\", \"custom2\", \"custom3\", \"custom4\", \"custom5\", \"custom6\", \"custom7\", \"custom8\", \"custom9\", \"custom10\", \"custom11\", \"custom12\", \"custom13\", \"custom14\", \"custom15\", \"createdAt\", \"updatedAt\", \"AccountId\", \"createdBy\", \"updatedBy\", \"emailDedupeKey\", \"phoneDedupeKey\", \"companyDedupeKey\", \"label\", \"gmailStatusDateAndTime\", \"zbDateAndTime\", \"phoneExtension\", \"duplicateOf\", \"complianceComments\", \"deliveryStatus\", \"mobile\", \"emailNameDedupeKey\", \"emailDomainDedupeKey\", \"ClientId\", \"ProjectId\" FROM \"Contacts\" ,json_to_record(\"address\") AS addr (\"street1\"  TEXT,\"street2\"  TEXT,\"city\" TEXT,\"state\" TEXT,\"country\" TEXT,\"zipCode\" TEXT) ) as \"c\" left outer join \"Accounts\" as \"a\" on \"c\".\"AccountId\" = \"a\".\"id\"" \
--quote="22" \
--escape="5C" \
--fields-terminated-by="2C"

--- All Contcat Export with Account Project and Client Details
    --- Headers for below Query --------------------------------
        --- Client_Name,Client_pseudonym,Project_Name,Project_deliveryDate,Project_CreatedAt,Account_Name,Account_WebSite,Account_Domain,unique,id,createdAt,createdBy,updatedAt,updatedBy,email,deliveryStatus,researchStatus,callingStatus,complianceStatus,complianceComments,prefix,firstName,middleName,lastName,street1,street2,city,state,country,zipCode,genericEmail,phone,directPhone,jobTitle,jobLevel,jobDepartment,nsId,zoomInfoContactId,linkedInUrl,screenshot,handles,website,comments,source,stage,functions,disposition,zb,gmailStatus,mailTesterStatus,custom1,custom2,custom3,custom4,custom5,custom6,custom7,custom8,custom9,custom10,custom11,custom12,custom13,custom14,custom15,emailDedupeKey,phoneDedupeKey,companyDedupeKey,label,gmailStatusDateAndTime,zbDateAndTime,phoneExtension,duplicateOf,mobile,emailNameDedupeKey,emailDomainDedupeKey,ClientId,ProjectId,AccountId


---- All Account Master + Location Export

    --- Select "a"."id" as "Account_id","a"."domain" as "Account_domain","a"."name" as "Account_name","a"."parentAccountName" as "Account_parentAccountName","a"."website" as "Account_website","a"."type" as "Account_type","a"."aliasName" as "Account_aliasName","a"."scrubbedAliasName" as "Account_scrubbedAliasName","a"."email" as "Account_email","a"."industry" as "Account_industry","a"."subIndustry" as "Account_subIndustry","a"."sicCode" as "Account_sicCode","a"."sicDescription" as "Account_sicDescription","a"."naicsCode" as "Account_naicsCode","a"."naicsDescription" as "Account_naicsDescription","a"."employeeRange" as "Account_employeeRange","a"."employeeSize" as "Account_employeeSize","a"."employeeSizeLI" as "Account_employeeSizeLI","a"."employeeSizeZPlus" as "Account_employeeSizeZPlus","a"."employeeSizeOthers" as "Account_employeeSizeOthers","a"."revenue" as "Account_revenue","a"."revenueRange" as "Account_revenueRange","a"."totalFunding" as "Account_totalFunding","a"."latestFundingAmount" as "Account_latestFundingAmount","a"."itSpend" as "Account_itSpend","a"."liUrl" as "Account_liUrl","a"."description" as "Account_description","a"."duns" as "Account_duns","a"."technology" as "Account_technology","a"."tags" as "Account_tags","a"."state" as "Account_state","a"."zipCode" as "Account_zipCode","a"."country" as "Account_country","a"."disposition" as "Account_disposition","a"."comments" as "Account_comments","a"."requestedBy" as "Account_requestedBy","a"."foundedYear" as "Account_foundedYear","a"."lastRaisedAt" as "Account_lastRaisedAt","a"."seoDescription" as "Account_seoDescription","a"."keywords" as "Account_keywords","a"."isVerified" as "Account_isVerified","a"."createdAt" as "Account_createdAt","a"."updatedAt" as "Account_updatedAt","a"."createdBy" as "Account_createdBy","a"."updatedBy" as "Account_updatedBy","a"."ParentAccountDomain" as "Account_ParentAccountDomain","a"."typeDescriptive" as "Account_typeDescriptive","a"."productAndService" as "Account_productAndService","l"."id" as "Location_id","l"."type" as "Location_type","l"."address1" as "Location_address1","l"."address2" as "Location_address2","l"."city" as "Location_city","l"."state" as "Location_state","l"."stateAbbreviation" as "Location_stateAbbreviation","l"."zipCode" as "Location_zipCode","l"."country" as "Location_country","l"."timeZone" as "Location_timeZone","l"."phone1" as "Location_phone1","l"."phone2" as "Location_phone2","l"."addressDedupeKey" as "Location_addressDedupeKey","l"."region" as "Location_region","l"."createdAt" as "Location_createdAt","l"."updatedAt" as "Location_updatedAt","l"."AccountDomain" as "Location_AccountDomain","l"."createdBy" as "Location_createdBy","l"."updatedBy" as "Location_updatedBy" from "Accounts" as "a" inner join "Locations" as "l" on "a"."domain" = "l"."AccountDomain"

---- All Account + Contcats Fields

gcloud sql export csv beta-da-db-instance-21aec72f gs://da-local-files/userExport/all_contact_01_JAN_2024_pie.csv \
--async \
--database=da-db \
--offload \
--query="Select \"cl\".\"id\" as \"Client_Id\",\"cl\".\"name\" as \"Client_Name\",\"cl\".\"pseudonym\" as \"Client_Pseudonym\",acc.*,con.* from ( Select DISTINCT ON (contact_email) contact_email as \"con_dis_email\",\"co\".* from ( Select \"c\".\"id\" as \"Contact_id\",\"c\".\"researchStatus\" as \"Contact_researchStatus\",\"c\".\"callingStatus\" as \"Contact_callingStatus\",\"c\".\"complianceStatus\" as \"Contact_complianceStatus\",\"c\".\"prefix\" as \"Contact_prefix\",\"c\".\"firstName\" as \"Contact_firstName\",\"c\".\"middleName\" as \"Contact_middleName\",\"c\".\"lastName\" as \"Contact_lastName\",con_addr.*,\"c\".\"email\" as \"contact_email\",\"c\".\"genericEmail\" as \"Contact_genericEmail\",\"c\".\"phone\" as \"Contact_phone\",\"c\".\"directPhone\" as \"Contact_directPhone\",\"c\".\"jobTitle\" as \"Contact_jobTitle\",\"c\".\"jobLevel\" as \"Contact_jobLevel\",\"c\".\"jobDepartment\" as \"Contact_jobDepartment\",\"c\".\"nsId\" as \"Contact_nsId\",\"c\".\"zoomInfoContactId\" as \"Contact_zoomInfoContactId\",\"c\".\"linkedInUrl\" as \"Contact_linkedInUrl\",\"c\".\"screenshot\" as \"Contact_screenshot\",\"c\".\"handles\" as \"Contact_handles\",\"c\".\"website\" as \"Contact_website\",\"c\".\"comments\" as \"Contact_comments\",\"c\".\"source\" as \"Contact_source\",\"c\".\"stage\" as \"Contact_stage\",\"c\".\"functions\" as \"Contact_functions\",\"c\".\"disposition\" as \"Contact_disposition\",\"c\".\"zb\" as \"Contact_zb\",\"c\".\"gmailStatus\" as \"Contact_gmailStatus\",\"c\".\"mailTesterStatus\" as \"Contact_mailTesterStatus\",\"c\".\"createdAt\" as \"Contact_createdAt\",\"c\".\"updatedAt\" as \"Contact_updatedAt\",\"c\".\"AccountId\" as \"Contact_AccountId\",\"c\".\"createdBy\" as \"Contact_createdBy\",\"c\".\"updatedBy\" as \"Contact_updatedBy\",\"c\".\"emailDedupeKey\" as \"Contact_emailDedupeKey\",\"c\".\"phoneDedupeKey\" as \"Contact_phoneDedupeKey\",\"c\".\"companyDedupeKey\" as \"Contact_companyDedupeKey\",\"c\".\"label\" as \"Contact_label\",\"c\".\"gmailStatusDateAndTime\" as \"Contact_gmailStatusDateAndTime\",\"c\".\"zbDateAndTime\" as \"Contact_zbDateAndTime\",\"c\".\"phoneExtension\" as \"Contact_phoneExtension\",\"c\".\"duplicateOf\" as \"Contact_duplicateOf\",\"c\".\"complianceComments\" as \"Contact_complianceComments\",\"c\".\"deliveryStatus\" as \"Contact_deliveryStatus\",\"c\".\"mobile\" as \"Contact_mobile\",\"c\".\"emailNameDedupeKey\" as \"Contact_emailNameDedupeKey\",\"c\".\"emailDomainDedupeKey\" as \"Contact_emailDomainDedupeKey\",\"c\".\"ClientId\" as \"Contact_ClientId\",\"c\".\"ProjectId\" as \"Contact_ProjectId\",\"c\".\"mobileNumber1\" as \"Contact_mobileNumber1\",\"c\".\"mobileNumber2\" as \"Contact_mobileNumber2\",\"c\".\"homeNumber\" as \"Contact_homeNumber\",\"c\".\"homeAddressStreet1\" as \"Contact_homeAddressStreet1\",\"c\".\"homeAddressStreet2\" as \"Contact_homeAddressStreet2\",\"c\".\"homeAddressCity\" as \"Contact_homeAddressCity\",\"c\".\"homeAddressState\" as \"Contact_homeAddressState\",\"c\".\"homeAddressZipCode\" as \"Contact_homeAddressZipCode\",\"c\".\"homeAddressCountry\" as \"Contact_homeAddressCountry\" from \"Contacts\" as \"c\", json_to_record(\"address\") AS con_addr (\"street1\"  TEXT,\"street2\"  TEXT,\"city\" TEXT,\"state\" TEXT,\"country\" TEXT,\"zipCode\" TEXT) where \"c\".\"researchStatus\" in ('Q','qa','Qa','QA','QF','QR') order by \"c\".\"updatedAt\" DESC ) as \"co\" ) as con inner join \"Clients\" as \"cl\" on \"con\".\"Contact_ClientId\" = \"cl\".\"id\" left outer join ( Select \"a\".\"id\" as \"Account_id\",\"a\".\"name\" as \"Account_name\",\"a\".\"researchStatus\" as \"Account_researchStatus\",\"a\".\"callingStatus\" as \"Account_callingStatus\",\"a\".\"complianceStatus\" as \"Account_complianceStatus\",\"a\".\"stage\" as \"Account_stage\",\"a\".\"zoomInfoName\" as \"Account_zoomInfoName\",\"a\".\"domain\" as \"Account_domain\",\"a\".\"website\" as \"Account_website\",\"a\".\"description\" as \"Account_description\",\"a\".\"nsId\" as \"Account_nsId\",\"a\".\"zoomInfoContactId\" as \"Account_zoomInfoContactId\",\"a\".\"sicCode\" as \"Account_sicCode\",\"a\".\"naicsCode\" as \"Account_naicsCode\",\"a\".\"sicDescription\" as \"Account_sicDescription\",\"a\".\"naicsDescription\" as \"Account_naicsDescription\",\"a\".\"source\" as \"Account_source\",\"a\".\"employeeSourceLI\" as \"Account_employeeSourceLI\",\"a\".\"employeeSourceZ_plus\" as \"Account_employeeSourceZ_plus\",\"a\".\"phoneHQ\" as \"Account_phoneHQ\",\"a\".\"email\" as \"Account_email\",\"a\".\"industry\" as \"Account_industry\",\"a\".\"subIndustry\" as \"Account_subIndustry\",\"a\".\"locationLI\" as \"Account_locationLI\",addr.*,\"a\".\"linkedInUrl\" as \"Account_linkedInUrl\",\"a\".\"revenue\" as \"Account_revenue\",\"a\".\"revenue_M_B_K\" as \"Account_revenue_M_B_K\",\"a\".\"employeeSize\" as \"Account_employeeSize\",\"a\".\"employeeSizeLI\" as \"Account_employeeSizeLI\",\"a\".\"employeeSizeZ_plus\" as \"Account_employeeSizeZ_plus\",\"a\".\"employeeSizeFinalBucket\" as \"Account_employeeSizeFinalBucket\",\"a\".\"employeeSize_others\" as \"Account_employeeSize_others\",\"a\".\"employeeRangeLI\" as \"Account_employeeRangeLI\",\"a\".\"disposition\" as \"Account_disposition\",\"a\".\"comments\" as \"Account_comments\",\"a\".\"upperRevenue\" as \"Account_upperRevenue\",\"a\".\"lowerRevenue\" as \"Account_lowerRevenue\",\"a\".\"upperEmployeeSize\" as \"Account_upperEmployeeSize\",\"a\".\"lowerEmployeeSize\" as \"Account_lowerEmployeeSize\",\"a\".\"createdAt\" as \"Account_createdAt\",\"a\".\"updatedAt\" as \"Account_updatedAt\",\"a\".\"ProjectId\" as \"Account_ProjectId\",\"a\".\"createdBy\" as \"Account_createdBy\",\"a\".\"updatedBy\" as \"Account_updatedBy\",\"a\".\"aliasName\" as \"Account_aliasName\",\"a\".\"tokens\" as \"Account_tokens\",\"a\".\"scrubbedName\" as \"Account_scrubbedName\",\"a\".\"label\" as \"Account_label\",\"a\".\"segment_technology\" as \"Account_segment_technology\",\"a\".\"emailDomain\" as \"Account_emailDomain\",\"a\".\"duplicateOf\" as \"Account_duplicateOf\",\"a\".\"complianceComments\" as \"Account_complianceComments\",\"a\".\"deliveryStatus\" as \"Account_deliveryStatus\",\"a\".\"employeeSize_others_source\" as \"Account_employeeSize_others_source\",\"a\".\"qualifiedContacts\" as \"Account_qualifiedContacts\",\"a\".\"potential\" as \"Account_potential\",\"a\".\"finalDisposition\" as \"Account_finalDisposition\",\"a\".\"ClientId\" as \"Account_ClientId\",\"a\".\"parentDomain\" as \"Account_parentDomain\",\"a\".\"masterDisposition\" as \"Account_masterDisposition\",\"a\".\"masterUpdatedAt\" as \"Account_masterUpdatedAt\",\"a\".\"type\" as \"Account_type\",\"a\".\"masterComments\" as \"Account_masterComments\" from \"Accounts\" as \"a\", json_to_record(\"addressHQ\") as addr (\"address1HQ\" TEXT,\"address2HQ\" TEXT,\"cityHQ\" TEXT,\"stateHQ\" TEXT,\"countryHQ\" TEXT,\"zipCodeHQ\" TEXT) ) as acc on \"con\".\"Contact_AccountId\" = \"acc\".\"Account_id\"" \
--quote="22" \
--escape="5C" \
--fields-terminated-by='|'


--- Query

gcloud sql export csv beta-da-db-instance-21aec72f gs://da-local-files/userExport/all_contact_leadgen_29_JUN_2023.csv \
--async \
--database=da-db \
--offload \
--query="Select \"cl\".\"name\" as \"Client_Name\",\"cl\".\"pseudonym\" as \"Client_pseudonym\", \"p\".\"name\" as \"Project_Name\",\"p\".\"deliveryDate\" as \"Project_deliveryDate\",\"p\".\"createdAt\" as \"Project_CreatedAt\", \"a\".\"name\" as \"Account_Name\",\"a\".\"website\" as \"Account_WebSite\",\"a\".\"domain\" as \"Account_Domain\",\"c\".* from (Select DISTINCT ON (\"researchStatus\",\"email\",\"ClientId\",\"ProjectId\") concat(\"researchStatus\",'-',\"email\",'-',\"ClientId\",'-',\"ProjectId\") as \"unique\",\"id\",\"createdAt\",\"createdBy\",\"updatedAt\", \"updatedBy\", \"email\",\"deliveryStatus\", \"researchStatus\", \"callingStatus\", \"complianceStatus\", \"complianceComments\", \"prefix\", \"firstName\", \"middleName\", \"lastName\", addr.*, \"genericEmail\", \"phone\", \"directPhone\", \"jobTitle\", \"jobLevel\", \"jobDepartment\", \"nsId\", \"zoomInfoContactId\", \"linkedInUrl\", \"screenshot\", \"handles\", \"website\", \"comments\", \"source\", \"stage\", \"functions\", \"disposition\", \"zb\", \"gmailStatus\", \"mailTesterStatus\", \"custom1\", \"custom2\", \"custom3\", \"custom4\", \"custom5\", \"custom6\", \"custom7\", \"custom8\", \"custom9\", \"custom10\", \"custom11\", \"custom12\", \"custom13\", \"custom14\", \"custom15\", \"emailDedupeKey\", \"phoneDedupeKey\", \"companyDedupeKey\", \"label\", \"gmailStatusDateAndTime\", \"zbDateAndTime\", \"phoneExtension\", \"duplicateOf\", \"mobile\", \"emailNameDedupeKey\", \"emailDomainDedupeKey\", \"ClientId\", \"ProjectId\",\"AccountId\" FROM \"Contacts\" ,json_to_record(\"address\") AS addr (\"street1\"  TEXT,\"street2\"  TEXT,\"city\" TEXT,\"state\" TEXT,\"country\" TEXT,\"zipCode\" TEXT) ) as \"c\" left outer join \"Accounts\" as \"a\" on \"c\".\"AccountId\" = \"a\".\"id\" left outer join \"Projects\" as \"p\" on \"c\".\"ProjectId\" = \"p\".\"id\" left outer join \"Clients\" as \"cl\" on \"c\".\"ClientId\" = \"cl\".\"id\"" \
--quote="22" \
--escape="5C" \
--fields-terminated-by="2C"


-------------------------------------------------------------------------------------------------------------------------------------------------
--Create Job Error File


gcloud sql export csv beta-master-db-instance gs://da-temp-files/files/jobErrorReports/82c5a493-1c8f-48d5-bcbd-6949deeadf63_error_report.csv \
--async \
--database=da-db \
--offload \
--query="Select \"description\",\"rowContent\",\"rowCount\",\"type\",\"rowIndex\",\"chunkIndex\" from \"JobErrors\" where \"JobId\" = '82c5a493-1c8f-48d5-bcbd-6949deeadf63'" \
--quote="22" \
--escape="5C" \
--fields-terminated-by="2C"

-------------------------------------------------------------------------------------------------------------------------------------------------
--Master Duplicate Location

gcloud sql export csv beta-master-db-instance gs://da-temp-files/files/jobErrorReports/Master_Dupl_Loca.csv \
--async \
--database=da-db \
--offload \
--query="Select * from ( Select \"addressDedupeKey\",\"accountDomain\",count(*) over (partition by \"addressDedupeKey\") as \"addressDedupeKeyCount\",* from \"Locations\" ) as TT where \"addressDedupeKeyCount\" > 0;" \
--quote="22" \
--escape="5C" \
--fields-terminated-by="2C"

-------------------------------------------------------------------------------------------------------------------------------------------------
--Master All Account Data

gcloud sql export csv beta-master-db-instance gs://da-local-files/userExport/master_account_export_22_05_2023_1.csv \
--async \
--database=da-db \
--offload \
--query="Select \"a\".\"id\", \"a\".\"name\", \"a\".\"parentAccountName\", \"a\".\"website\", \"a\".\"domain\", \"a\".\"type\", \"a\".\"email\", \"a\".\"industry\", \"a\".\"subIndustry\", \"a\".\"sicCode\", \"a\".\"sicDescription\", \"a\".\"naicsCode\", \"a\".\"naicsDescription\", \"a\".\"employeeRange\", \"a\".\"employeeSize\", \"a\".\"employeeSizeLI\", \"a\".\"employeeSizeZPlus\", \"a\".\"employeeSizeOthers\", \"a\".\"revenue\", \"a\".\"revenueRange\", \"a\".\"totalFunding\", \"a\".\"duns\", \"l\".\"address1\", \"l\".\"address2\", \"l\".\"city\", \"l\".\"state\", \"l\".\"country\", \"l\".\"zipCode\", \"l\".\"region\", \"l\".\"phone1\" from \"Accounts\" as \"a\" inner join \"Locations\" as \"l\" on \"a\".\"domain\" = \"l\".\"AccountDomain\" Where \"a\".\"industry\" is not null and \"a\".\"employeeRange\" is not null and \"a\".\"revenueRange\" is not null limit 800000" \
--quote="22" \
--escape="5C" \
--fields-terminated-by="2C"


-------------------------------------------------------------------------------------------------------------------------------------------------
--Master All Account Data

gcloud sql export csv beta-master-db-instance gs://da-local-files/userExport/account_domain_export_missing.csv \
--async \
--database=da-db \
--offload \
--query="Select \"id\",\"name\",\"domain\",\"industry\",\"subIndustry\",\"employeeSize\",\"revenue\",\"tags\" from \"Accounts\"" \
--quote="22" \
--escape="5C" \
--fields-terminated-by="2C"



dev-master-db-instance


gcloud sql export csv dev-master-db-instance gs://da-local-files/userExport/account_domain_export_missing.csv \
--async \
--database=da-db \
--offload \
--query="Select \"id\",\"name\",\"domain\",\"industry\",\"subIndustry\",\"employeeSize\",\"revenue\",\"tags\" from \"Accounts\"" \
--quote="22" \
--escape="5C" \
--fields-terminated-by="2C"