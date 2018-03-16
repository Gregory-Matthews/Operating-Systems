julia=> select * from Q;
 supp | conf 
------+------
  400 |  0.4
(1 row)

julia=> select * from R3;
  attr1   | val1 |  attr2   | val2 |  attr3  | val3 | supp |       conf        
----------+------+----------+------+---------+------+------+-------------------
 age      |   40 | race     |    2 | vdecile |    1 |  449 | 0.931535269709544
 gender   |    1 | race     |    2 | vdecile |    1 |  451 |  0.83210332103321
 age      |   20 | gender   |    0 | vdecile |    2 |  832 | 0.827860696517413
 marriage |    1 | race     |    1 | vdecile |    1 | 1518 | 0.506844741235392
 marriage |    1 | race     |    1 | vdecile |    2 | 1477 | 0.493155258764608
 age      |   50 | marriage |    1 | vdecile |    1 |  435 | 0.882352941176471
 age      |   30 | gender   |    0 | vdecile |    1 | 1109 |  0.61135611907387
 gender   |    0 | race     |    1 | vdecile |    2 | 1380 | 0.474389824682021
 gender   |    0 | race     |    1 | vdecile |    1 | 1529 | 0.525610175317979
 gender   |    0 | marriage |    1 | vdecile |    2 | 1669 | 0.435997910135841
 gender   |    0 | marriage |    1 | vdecile |    1 | 2159 | 0.564002089864159
 age      |   30 | race     |    1 | vdecile |    1 |  866 | 0.581989247311828
 age      |   30 | race     |    1 | vdecile |    2 |  622 | 0.418010752688172
 age      |   20 | race     |    1 | vdecile |    2 |  726 | 0.830663615560641
 age      |   50 | gender   |    0 | vdecile |    1 |  554 | 0.899350649350649
 age      |   30 | marriage |    1 | vdecile |    1 | 1244 | 0.633078880407125
 age      |   20 | marriage |    1 | vdecile |    2 |  975 | 0.813856427378965
 gender   |    0 | race     |    2 | vdecile |    1 | 1379 |  0.76398891966759
 age      |   40 | gender   |    0 | vdecile |    1 |  680 |   0.7981220657277
 age      |   30 | race     |    2 | vdecile |    1 |  591 | 0.772549019607843
 age      |   40 | marriage |    1 | vdecile |    1 |  630 | 0.800508259212198
 gender   |    1 | marriage |    1 | vdecile |    1 |  624 | 0.698768197088466
 age      |   40 | race     |    1 | vdecile |    1 |  450 | 0.746268656716418
 gender   |    1 | race     |    1 | vdecile |    1 |  420 | 0.678513731825525
 marriage |    1 | race     |    2 | vdecile |    1 | 1265 | 0.732908458864426
 age      |   50 | race     |    2 | vdecile |    1 |  406 | 0.948598130841122
(26 rows)

julia=> select * from Impact_Ratio;
  attr1   | val1 |  attr2  | val2 |       ratio       
----------+------+---------+------+-------------------
 age      |   30 | vdecile |    1 |  1.46531302876481
 age      |   40 | vdecile |    1 |   1.0022271714922
 marriage |    1 | vdecile |    1 |               1.2
 gender   |    0 | vdecile |    1 |  1.10877447425671
 gender   |    1 | vdecile |    1 | 0.931263858093126
(5 rows)

julia=> select * from Elift_Ratio;
  attr1   | val1 | attr2 | val2 |  attr3  | val3 |       ratio       
----------+------+-------+------+---------+------+-------------------
 age      |   30 | race  |    1 | vdecile |    1 | 0.594371997254633
 age      |   40 | race  |    1 | vdecile |    1 |  0.50055617352614
 gender   |    0 | race  |    1 | vdecile |    1 | 0.525790921595598
 gender   |    1 | race  |    1 | vdecile |    1 | 0.482204362801378
 marriage |    1 | race  |    1 | vdecile |    1 | 0.545454545454545
(5 rows)

