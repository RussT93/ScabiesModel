### treatments

dataScabiesTreatments=as.data.frame(read.csv("C:/Users/rthirard/Desktop/ScabiesModel/NumberOfTreatments.csv",header=TRUE,sep=";"))
#View(dataScabiesTreatments)

PContactTreated=0.53

# PropTable=prop.table(dataScabiesTreatments)


## Cases

# Proportion of total (unkown included)
PropOralofT=dataScabiesTreatments[1,2]/(sum(dataScabiesTreatments[1:4,2]))
PropTopofT=dataScabiesTreatments[2,2]/(sum(dataScabiesTreatments[1:4,2]))
PropT.OofT=dataScabiesTreatments[3,2]/(sum(dataScabiesTreatments[1:4,2]))
PropUnkown=dataScabiesTreatments[4,2]/(sum(dataScabiesTreatments[1:4,2]))

# Proportion of known treatment (O, T and O+T)
PropOralofT2=PropOralofT/(sum(PropOralofT,PropTopofT,PropT.OofT))
PropTopofT2=PropTopofT/(sum(PropOralofT,PropTopofT,PropT.OofT))
PropT.OofT2=PropT.OofT/(sum(PropOralofT,PropTopofT,PropT.OofT))
dataScabiesTreatments$Proportion.of.known.treatment.Cases=c(PropOralofT2,PropTopofT2,PropT.OofT2,NA)

## Contacts

# Proportion of total (unkown included)
PropOralofTCon=dataScabiesTreatments[1,3]/(sum(dataScabiesTreatments[1:4,3]))
PropTopofTCon=dataScabiesTreatments[2,3]/(sum(dataScabiesTreatments[1:4,3]))
PropT.OofTCon=dataScabiesTreatments[3,3]/(sum(dataScabiesTreatments[1:4,3]))
PropUnkown=dataScabiesTreatments[4,3]/(sum(dataScabiesTreatments[1:4,3]))

# Proportion of known treatment (O, T and O+T)
PropOralofT2Con=PropOralofTCon/(sum(PropOralofTCon,PropTopofTCon,PropT.OofTCon))
PropTopofT2Con=PropTopofTCon/(sum(PropOralofTCon,PropTopofTCon,PropT.OofTCon))
PropT.OofT2Con=PropT.OofTCon/(sum(PropOralofTCon,PropTopofTCon,PropT.OofTCon))
dataScabiesTreatments$Proportion.of.known.treatment.Contacts=c(PropOralofT2Con,PropTopofT2Con,PropT.OofT2Con,NA)

### doses

dataScabiesDoses=as.data.frame(read.csv("C:/Users/rthirard/Desktop/ScabiesModel/NumberOfDoses.csv",header=TRUE,sep=";",dec=","))
#View(dataScabiesDoses)

## Cases
dataScabiesDoses$Cases=as.integer(dataScabiesDoses$Cases)
Prop1round=dataScabiesDoses[1,2]/(sum(dataScabiesDoses[1:3,2]))
Prop2round=dataScabiesDoses[2,2]/(sum(dataScabiesDoses[1:3,2]))
PropUnkown=dataScabiesDoses[3,2]/(sum(dataScabiesDoses[1:3,2]))

# Proportion of known treatment (O, T and O+T)
Prop1round2=Prop1round/(sum(Prop1round,Prop2round))
Prop2round2=Prop2round/(sum(Prop1round,Prop2round))

dataScabiesDoses$Proportion.of.known.dose.Cases=c(Prop1round2,Prop2round2,NA)

## Contacts


Prop1roundCon=dataScabiesDoses[1,3]/(sum(dataScabiesDoses[1:3,3]))
Prop2roundCon=dataScabiesDoses[2,3]/(sum(dataScabiesDoses[1:3,3]))
PropUnkownCon=dataScabiesDoses[3,3]/(sum(dataScabiesDoses[1:3,3]))

# Proportion of known treatment (O, T and O+T)
Prop1round2Con=Prop1roundCon/(sum(Prop1roundCon,Prop2roundCon))
Prop2round2Con=Prop2roundCon/(sum(Prop1roundCon,Prop2roundCon))

dataScabiesDoses$Proportion.of.known.dose.Contacts=c(Prop1round2Con,Prop2round2Con,NA)


### Topical

PTCase=dataScabiesTreatments$Proportion.of.known.treatment.Cases[2]
POTCase=dataScabiesTreatments$Proportion.of.known.treatment.Cases[3]
P2roundsCase=2*dataScabiesDoses$Proportion.of.known.dose.Cases[2]
P1roundCase=dataScabiesDoses$Proportion.of.known.dose.Cases[1]

## Contacts
PTreated=PContactTreated
PTContact=dataScabiesTreatments$Proportion.of.known.treatment.Contacts[2]
POTContact=dataScabiesTreatments$Proportion.of.known.treatment.Contacts[2]
P2roundsContact=2*dataScabiesDoses$Proportion.of.known.dose.Contacts[2]
P1roundContact=dataScabiesDoses$Proportion.of.known.dose.Contacts[1]


### Oral

## Cases

POCase=dataScabiesTreatments$Proportion.of.known.treatment.Cases[1]


## Contacts

POContact=dataScabiesTreatments$Proportion.of.known.treatment.Contacts[2]


