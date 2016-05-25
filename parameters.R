
### Scabies model parameters


## General parameters
Population=60*10^6

starttime=1
maxtime=341
starttraintime=10
maxtraintime=250
times <- seq(starttraintime, maxtraintime, by = 1)

## Data loading
timeSeries<-read.table("Donnees_GALE_July122013.csv",header=TRUE,sep=",")
Incid.O=as.ts(timeSeries$Cases.O[starttime:maxtime])
Incid.T=as.ts(timeSeries$Cases.T[starttime:maxtime])

ma <- function(x,n=5) {filter(x,rep(1/n,n), sides=2)}

SmIncid.O=ma(Incid.O,n=9)
SmIncid.T=ma(Incid.T,n=9)


### default

DefaultParameters = list(
  beta=0.06643618,
  b = 1/4,#1/4 days, from rI to T1d,
  d = 1/20, #1/20,rate of progression from exposed to infectious 10+ mites, ~20 d
  e = 0.532, #TBC prophylaxis proportion
  f = 1/7, # time before first treatment, from I to T1d
  g = 0.395,#Proportion of cases receiving 2 courses of treatment
  h = 1/7, # duration of one treatment round
  h_proph = 1/7, # duration of one treatment round
  efficacy1d=0.3, # efficacy of one course of treatment
  efficacy2d=0.95, # efficacy of second course of treatment
  lag=16, # 
  seasonal_forcing=0.39810316, # 
  householdsize=2.57001460 # HH of 4, so 3 contacts
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

DefaultInit=c(
  S=59961355, 
  P=2819.153,
  E=23567.07, 
  I=5982.764, 
  T1d=13180.91, 
  T2d=4883.224, 
  rI=3211.403
)
# DefaultInit=c(
#   S=5.995653e+07, 
#   P=3*1.400602e+03,
#   E=3625.284, 
#   I=1.366546e+03, 
#   T1d=1.400602e+03, 
#   T2d=5.655500e+02, 
#   rI=1.290141e+03
# )
