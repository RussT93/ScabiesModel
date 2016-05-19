source("InitScabies.R")
## Test the impact of a on Beta


newparam = list(
  beta=1.1,
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
  seasonal_forcing=0.80
)

out <- as.data.frame(lsoda(y = init, times = times, func = scabiesSEITS, parms = newparam))
 
legend("topleft", c("Infected (model)", "Infected (Oral)", "Infected (Topical)"), pch = 1, col = 1:3)
matplot(times, cbind(SmIncid.O[starttraintime:maxtraintime], SmIncid.T[starttraintime:maxtraintime]), ylim=c(0,6000), type = "l", xlab = "Weeks 2008-2012", ylab = "Infected", main = "SEIRS Model with forced seasonality", lwd = 1, lty = 1, bty = "l", col = 2:4)

lines(times, out$I, type="l", xlab="proportion of unidentified exposed", ylab="infectivity")
