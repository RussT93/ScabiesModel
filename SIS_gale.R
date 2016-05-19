library(deSolve)
library(FME)
source("parameters.R")

scabiesSEITS <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
    #beta_period=(beta)*((1-seasonal_forcing)+seasonal_forcing*(1+sin(2*pi*(time+lag)/52))/2)
    
    # beta infection
    beta_period=beta*((1-seasonal_forcing)+seasonal_forcing*(1+sin(2*pi*(time+lag)/52))/2)
    #beta_period=beta*(seasonal_A*cos(2*pi*(time)/52)+seasonal_B*sin(2*pi*(time)/52))
    
    # flow from I to T1d
    fIT1d = f * I
    
    # flows from or to S
    fSE =  beta_period * S * (I + rI + T1d) / Population
    fSP = e * householdsize * fIT1d
    fPS =  (h/2) * P
    fT2dS = efficacy2d * h * T2d
    fT1dS = efficacy1d * (1-g) * h * T1d
    
    ### S 
    dS = -fSE + fT2dS + fT1dS
    
    fEI = d*E
    
    ### E
    dE = + fSE - fEI
    
    ### I
    dI = fEI - fIT1d
    
    frIT1d = b * rI
    fT1drI = (1-g)*(1-efficacy1d)* h * T1d
    fT1dT2d = g * h * T1d
    
    ### T

    dT1d = fIT1d - fT1drI - fT1dT2d - fT1dS
    
    fT2drI = (1-efficacy2d) * h * T2d
    dT2d = fT1dT2d - fT2dS - fT2drI
    
    ### rI
    drI = fT1drI + fT2drI - frIT1d
    
    ### P (for prophylaxis)
    dP = fSP - fPS
    
    return(list(c(dS, dE, dP, dI, dT1d, dT2d, drI)))
  })
}