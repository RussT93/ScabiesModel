library(deSolve)
library(FME)
source("parameters.R")

scabiesSEITS <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
    #beta_period=(beta)*((1-seasonal_forcing)+seasonal_forcing*(1+sin(2*pi*(time+lag)/52))/2)
    
    # beta infection
    beta_period=beta*((1-seasonal_forcing)+seasonal_forcing*(1+sin(2*pi*(time+lag)/52))/2)
    #beta_period=beta*(seasonal_A*cos(2*pi*(time)/52)+seasonal_B*sin(2*pi*(time)/52))
    
    # flows from or to S
    fSEu = a * beta_period * S * (I + rI + T1d) / Population
    fSEc = (1-a) * beta_period * S * (I + rI + T1d) / Population

    fEcS = e  * d * Ec
    fT2dS = eff2 * T2d
    fT1dS = eff1 * (1-g) * T1d
    ### S 
    dS = -fSEu - fSEc + fEcS + fT2dS + fT1dS
    
    fEuI = d*Eu
    fEcI = (1-e) * d * Ec
    
    ### E
    dEu = + fSEu - fEuI
    dEc = + fSEc - fEcI - fEcS

    
 
    fIT1d = f * I
    
    ### I
    dI = fEuI + fEcI - fIT1d
    
    frIT1d = b * rI
    fT1drI = (1-g)* (1-eff1) * T1d
    fT1dT2d = g * T1d
    
    ### T

    dT1d = fIT1d - fT1drI - fT1dT2d - fT1dS
    
    fT2drI = (1-eff2) * T2d
    dT2d = fT1dT2d - fT2dS - fT2drI
    
    ### rI
    drI = fT1drI + fT2drI - frIT1d
    
    return(list(c(dS, dEu, dEc, dI, dT1d, dT2d, drI)))
  })
}