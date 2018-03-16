/* Gregory Matthews
	CS 500: HW3 - Part 1
	2/11/18
*/

-- (a.)
 select job, grade, candidate, count(*) as cnt
 from Candidates_Skills C_S, Jobs_Skills J_S 
 where J_S.skill = C_S.skill
 group by job, grade, candidate
 having count(*) > 1;
 
-- (b.)
 select job, grade, company, candidate, 
 P.salary as salary, C.salary as candidate_salary
 from Candidates C, Positions P
 where C.salary < P.salary
 order by C.salary;

 -- (c.) 
 select distinct skill, years
 from Jobs_Skills J_S
 EXCEPT 
 select distinct J_S.skill, J_S.years
 from Candidates_Skills C_S, Jobs_Skills J_S
 where C_S.years >= J_S.years
 and C_S.skill = J_S.skill;
 
 -- (d.)
 select skill, MAX(years) as max_years, 
 round(AVG(years),1) as avg_years, count(*) as cnt
 from Candidates_Skills C_S
 group by skill;

 -- (e.)
 select C_1.candidate as candidate1, C_2.candidate as candidate2
 from Candidates as C_1, Candidates as C_2,
 Candidates_Skills as C_11, Candidates_Skills as C_12, 
 Candidates_Skills as C_21, Candidates_Skills as C_22
 where C_1.candidate = C_11.candidate
 and C_1.candidate = C_12.candidate
 and C_2.candidate = C_21.candidate
 and C_2.candidate = C_22.candidate
 and C_11.skill = 'Java' and C_12.skill = 'DB'
 and C_21.skill = 'Java' and C_22.skill = 'DB'
 and C_11.years + C_12.years > C_21.years + C_22.years
 and C_1.salary < C_2.salary;
 
 -- (f.)
select C_1.candidate as candidate1, C_2.candidate as candidate2
from Candidates_Skills as C_1, Candidates_Skills as C_2
where C_1.candidate > C_2.candidate
and C_1.skill = 'DB' and C_2.skill = 'DB'
and C_1.years >= 3 and C_2.years >= 3;



