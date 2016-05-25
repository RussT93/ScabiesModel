source("SEITS_scabies.R")


fitMLE <-function(pars, model, Incid.O){
  newparam<-c(BaseParameters, pars)
  newinit<-myinit
  out <- as.data.frame(lsoda(y = init, times = times, func = scabiesSEITS, parms = BaseParameters))
  res<-sum(dnorm(x=Incid.O[starttraintime:maxtraintime],mean=out$I,log=TRUE))
  return(-res)
}

#
# Run the model with an updated parameter list (optional) and output the cost (difference with observed)
scabiesCost <-function(p, updateParam=NULL, init){
  doPlot=T
  newparam<-DefaultParameters
  #print(init)
  #updateparam contains the parameter that you want to update in the default parameters set
  if(!is.null(updateParam)) newparam[names(updateParam)]=updateParam
  newparam[names(p)]=p
  
  #print(p)
  #print(newparam)
  out <- as.data.frame(lsoda(y = init, times = times, func = scabiesSEITS, parms = newparam))
  data=cbind(time=times,SmIncid.O[times])
  #print(data)
  #print(out$I)
  cost=modCost(model=cbind(time=times,out$newInf), obs=data)
  if(doPlot) matplot(cbind(SmIncid.O[starttraintime:maxtraintime],out$newInf), type="l")
  print(cost$model)
  return(cost)
}


calibrateBeta <- function(pars=NULL, lp=NULL, up=NULL, updateParam=NULL) {
  if(!is.null(updateParam)) updateParam=c(a=updateParam)
  print(updateParam)
  ##
  ## First find the right initial state
  ##
  # the initial number of infected that we want
  I0=mean(c(SmIncid.O[starttraintime],SmIncid.T[starttraintime]))

  #the updated parameter list with or without a
  if(is.null(pars)){
    pars=c(beta=0.1, seasonal_forcing=0.5)
    lp=pars*0
    up=c(beta=10, seasonal_forcing=1)  
  }else{
    if(is.null(lp)) lp=pars*0
    if(is.null(up)) up=pars*1.5
  }
  
  
  ## calibrate with initial seeding
  print("First calibration run with default init values")
  Fit = modFit(scabiesCost, p=pars, updateParam=updateParam, init=DefaultInit, lower=lp, upper=up, method="Nelder-Mead", control=list(trace=5))
  print(coef(Fit))
  DoSecondCalib=F
  if(DoSecondCalib){
    # run again the model with the new parameter set
    newparam=BaseParameters
    if(!is.null(updateParam)) newparam[names(updateParam)]=updateParam
    newparam[names(coef(Fit))]=coef(Fit)
    outInit <- scabies(updateParam = newparam)
    ## find state corresponding to the initial number of infected
    index_state=which.min((outInit$I[2:maxtraintime]-I0)^2)+1
    myinit2=as.numeric(outInit[index_state,2:8])
    names(myinit2)=names(DefaultInit)
    myinit=myinit2
    ## recalibrate with the right initial state
    print("Second calibration run with new init values")
    Fit = modFit(scabiesCost, p=pars,updateParam, init=myinit, lower=c(0), upper=c(3), method="BFGS", control=list(trace=5))
    print(coef(Fit))
  }
  if(DoSecondCalib)  return(c(coef(Fit),myinit))
  else return(c(coef(Fit)))
}
