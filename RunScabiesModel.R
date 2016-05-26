source("SEITS_scabies.R")




#newinit<-c(S=1-Incid.O[1], I=Incid.O[1])

matplot(times, (SmIncid.T[starttraintime:maxtraintime]+SmIncid.O[starttraintime:maxtraintime])/2, 
        type = "l", xlab = "semaines", ylab = "Nombre de cas de gale par semaine", 
        main = "Evolution du nombre de cas de gale par semaine en France (2007-2012)", 
        lwd = 1, lty = 1, bty = "l", col = 2)
#legend("topleft", c("Infected (model)", "Infected (Oral)", "Infected (Topical)"), pch = 1, col = 1:3)


scabies(doPlot=T)


# SFun = sensFun(func=scabiesCost,pars)
# plot(SFun)
# pairs(SFun)
# ident=collin(SFun)
# ident
# plot(ident)
# #collin(SFun, N=12)
# scabMod2 = function(lpars){
#   scabiesCost(c(exp(lpars)))
# }


#out <- as.data.frame(lsoda(y = myinit, times = times, func = scabiesSEITS, parms = c(coef(Fit), BaseParameters)))


#plot(Fit)





#var0=Fit$var_ms_unweighted
#cov0=summary(Fit)$cov.scaled
#MCMC = modMCMC(f=scabiesCost, p=Fit$par, niter=5000, jump=cov0, var0=var0, wvar0=0.1, updatecov=50)

#sR = sensRange(func=scabies, parms=pars, parInput=MCMC$par, sensvar="I", num=1000)

#res<-optim(c(1.4247, 0.14286, 0.1428, 1, 0), fit, gr=NULL, sis, Incid.O)
# res<-nlminb(start=param, objective=fitMLE, sis=sis, Incid.O=SmIncid.O, 
#             lower=c(0,-10,-10), upper=c(1,10,10), control=list(trace=1,reltol=.Machine$double.eps))
#res<-nlm(p=param, f=fit, sis=sis, Incid.O=Incid.O)
# res<-optim(pars, fitMLE, model=scabies, Incid.O=SmIncid.O, method="Nelder-Mead",
#              control=list(trace=1,reltol=.Machine$double.eps))
# 
# 
# #res$par[1]=0.11
# newparam=c(BaseParameters, beta=res$par[1], seasonal_A = res$par[2], seasonal_B=res$par[3], intercept=res$par[4])
# 
# #newparam<-c(beta = 0.0000000003, gamma = 0.005, seasonal_forcing = res$par[3], lag=res$par[4])
# #newparam=c(beta=3.11502e-9,gamma=0.082,seasonal_forcing=1,lag=30)
# times <- seq(starttraintime, maxtraintime, by = 1)
# #Incid.O=(timeSeries$Cases.O[1:maxtime])
# 
# out <- as.data.frame(lsoda(y = myinit, times = times, func = scabiesSEITS, parms = newparam))
# out$time <- NULL
# 
#matplot(times, cbind(SmIncid.O[starttraintime:maxtraintime], SmIncid.T[starttraintime:maxtraintime]), type = "l", xlab = "Time", ylab = "Susceptibles and Recovereds", main = "SIS Model with forced seasonality", lwd = 1, lty = 1, bty = "l", col = 2:4)
#legend("topleft", c( "Infected (Oral)", "Infected (Topical)"), pch = 1, col = 2:4)
# 
# beta=res$par[1]
# seasonal_A=res$par[2]
# seasonal_B=res$par[3]
# intercept=res$par[4]
# tbeta=seq(1:52)
# betaper=beta*(intercept+ seasonal_A*cos(2*pi*(tbeta)/52)+seasonal_B*sin(2*pi*(tbeta)/52))
# #matplot(betaper/gamma,type="l")
# #abline(h=1)
# cat("R0=",res$par[1]/gamma,"\n")
# 
# # mGT<-generation.time("gamma", c(2.45, 1.38))
# # for(t in seq(157,208,by=52)){
# #   mGT<-generation.time("gamma", c(2.45, 1.38))
# #   results=est.R0.ML(round(timeSeries$Cases.O), mGT, begin=t, end=t+51, unknown.GT=TRUE)
# #   print(results)
# # }

