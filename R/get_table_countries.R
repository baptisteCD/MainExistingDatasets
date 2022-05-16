get_table_countries <- function(x, world) {
    countries_db <- x %>% dplyr::select(Country)
    countries_db <- trimws(unlist(strsplit(countries_db$Country, "[&/]")))
    countries_db <- gsub("-", " ", countries_db[!grepl("wide", countries_db)])

    countries_db[countries_db == "UK"] <- "United Kingdom"
    countries_db[countries_db == "South Korea"] <- "Republic of Korea"
    countries_db[countries_db == "Barcelona"] <- "Spain"
    countries_db[
        grepl(
            "United States|USA",
            countries_db,
            ignore.case = TRUE,
            perl = TRUE
        )
    ] <- "United States"

    countries_stats <- data.frame(table(countries_db))
    colnames(countries_stats)[2] <- "N"

    human_dataset_stats <- merge(
        world,
        countries_stats,
        by.x = 2,
        by.y = 1
    )

    human_dataset_stats[, c("name_long", "N")]
}
