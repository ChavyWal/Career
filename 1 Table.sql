use Careerdb
go
Drop table if exists dbo.career
go
create table dbo.career(
careerId int not null identity primary key, 
FirstName Varchar (20) not null constraint ck_First_name_cannot_be_blank CHECK(Firstname <> ''),
LastName varchar (20) not null constraint ck_Last_name_cannot_be_blank check(lastname <> ''),
Dateofbirth date not null ,
Gender char (1) not null constraint ck_Gender_can_only_be_M_for_male_and_F_for_female check(Gender in ('F','M')),
Phonenumber char (12) not null constraint ck_Phone_number_can_only_be_numbers check(Phonenumber like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
    constraint u_Phone_number_Has_to_be_unique unique,
EmailAddress Varchar (45) not null constraint ck_Email_address_cannot_be_blank check(Emailaddress <> '') 
    constraint u_EmailAddress_Has_to_be_unique unique,
Cluster1 varchar (50) not null 
    constraint ck_cluster_1_can_only_be_one_of_the_sixteen_clusters check(Cluster1 in ( 
    'Agriculture, Food & Natural Resources', 'Architecture & Construction', 'Arts, Audio/Visual Technology & Communications', 'Business Management & Administration', 'Education & Training',
    'Finance ', 'Government & Public Administration ', 'Health Science', 'Hospitality & Tourism', 'Human Services', 'Information Technology', 'Law, Public Safety, Corrections & Security',
    'Manufacturing ', 'Marketing', 'Science, Technology, Engineering & Math', 'Transportation, Distribution & Logistics')) ,
Score1 int not null constraint ck_Score_1_can_only_be_from_1_to_20 check(score1 between 1 and 20),
Cluster2 varchar (50) not null     
    constraint ck_cluster_2_can_only_be_one_of_the_sixteen_clusters check(Cluster2 in ( 
    'Agriculture, Food & Natural Resources', 'Architecture & Construction', 'Arts, Audio/Visual Technology & Communications', 'Business Management & Administration', 'Education & Training',
    'Finance ', 'Government & Public Administration ', 'Health Science', 'Hospitality & Tourism', 'Human Services', 'Information Technology', 'Law, Public Safety, Corrections & Security',
    'Manufacturing ', 'Marketing', 'Science, Technology, Engineering & Math', 'Transportation, Distribution & Logistics')) ,
Score2 int not null constraint ck_Score_2_can_only_be_from_1_to_20 check(score2 between 1 and 20), 
Cluster3  varchar (50) not null    ,
     constraint ck_cluster_3_can_only_be_one_of_the_sixteen_clusters check(Cluster3 in ( 
     'Agriculture, Food & Natural Resources', 'Architecture & Construction', 'Arts, Audio/Visual Technology & Communications', 'Business Management & Administration', 'Education & Training',
     'Finance ', 'Government & Public Administration ', 'Health Science', 'Hospitality & Tourism', 'Human Services', 'Information Technology', 'Law, Public Safety, Corrections & Security',
     'Manufacturing ', 'Marketing', 'Science, Technology, Engineering & Math', 'Transportation, Distribution & Logistics')) ,
score3 int not null constraint ck_Score_3_can_only_be_from_1_to_20 check(score3 between 1 and 20), 
DateFirstConsultation Date not null constraint ck_Date_first_consultation_cannot_be_before_September_9th_2019 check(DateFirstConsultation >= '2019-09-09' ),
    constraint ck_DateFirstConsultation_cannot_be_future_date check( DateFirstConsultation <= getdate()),
Seekingjob bit not null,
DateFoundJob Date null constraint ck_Date_found_job_cannot_be_future_date check(getdate() >= DateFoundJob),
CurrentOccupation varchar (30) null constraint ck_Current_ocupation_cannot_be_blank check(CurrentOccupation <> ''),
CurrentOccupationCluster VARCHAR (50) null    
     constraint ck_Currrent_occupation_cluster_can_only_be_one_of_the_sixteen_clusters check(CurrentOccupationCluster in ( 
    'Agriculture, Food & Natural Resources', 'Architecture & Construction', 'Arts, Audio/Visual Technology & Communications', 'Business Management & Administration', 'Education & Training',
    'Finance ', 'Government & Public Administration ', 'Health Science', 'Hospitality & Tourism', 'Human Services', 'Information Technology', 'Law, Public Safety, Corrections & Security',
    'Manufacturing ', 'Marketing', 'Science, Technology, Engineering & Math', 'Transportation, Distribution & Logistics')) ,
    constraint ck_Date_found_job_cannot_be_before_date_first_consultation check( Datefoundjob >= DateFirstConsultation),
    constraint ck_Date_of_birth_should_be_at_least_18_years_before_Date_first_consultation check(datediff(year, Dateofbirth, DateFirstConsultation) >= 18),
    constraint ck_score_1_2_and_3_should_be_in_a_descending_order check((score1 >= score2) and (score2 >= score3)),
    constraint ck_cluster1_2_and_3_cannot_be_the_same check((cluster2 not in (cluster1, cluster3))and (cluster1 not in (cluster2,cluster3))),
    constraint ck_if_current_occupation_is_null_then_current_occupation_cluster_is_null_too_and_vise_versa 
         check((CurrentOccupation is null and CurrentOccupationCluster is null) or (CurrentOccupation is not null and CurrentOccupationCluster is not null)),
    CONSTRAINT ck_either_seeking_job_is_1_and_Date_found_job_is_null_or_seeking_job_0_and_datefound_job_can_be_both
        check((seekingjob = 1 and Datefoundjob is null) or (seekingjob = 0 and Datefoundjob is null) or (seekingjob = 0 and DateFoundJob is not null))
)



