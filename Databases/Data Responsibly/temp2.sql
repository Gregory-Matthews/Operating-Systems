delete from Q;
delete from F1;
delete from F2;
delete from F3;
delete from C2;
delete from C3;
delete from R2;
delete from R3;
delete from Impact_Ratio;
delete from Elift_Ratio;

-- insert into Q (supp, conf) values (500, 0.55);
-- insert into Q (supp, conf) values (600, 0.7);
insert into Q (supp, conf) values (400, 0.4);    
-- insert into Q (supp, conf) values (450, 0.6);    

insert into F1 (attr, val, supp) 
  ( select attr, val, count(*) as supp
    from Pro_Publica
    group by attr, val
    having count(*) >= (select supp from Q));

insert into C2 (attr1, val1, attr2, val2)
  ( select A.attr, A.val, B.attr, B.val
    from F1 A, F1 B
    where A.attr < B.attr);

insert into F2 (attr1, val1, attr2, val2, supp)
  ( select  C2.attr1, C2.val1, C2.attr2, C2.val2, count(*) as supp
      from  C2, Pro_Publica T1, Pro_Publica T2 
     where  C2.attr1 = T1.attr and C2.val1 = T1.val
       and  C2.attr2 = T2.attr and C2.val2 = T2.val
       and  T1.uid = T2.uid 
  group by C2.attr1, C2.val1, C2.attr2, C2.val2
    having count(*) >= (select supp from Q));

insert into R2 (attr1, val1, attr2, val2, supp, conf) 
  (select F2.attr1, F2.val1, F2.attr2, F2.val2, F2.supp, (F2.supp/F1.supp) as conf
   from   F2, F1 
   where  F2.attr1 = F1.attr and F2.val1 = F1.val
   and    F2.attr2 = 'vdecile'
   and    F2.supp / F1.supp >= (select conf from Q)
  );

-- YOUR CODE GOES HERE

-- ALLOWED:
-- all valid SQL queries are fine here: insert, delete, update
-- you may create additional helper tables if you like

-- NOT ALLOWED:
-- you may NOT use any procedural code: no for loops and the like are allowed

-- OUTPUT MUST GO INTO THESE RELATIONS, DON'T CHANGE THEIR SCHEMAS:

-- PART 1: 
insert into C3 (attr1, val1, attr2, val2, attr3, val3)
  ( select A.attr, A.val, B.attr, B.val, C.attr, C.val
    from F1 A, F1 B, F1 C
    where A.attr < B.attr
	and B.attr < C.attr
	);

insert into F3 (attr1, val1, attr2, val2, attr3, val3, supp)
  ( select  C3.attr1, C3.val1, C3.attr2, C3.val2, C3.attr3, C3.val3,  count(*) as supp
      from  C3, Pro_Publica T1, Pro_Publica T2, Pro_Publica T3 
     where  C3.attr1 = T1.attr and C3.val1 = T1.val
       and  C3.attr2 = T2.attr and C3.val2 = T2.val
	   and C3.attr3 = T3.attr and C3.val3 = T3.val
       and  T1.uid = T2.uid 
	   and T2.uid = T3.uid
  group by C3.attr1, C3.val1, C3.attr2, C3.val2, C3.attr3, C3.val3
    having count(*) >= (select supp from Q));
	
insert into R3 (attr1, val1, attr2, val2, attr3, val3, supp, conf) 
  (select F3.attr1, F3.val1, F3.attr2, F3.val2, F3.attr3, F3.val3, F3.supp, (F3.supp/F2.supp) as conf
   from   F3, F2 
   where  F3.attr1 = F2.attr1 and F3.val1 = F2.val1
   and F3.attr2 = F2.attr2 and F3.val2 = F2.val2
   and    F3.attr3 = 'vdecile'
   and    F3.supp / F2.supp >= (select conf from Q)
  );
	

-- PART 2: ImpactRatio (X => C) = support(S+ X => C) / support (S- X => C)
insert into Impact_Ratio (attr1, val1, attr2, val2, ratio)
	(select R2.attr1, R2.val1, R2.attr2, R2.val2, (pos.supp/neg.supp) as ratio
	from R2, F3 as pos, F3 as neg
	where R2.attr1 != 'vdecile' and R2.attr1 != 'race'
	and R2.attr2 = 'vdecile' and R2.val2 = 1
	
	and pos.attr2 = 'race' and pos.val2 = 1
	and neg.attr2 = 'race' and neg.val2 = 2
	
	and R2.attr2 = pos.attr3
	and R2.attr2 = neg.attr3
	and R2.val2 = pos.val3
	and R2.val2 = neg.val3
	
	and R2.attr1 = pos.attr1
	and R2.attr1 = neg.attr1
	and R2.val1 = pos.val1
	and R2.val1= neg.val1

	--and R2.val1 = neg.val1
	
	--and R2.attr2 = pos.attr3
	--and R2.attr2 = neg.attr3
	--and R2.val2 = pos.val3
	--and R2.val2 = neg.val3
	and R2.supp >=  (select conf from Q)
);

-- insert into Impact_Ratio (attr1, val1, attr2, val2, ratio)
-- (...);
-- NOTE: attr1 and val1 are for the regular attribute (X), attr2 and val2 are for 
-- the outcome attribute (C)



-- PART 3: EliftRatio (S+ X => C) = support(S+ X => C) / support (X => C)
-- insert into Elift_Ratio (attr1, val1, attr2, val2, attr3, val3, ratio)
-- (...);
-- NOTE: attr1/val1 and attr2/val2 are lexicographically ordered, as in R3
--       attr3/val3 is for the outcome attribute (C)
