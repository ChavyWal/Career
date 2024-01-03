
/*1: Show me a list of all clients who have already found a job. Show me the ones who have found a job the fastest (starting from their first consultation) on top. This will give us an overall glimpse of our success rate. 
This can also include people that are still working, but are already seeking a new job. Include a column with the number of days it took them to start working.
The results set should include the following columns in the following order: first name, last name, gender, date started working, current occupation, Number of days until started working*/

select c.FirstName, c.LastName, c.Gender, c.DateFoundJob, c.CurrentOccupation, numberofdaystillfoundjob = DATEDIFF(DAY, c.DateFirstConsultation, c.DateFoundJob)
from career c 
where c.DateFoundJob is not null 
order by numberofdaystillfoundjob

/* 2: We are currently researching whether there are certain areas in which males are stronger than females, and vise versa. Show me a list of the number of females and males per career cluster of their current occupation.
We don't want to research in which areas they score different on the actual test, but the difference of the actual jobs they land in. This should only include clients that have stated working already. 
If any of the career clusters have both, male and female, make sure that they are one after the other, this way we can clearly see the comparison. 
The results set should include the amount of m/f per cluster of current occupation, gender, and career cluster of current occupation. */

select c.CurrentOccupationCluster, c.Gender , amountpergender =  count(*)
from career C 
where c.DateFoundJob is not null
group by c.gender, c.CurrentOccupationCluster
order by c.CurrentOccupationCluster 

-- 3: We want to know the average min and max days from the client's first consultation until they found a job. Include only the ones who have started working already.
select Averagedaystillfoundjob =  AVG(DATEDIFF(day, c.DateFirstConsultation, c.DateFoundJob)), 
    maxdaystillfoundjob = MAX(DATEDIFF(day, c.DateFirstConsultation, c.DateFoundJob)) , 
    mindaystillfoundjob = MIN(DATEDIFF(day, c.DateFirstConsultation, c.DateFoundJob))
from career c 
where c.datefoundjob is not null 

-- 4: We need a list of clients that are seeking jobs. We need all columns as part of this list, because we will use this list when working on referring them to different places.
select * 
from career c 
where c.SeekingJob = 1 

/*5: Sometimes, for printing we like to have a table with the minimal number of columns. for this report you need to show all information, with certain formatting so that there are less columns. 
First and last name should be shown in one column in the following syntax: "last name, first name".
Each career cluster and its score should be shown together in one column, separated with a dash.
Their Phone Number and email address can also be combined separated with a comma.*/

select fullname = CONCAT(c.lastname, ', ', c.Firstname), clusterscore1 = CONCAT(c.cluster1, ' - ', score1), clusterscore2 = concat(c.cluster2, ' - ', score2), 
clusterscore3 = concat(c.cluster3, ' - ', score3), contactinfo = concat(c.phonenumber, ', ', c.Emailaddress),c.Seekingjob, c.Gender, c.Dateofbirth,
 c.DateFoundJob, c.DateFirstConsultation, c.CurrentOccupationCluster, c.CurrentOccupation, c.careerId
from career c