/* Gregory Matthews
	CS 500: HW3 - Part 2
	2/11/18
*/

-- (a.)
select C.name as country, count(Y_R_F.year) as num_years
from Tennis_Players T_P, Years_Ranked_First Y_R_F, Countries C
where T_P.name = Y_R_F.name
and T_P.country = C.name
group by C.name;

-- (b.)
select TP1.name as player1, TP2.name as player2
from Tennis_Players TP1, Tennis_Players TP2, Countries C1,Countries C2
where TP1.country = C1.name
and TP2.country = C2.name
and TP1.ATP_rank < TP2.ATP_rank
and C1.population > C2.population;

-- (c.)
select TP1.name as player1, TP2.name as player2, C.name as country
from Tennis_Players TP1, Tennis_Players TP2, Countries C
and TP1.country = C.name
where TP1.name > TP2.name
and TP2.country = C.name;

-- (d.)
select C.name as country, C.gdp, AVG(TP.age) as avg_age
from Countries C, Tennis_Players TP
where TP.country = C.name
group by C.name, gdp
having count(*) > 1;

-- (e.)
select C.name as country, C.gdp, population, MIN(TP.age) as min_age
from Countries C, Tennis_Players TP
where TP.country = C.name
group by C.name, C.gdp;

-- (f.)
select C.name 
from Countries C, Years_Ranked_First YRF, Tennis_Players TP
where C.name = TP.country
and TP.name = YRF.name
and YRF.year <= 2010 and YRF.year >= 2004
INTERSECT
select C.name 
from Countries C, Years_Ranked_First YRF, Tennis_Players TP
where C.name = TP.country
and TP.name = YRF.name
and YRF.year >= 2010 and YRF.year <=2015;

