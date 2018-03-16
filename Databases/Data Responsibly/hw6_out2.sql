julia=> select * from Q;
 supp | conf 
------+------
  500 | 0.55
(1 row)

julia=> select * from R3;
  attr1   | val1 |  attr2   | val2 |  attr3  | val3 | supp |       conf        
----------+------+----------+------+---------+------+------+-------------------
 age      |   20 | gender   |    0 | vdecile |    2 |  832 | 0.827860696517413
 age      |   30 | gender   |    0 | vdecile |    1 | 1109 |  0.61135611907387
 gender   |    0 | marriage |    1 | vdecile |    1 | 2159 | 0.564002089864159
 age      |   30 | race     |    1 | vdecile |    1 |  866 | 0.581989247311828
 age      |   20 | race     |    1 | vdecile |    2 |  726 | 0.830663615560641
 age      |   50 | gender   |    0 | vdecile |    1 |  554 | 0.899350649350649
 age      |   30 | marriage |    1 | vdecile |    1 | 1244 | 0.633078880407125
 age      |   20 | marriage |    1 | vdecile |    2 |  975 | 0.813856427378965
 gender   |    0 | race     |    2 | vdecile |    1 | 1379 |  0.76398891966759
 age      |   40 | gender   |    0 | vdecile |    1 |  680 |   0.7981220657277
 age      |   30 | race     |    2 | vdecile |    1 |  591 | 0.772549019607843
 age      |   40 | marriage |    1 | vdecile |    1 |  630 | 0.800508259212198
 gender   |    1 | marriage |    1 | vdecile |    1 |  624 | 0.698768197088466
 marriage |    1 | race     |    2 | vdecile |    1 | 1265 | 0.732908458864426
(14 rows)

julia=> select * from Impact_Ratio;
 attr1 | val1 |  attr2  | val2 |      ratio       
-------+------+---------+------+------------------
 age   |   30 | vdecile |    1 | 1.46531302876481
(1 row)

julia=> select * from Elift_Ratio;
 attr1 | val1 | attr2 | val2 |  attr3  | val3 |       ratio       
-------+------+-------+------+---------+------+-------------------
 age   |   30 | race  |    1 | vdecile |    1 | 0.594371997254633
(1 row)

