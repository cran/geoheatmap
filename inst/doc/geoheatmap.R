## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----positioning of logo, echo= FALSE, warning=FALSE--------------------------
library(knitr)

logo_path <- system.file("internal/geoheatmap.png", package = "geoheatmap")
logo_uri <- image_uri(logo_path)
htmltools::img(src = logo_uri, 
               alt = 'logo', 
               style = 'position:absolute; top:17px; right:17px; width:170px; border:none; outline:none')

## ----eval= FALSE--------------------------------------------------------------
#  install.packages("geoheatmap")

## ----setup, message=FALSE-----------------------------------------------------
library(geoheatmap)
library(geofacet)
library(plotly)
library(viridisLite)

## -----------------------------------------------------------------------------
data(internet, package = "geoheatmap")
head(internet)

## -----------------------------------------------------------------------------
internet_2015 <- subset(internet, year == 2015)

## ----message= FALSE, fig.width= 8, fig.height= 6------------------------------
geoheatmap(facet_data= internet_2015, grid_data= europe_countries_grid1,
           facet_col = "country", value_col = "users", 
           low = "#56B1F7", high = "#132B43") + 
  labs(title = "2015 Internet Usage in Europe")


## ----message= FALSE, fig.width= 8, fig.height= 6------------------------------
geoheatmap(facet_data = internet_2015, 
           grid_data = europe_countries_grid1,
           facet_col = "country", 
           value_col = "users",
           name = "Internet users: divergent",
           ggplot2_scale_function = scale_fill_gradient2, 
           low =  viridis(10)[1], 
           mid = "white", 
           high = viridis(10)[8], 
           midpoint = 75,  
           round = TRUE) + 
  labs(title = "2015 Internet Usage in Europe")

## ----message= FALSE, fig.width= 8, fig.height= 6------------------------------

geoheatmap(facet_data= internet_2015, grid_data= africa_countries_grid1,
           facet_col = "country", value_col = "users",
           name= "Internet users: binned",
           ggplot2_scale_function = scale_fill_binned,
           type= "viridis") + 
  labs(title = "Internet Usage in Africa")


## -----------------------------------------------------------------------------
internet_2015$users_bin= cut(internet_2015$users, breaks = c(-Inf, 25, 50, Inf), labels = c("0-25", "26-50", "51 and up"))

## ----message= FALSE, fig.width= 8, fig.height= 6------------------------------
geoheatmap(facet_data= internet_2015, grid_data= africa_countries_grid1,
           facet_col = "country", value_col = "users_bin",
           name= "Internet users: binned",
           ggplot2_scale_function = scale_fill_brewer,
           type = "seq", palette= "Greens", na.value= "grey50" ) + 
  labs(title = "Internet Usage in Africa")

## -----------------------------------------------------------------------------
de_states_grid1

## ----dummy german, fig.width= 8, fig.height= 6--------------------------------
# Dummy data frame with German states and number of football teams
football_teams= data.frame(state = c("Baden-Württemberg", "Bayern", 
                                     "Berlin", "Brandenburg",
                                     "Bremen", "Hamburg", 
                                     "Hessen", "Mecklenburg-Vorpommern",
                                     "Niedersachsen", "Nordrhein-Westfalen",
                                     "Rheinland-Pfalz", "Saarland", 
                                     "Sachsen", "Sachsen-Anhalt",
                                     "Schleswig-Holstein", "Thüringen"),
                           teams = c(18, 22, 8, 6, 4, 5, 14, 3, 
                                     12, 28, 10, 3, 9, 5, 7, 4)
                           )

geoheatmap(facet_data= football_teams,
        grid_data= de_states_grid1,
        facet_col = "state",value_col = "teams",merge_col = "name_de",
        name= "No. of teams",
        low = "lightblue", high = plasma(2)[1],
        round = TRUE) + 
  labs(title = "Football teams in German states")


## ----intercative, fig.width= 8, fig.height= 6---------------------------------
geoheatmap(facet_data= football_teams,
        grid_data= de_states_grid1,
        facet_col = "state",value_col = "teams",merge_col = "name_de",
        name= "No. of teams",
        low = "lightblue", high = plasma(2)[1],
        hover = TRUE)

## ----false intercatice, fig.width=4, fig.height=2-----------------------------
geoheatmap(facet_data= football_teams,
        grid_data= de_states_grid1,
        facet_col = "state",value_col = "teams",merge_col = "name_de",
        name= "No. of teams",
        low = "lightblue", high = plasma(2)[1],
        round = TRUE,
        hover = TRUE)

## -----------------------------------------------------------------------------
geofacet::get_grid_names()

