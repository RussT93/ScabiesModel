
### Scabies model parameters

### default

BaseParameters = list(
  beta=1.535567,
  b = 1/4,#1/14,
  d = 1/20, #1/20,
  e = 0.532, #TBC
  f = 1/7,
  g = 0.395,#Proportion of cases receiving 2 courses of treatment
  h = 1/7,
  efficacy1d=0.3, 
  efficacy2d=0.95,
  lag=31, 
  seasonal_forcing=0.20, 
  householdsize=3
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

#TODO check
init= c(
  S=5.995653e+07, 
  P=3*1.400602e+03,
  E=3625.284, 
  I=1.366546e+03, 
  T1d=1.400602e+03, 
  T2d=5.655500e+02, 
  rI=1.290141e+03
)
