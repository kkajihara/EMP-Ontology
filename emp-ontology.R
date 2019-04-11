library(dplyr)

#Spreadsheet location
sampleSheet <- read.csv(file = "~/Desktop/C-MAIKI_Sample_Sheet.csv", stringsAsFactors = F)

#Add empty columns to end of spreadsheet
sampleSheet$empo_1 <- NA
sampleSheet$empo_2 <- NA
sampleSheet$empo_3 <- NA


#add EMP labels to corresponding columns


#opposite of %in%
'%ni%' <- Negate('%in%')


#empo_1
sampleSheet <- within(sampleSheet, empo_1[Host == "Nonhost" & SampleType %ni% c("Air", "EMChamberWood", "SoilChem")] <- "Free-living")
sampleSheet <- within(sampleSheet, empo_1[((Host %in% c("Animal", "Plant", "Fungus")) & (SampleType %ni% c("Negative", "Air"))) | SampleType == "ConeSnail"] <- "Host-associated")
sampleSheet <- within(sampleSheet, empo_1[CollectionLabel == "PCRpositive"] <- "Control")
sampleSheet <- within(sampleSheet, empo_1[SampleType == "MockCommunity"] <- "Control")
sampleSheet <- within(sampleSheet, empo_1[SampleType %in% c("NegativeControl", "PCRNegative")] <- "Control")




#empo_2
sampleSheet <- within(sampleSheet, empo_2[Host == "Fungus"] <- "Fungus")
sampleSheet <- within(sampleSheet, empo_2[Host == "Plant" & SampleType %ni% c("Negative", "Air")] <- "Plant")
sampleSheet <- within(sampleSheet, empo_2[Host == "Animal"| SampleType == "ConeSnail"] <- "Animal")
sampleSheet <- within(sampleSheet, empo_2[(Habitat %in% c("Riverine", "Terrestrial") & Host == "Nonhost") & SampleType %ni% c("Air", "EMChamberWood", "SoilChem")] <- "Non-saline")
sampleSheet <- within(sampleSheet, empo_2[Habitat == "Marine" & Host == "Nonhost"] <- "Marine")
sampleSheet <- within(sampleSheet, empo_2[(SampleType == "NegativeControl" | SampleType == "PCRNegative")] <- "Negative")
sampleSheet <- within(sampleSheet, empo_2[CollectionLabel == "PCRpositive" | SampleType == "MockCommunity"] <- "Positive")




#empo_3

#plant 
sampleSheet <- within(sampleSheet, empo_3[grepl("LeafSwab", SampleType)] <- "Plant surface")
sampleSheet <- within(sampleSheet, empo_3[Project == "BOT662" & SampleType %ni% c("Air", "Negative")] <- "Plant surface")
sampleSheet <- within(sampleSheet, empo_3[grepl("Macaranga", Metadata) & (SampleType %ni% c("Air", "Root", "Soil"))] <- "Plant surface")
sampleSheet <- within(sampleSheet, empo_3[(grepl("Root", SampleType) | grepl("Rhizome", SampleType)) & Project != "BOT662"] <- "Plant rhizosphere")

#fungus
sampleSheet <- within(sampleSheet, empo_3[SampleType == "Mushroom"] <- "Fungus corpus")

#animal
sampleSheet <- within(sampleSheet, empo_3[SampleType == "BirdFecalSwab"] <- "Animal distal gut")
sampleSheet <- within(sampleSheet, empo_3[SampleType == "BirdSkinSwab"] <- "Animal surface")

#non-saline
sampleSheet <- within(sampleSheet, empo_3[SampleType == "RockSwab" & Habitat == "Terrestrial"] <- "Surface (non-saline)")
sampleSheet <- within(sampleSheet, empo_3[grepl("Soil", SampleType) & SampleType != "SoilChem" & Project != "BOT662"] <- "Soil (non-saline)")
sampleSheet <- within(sampleSheet, empo_3[SampleType %in% c("Water", "WaterFilter") & Habitat == "Riverine"] <- "Water (non-saline)")
sampleSheet <- within(sampleSheet, empo_3[grepl("SubstrateSwab", SampleType)] <- "Surface (non-saline)")
sampleSheet <- within(sampleSheet, empo_3[grepl("POM", SampleType)] <- "Sediment (non-saline)")
sampleSheet <- within(sampleSheet, empo_3[SampleType == "Sediment" & Habitat == "Riverine"] <- "Sediment (non-saline)")

#saline
sampleSheet <- within(sampleSheet, empo_3[SampleType == "Water" & Habitat == "Marine"] <- "Water (saline)")
sampleSheet <- within(sampleSheet, empo_3[SampleType == "RockSwab" & Habitat == "Marine"] <- "Surface (saline)")
sampleSheet <- within(sampleSheet, empo_3[SampleType == "Sediment" & Habitat == "Marine"] <- "Sediment (saline)")

#control
sampleSheet <- within(sampleSheet, empo_3[SampleType %in% c("NegativeControl", "PCRNegative")] <- "Sterile water blank")
sampleSheet <- within(sampleSheet, empo_3[SampleType == "MockCommunity"] <- "Mock community")
sampleSheet <- within(sampleSheet, empo_3[CollectionLabel == "PCRpositive"] <- "Single strain")

#plant corpus
sampleSheet <- within(sampleSheet, empo_3[Host == "Plant" & (empo_3 %ni% c("Plant surface", "Plant rhizosphere")) & Project != "BOT662"] <- "Plant corpus")

#animal corpus 
sampleSheet <- within(sampleSheet, empo_3[(Host == "Animal" & (empo_3 %ni% c("Animal distal gut", "Animal surface"))) | (SampleType %in% c("BirdBlood", "ConeSnail"))] <- "Animal corpus")



write.csv(sampleSheet, file = "New_EMP_C-MAIKI_Sample_Collection.csv", row.names = F)
View(sampleSheet)
