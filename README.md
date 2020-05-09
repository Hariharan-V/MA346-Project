# MA346-Project
Linear Regression
# Data
A Tsanas, MA Little, PE McSharry, LO Ramig (2009)
'Accurate telemonitoring of Parkinson.s disease progression by non-invasive 
speech tests',
IEEE Transactions on Biomedical Engineering (to appear).

Sample output:

```bash
>> run('Code/EfficiencyTester.m')

ans =

  1×5 table

      MAE       MSE       RMSE      R_sq      R_sq_adj
    _______    ______    ______    _______    ________

    0.12065    85.523    9.2479    0.25292    0.25037 


ans =

  1×5 table

      MAE       MSE       RMSE      R_sq      R_sq_adj
    _______    ______    ______    _______    ________

    0.12066    85.539    9.2487    0.25278    0.25023 


ans =

  1×5 table

      MAE       MSE      RMSE      R_sq      R_sq_adj
    _______    _____    ______    _______    ________

    0.12066    85.53    9.2482    0.25286    0.25031 


ans =

  1×5 table

      MAE       MSE      RMSE      R_sq      R_sq_adj
    _______    ______    _____    _______    ________

    0.12386    90.136    9.494    0.21262    0.20993 


mdl = 


Linear regression model:
    y ~ 1 + x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9 + x10 + x11 + x12 + x13 + x14 + x15 + x16 + x17 + x18 + x19 + x20

Estimated Coefficients:
                   Estimate       SE         tStat        pValue   
                   ________    _________    ________    ___________

    (Intercept)        35.1       3.0572      11.481      3.446e-30
    x1               0.2636     0.010775      24.464    6.2546e-126
    x2              0.31867     0.014363      22.186    8.7419e-105
    x3               -4.812      0.31257     -15.395     1.8608e-52
    x4              0.01594    0.0022738      7.0103     2.6465e-12
    x5              -255.55       203.16     -1.2579        0.20848
    x6               -44609       9447.5     -4.7218      2.392e-06
    x7               -26030        44530    -0.58455        0.55887
    x8              -166.92       180.52    -0.92464        0.35519
    x9               9062.4        14844     0.61049        0.54156
    x10              14.126       61.868     0.22833         0.8194
    x11            -0.58858       4.6154    -0.12753        0.89853
    x12              -14998        44727    -0.33532        0.73739
    x13              49.607       52.793     0.93965        0.34744
    x14              9.7274       23.711     0.41025        0.68164
    x15              4949.3        14909     0.33197        0.73992
    x16             -23.717       5.9443     -3.9899     6.6903e-05
    x17            -0.48577      0.06584     -7.3781     1.8297e-13
    x18              1.6927       1.7377     0.97413        0.33003
    x19              -36.34       2.2067     -16.468     1.3424e-59
    x20              15.485       2.7851      5.5601      2.815e-08


Number of observations: 5875, Error degrees of freedom: 5854
Root Mean Squared Error: 9.26
R-squared: 0.253,  Adjusted R-Squared: 0.25
F-statistic vs. constant model: 99.1, p-value = 0```
