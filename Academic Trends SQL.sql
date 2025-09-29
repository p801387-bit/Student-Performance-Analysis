Create Database academic_trends;
use academic_trends;

--- KPI 1
Select round(avg(exam_score),2) as Avg_exam_score from student_exam_scores;

--- KPI 2
Select round(count(case when exam_score>=50 then 1 end)/count(*)*100,2)
 as Pass_percentage from student_exam_scores;
 
 --- KPI 3
 With brilliant as (Select student_id, exam_score, row_number() over (order by exam_score desc) 
 as awesome, count(*) over () as total_students from student_exam_scores)
 Select round(avg(exam_score),2) as Top_10_avg from brilliant where awesome <= total_students * 0.10;
 
 --- KPI 4
 Select round(avg(hours_studied),2) as Avg_study_hours from student_exam_scores;
 
 --- KPI 5
 Select round(
    (count(*) * sum(hours_studied * exam_score) - sum(hours_studied) * sum(exam_score)) /
    (sqrt((count(*) * sum(hours_studied * hours_studied) - sum(hours_studied) * sum(hours_studied)) *
	(count(*) * sum(exam_score * exam_score) - sum(exam_score) * sum(exam_score)))), 2) 
    as correlation_study_exam from student_exam_scores;
    
--- KPI 6
Select case when sleep_hours < 6 then '<6'
when sleep_hours between 6 and 8 then '6-8' else '8' end as Sleep_bracket,
round(avg(exam_score),2) as avg_exam_score from student_exam_scores group by sleep_bracket order by sleep_bracket desc;

--- KPI 7
Select round(avg(attendance_percent),2) as Avg_attendance_percent from student_exam_scores;

--- KPI 8
Select round(count(case when attendance_percent > 90 then 1 end),2) as Students_with_90_percent_attendance from student_exam_scores;

--- KPI 9 
Select case when attendance_percent < 70 then '<70'
when attendance_percent between 70 and 90 then '70-90' else '90' end as Attendance_bracket,
round(avg(exam_score),2) as avgg_exam_score from student_exam_scores group by Attendance_bracket order by Attendance_bracket desc;

--- KPI 10
Select round((count(case when attendance_percent < 70 then 1 end) * 100.0)/count(*),2) as Low_attendance, 
round((count(case when exam_score < 50 then 1 end) * 100.0)/count(*),2) as Low_score from student_exam_scores;