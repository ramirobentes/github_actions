library(tidyverse)
library(hoopR)
library(janitor)

player_logs <- map_df(year_to_season(2000:2023),
                      function(x){
                        nba_leaguegamelog(season = x, player_or_team = "P") %>%
                          pluck("LeagueGameLog") %>%
                          mutate(season = x)
                      }) %>%
  clean_names() %>%
  mutate(across(c(min:fantasy_pts), as.numeric))

write_rds(player_logs, "player_logs.rds")