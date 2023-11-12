# Term1
 Term Project 1 - Data Engineering 1

# 1. Dataset
 Formula 1 World Championship (1950 - 2023)
## Context
 Formula 1 (a.k.a. F1 or Formula One) is the highest class of single-seater auto racing sanctioned by the Fédération Internationale de l'Automobile (FIA) and owned   by the Formula One Group. The FIA Formula One World Championship has been one of the premier forms of racing around the world since its inaugural season in 1950.    The word "formula" in the name refers to the set of rules to which all participants' cars must conform. A Formula One season consists of a series of races, known as Grands Prix, which take place worldwide on purpose-built circuits and on public roads.

## Content
 The dataset consists of all information on the Formula 1 races, drivers, constructors, qualifying, circuits, lap times, pit stops, championships from 1950 till the latest 2023 season.

The dataset contains 14 tables

## Acknowledgements
 The data is compiled from http://ergast.com/mrd/
 
 Source of dataset: https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020

# 2. Database
 1. After downloading the 14 .csv files I created an EER diagram for the model `formula1_EER_diagram_231112.png` containing all tables and relations between them.
 2. With Forward Engineer I created the schema and table structures.
 3. With `LOAD DATA INFILE` I loaded the values from the .csv files. (The repo contains the `formula1_load-data_11.08.sql` file for the purpose of showing the method, for the reproduction it is not neccessary.

# 3. Analytical plan
The aim of this analysis is to answer the following questions.
1. Which driver has the most experience in racing in Formula 1? :
 For the purpose of answering this question I will use a synthetic measure which uses a number of weighted driver performance measures.
2. Who is the most successful driver of each decade? :
 For the purpose of answering this question I will examine which driver had the most race wins in each decade.
3. What is the most common reason for for not finishing a race at each circuit? :
 Is there a difference between the tracks in terms of reason behind racers not finishing the race?
 
# 4. Analytical layer
The analytical layer consist of denormalized data from the following tables `circuits`, `races`, `results`, `drivers`, `constructors`, `status`. Beacause for answering our questions these tables contain enough data and for the puropse of not making processes slow the rest of the tables are not inculded.
1. A stored procedure creates the analytical table (with the creation of analytical layer the simple `result_positionsGained` is created)
2. An event refreshes the analytical table every week and logs the refreshes in log table.

# 5. ETL and Data Marts
For answering the three question three Views are created as Data Marts

1. For determining the most experienced driver a sythetic experince measure is created. This measure takes into account the years raced in Formula 1, laps completed by each driver and positions gained in each race.

2. For determining the most successful driver of each decade I summarized the number of race won by the driver in the specific decade.

3. For answering the question, what was the most common reason for abandoning the race I selected the most frequent reason for each track. To give more sense to this simple status message I also included the count of reason, and their share among all the others for the given track.

# 5. Reproduction of Database
     
 
