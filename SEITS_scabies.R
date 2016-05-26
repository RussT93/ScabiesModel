library(deSolve)
library(FME)
source("parameters.R")


scabies <- function(updateParam=NULL, init=NULL, time=times, doPlot=F){
  newparam<-DefaultParameters
  if(!is.null(updateParam)) newparam[names(updateParam)]=updateParam
  if(is.null(init)) {
    init=DefaultInit
  }
  print(newparam)
  #newparam = pars
  out <- as.data.frame(lsoda(y = init, times = time, func = scabiesSEITS, parms = newparam))
  if(doPlot) {
    matplot(cbind(SmIncid.O[starttraintime:maxtraintime],out$newInf), type="l",xlab = "semaines", ylab = "Nombre de cas de gale par semaine", 
                     main = "Evolution du nombre de cas de gale\n par semaine en France (2007-2012)")
    p= ggplot
  }
  return(out)
}


scabiesSEITS <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
    
    # beta infection
    beta_period=beta*((1-seasonal_forcing)+seasonal_forcing*(1+sin(2*pi*(time+lag)/52))/2)
    #beta_period=beta*(seasonal_A*cos(2*pi*(time)/52)+seasonal_B*sin(2*pi*(time)/52))
    
    # flow from I to T1d
    fIT1d = f * I
    
    # flows from or to S
    fSE =  beta_period * S * (I + rI + T1d) / Population
    fSP = min(e * householdsize * fIT1d, S) 
    fPS =  (h_proph/2) * P
#     cat("h:",h," P:",P, " fIT1d:",fIT1d, " S:",S, "\n")
#     cat("time:",time," fSP: ",fSP, " fPS:",fPS,"\n")
#     cat("Pop:", S+E+I+T1d+T2d+rI+P, "\n")
#     Sys.sleep(0.3)
    
    fT2dS = efficacy2d * h * T2d
    fT1dS = efficacy1d * (1-g) * h * T1d
    
    ### S 
    dS = -fSE + fT2dS + fT1dS -fSP + fPS
    
    # flows to I
    fEI = d*E
    
    ### E
    dE = + fSE - fEI
    
    ### I
    dI = fEI - fIT1d
    
    frIT1d = b * rI
    fT1drI = (1-g)*(1-efficacy1d)* h * T1d
    fT1dT2d = g * h * T1d
    
    ### T
    dT1d = fIT1d - fT1drI - fT1dT2d - fT1dS + frIT1d
    
    fT2drI = (1-efficacy2d) * h * T2d
    dT2d = fT1dT2d - fT2dS - fT2drI
    
    ### rI
    drI = fT1drI + fT2drI - frIT1d
    
    ### P (for prophylaxis)
    dP = fSP - fPS
    
    return(list(c(dS, dP, dE, dI, dT1d, dT2d, drI), newInf=fSE))
  })
}
