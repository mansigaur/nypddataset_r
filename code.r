#sink() to store the output into text file
sink("./Dataset.txt", append = T)
#storing the dataset in NYSI
NYSI <- NYPD_Shooting_Incident_Data__Historic_
#print() to store NYSI into .txt file
print(view(NYSI))
sink()
sink("./Queries.txt", append = T)
#using filter() to get the rows where Borough of shooting incident is BROOKLYN
Borough_Brook <- filter(NYSI, BORO == "BROOKLYN")
print(Borough_Brook)
sink()
sink("./functions.txt", append = T)
#using select() to getting specific columns
Spec_dets <- select(NYSI, INCIDENT_KEY, OCCUR_DATE, OCCUR_TIME, BORO, PRECINCT, STATISTICAL_MURDER_FLAG, PERP_AGE_GROUP, Latitude, Longitude, Lon_Lat)
print(Spec_dets)
sink()
sink("./func.txt", append = T)
#using filter() to get where the shooting incident is occurred on 12/31/2019
Incident_SpecDate <- filter(NYPD_Shooting_Incident_Data__Historic_, OCCUR_DATE == "12/31/2019")
print(Incident_SpecDate)
sink()
sink("./nested_func.txt", append = T)
#using nested functions select() and filter() to get where Borough of crime is Manhattan and some specific columns
nested_functions <- select(filter(NYPD_Shooting_Incident_Data__Historic_, BORO == "MANHATTAN"), INCIDENT_KEY, OCCUR_DATE, OCCUR_TIME, PERP_AGE_GROUP, VIC_RACE)
print(nested_functions)
sink()
sink("./Pipes.txt", append = T)
#using Pipes to get where the Perpetrator is a female
Female_Prep <- NYSI %>%
filter(PERP_SEX == "F") %>%
select(BORO, OCCUR_DATE, OCCUR_TIME, LOCATION_DESC, STATISTICAL_MURDER_FLAG, VIC_SEX, JURISDICTION_CODE, Lon_Lat)
print(Female_Prep)
sink()
sink("./mutate.txt", append = T)
#using mutate()
Lat_lon <- NYSI %>%
select(2:18) %>%
mutate( Point = Latitude + Longitude)
view(Lat_lon)
print(Lat_lon)
sink()
sink("./group.txt", append = T)
#using group_by() and summarize()
NYPD_Shooting_Incident_Data__Historic_ %>%
group_by(PERP_SEX) %>%
summarize(Total_murder = sum(STATISTICAL_MURDER_FLAG))
sink()
sink("./count.txt", append = T)
#using count() to get number of Borough
Count_func <- count(NYPD_Shooting_Incident_Data__Historic_, BORO)
view(Count_func)
print(Count_func)
sink() #getting a graph for Precinct vs Jurisdiction where the shooting incident occurred
ggplot(Spec_dets, aes(x = "PRECINCT", y = "JURISDICTION_CODE")) +
geom_line(aes(group = BORO), colour = "grey50") +
geom_point(aes(colour = BORO))
