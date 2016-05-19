
### Scabies model parameters

### default

BaseParameters = list(
  beta=1.535567,
  a = 0.5,
  b = 1/2,#1/14,
  d = 1/2, #1/20,
  e = 0.532, #TBC
  f = 1,
  g = 0.395,#Proportion of cases receiving
  h = 0.395,
  i = 1,#1/7,
  j = 0.3,
  k = 7/4,
  eff1=0.3, 
  eff2=0.95,
  lag=31, 
  seasonal_forcing=0.20
)
parametersLaw = list(
  a = 0,
  b = 0,
  d = 0,
  e = 0,
  f = 0,
  g = 0,
  h = 0,
  i = 0,
  j = 0
)

init= list(
  S=5.995653e+07, 
  Eu=1.812642e+03, 
  Ec=1.812642e+03, 
  I=1.366546e+03, 
  T1d=1.400602e+03, 
  T2d=5.655500e+02, 
  rI=1.290141e+03
)
