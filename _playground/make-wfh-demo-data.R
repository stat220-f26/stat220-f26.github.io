# Run this ONCE (with your own Census key set up) to create the cached files that
# slides19-draft.qmd uses. After that, the slides render without a key and without
# making any live API calls.
#
# Prereq: census_api_key("<your key>", install = TRUE), then restart R.
# Run from the folder that holds slides19-draft.qmd:  source("make-wfh-demo-data.R")
#
# Creates (none of these contain your key):
#   wfh-mn-acs.rds       tidycensus result: share working from home, MN counties (5-year 2020-2024), with geometry
#   wfh-show-call.txt    the "Census API call" line from show_call = TRUE (key removed)
#   wfh-mn-county.json   body of the same request made with httr2
#   wfh-answer-key.csv   Your turn 2 answers (MN statewide, 1-year, 2019 and 2024): for you, not for the slides

library(tidyverse)
library(tidycensus)
library(httr2)

key <- Sys.getenv("CENSUS_API_KEY")
stopifnot("CENSUS_API_KEY is not set: run census_api_key(<key>, install = TRUE), then restart R" = nchar(key) == 40)

# 1. tidycensus ---------------------------------------------------------------
msgs <- capture.output(
  wfh_mn <- get_acs(
    geography = "county",
    state = "MN",
    variables = "B08301_021",
    summary_var = "B08301_001",
    year = 2024,
    survey = "acs5",
    geometry = TRUE,
    show_call = TRUE
  ),
  type = "message"
)
saveRDS(wfh_mn, "wfh-mn-acs.rds")

call_line <- grep("Census API call", msgs, value = TRUE)
call_line <- sub("([?&])key=[^&]*&?", "\\1", call_line)   # belt and suspenders: strip any key
writeLines(call_line, "wfh-show-call.txt")

# 2. httr2: the same request by hand ---------------------------------------------
wfh_request <- request("https://api.census.gov/data") |>
  req_url_path_append("2024") |>
  req_url_path_append("acs") |>
  req_url_path_append("acs5") |>
  req_url_query(
    get = c("NAME", "B08301_001E", "B08301_001M", "B08301_021E", "B08301_021M"),
    `for` = I("county:*"),
    `in` = I("state:27"),
    key = key,
    .multi = "comma"
  )
wfh_response <- req_perform(wfh_request)
body <- resp_body_string(wfh_response)
stopifnot("response body contains the key: do not save" = !grepl(key, body, fixed = TRUE))
writeLines(body, "wfh-mn-county.json")

# 3. Answer key for Your turn 2 (not used by the slides) ----------------------------
get_state_year <- function(year) {
  request("https://api.census.gov/data") |>
    req_url_path_append(as.character(year), "acs", "acs1") |>
    req_url_query(
      get = c("NAME", "B08301_001E", "B08301_021E"),
      `for` = I("state:27"),
      key = key,
      .multi = "comma"
    ) |>
    req_perform() |>
    resp_body_json(simplifyVector = TRUE) |>
    janitor::row_to_names(1) |>
    as_tibble() |>
    mutate(year = year,
           across(c(B08301_001E, B08301_021E), as.numeric),
           pct_wfh = B08301_021E / B08301_001E)
}
answer_key <- map(c(2019, 2021, 2022, 2023, 2024), get_state_year) |> list_rbind()
write_csv(answer_key, "slides/19/wfh-answer-key.csv")
print(answer_key)

message("Done. Wrote wfh-mn-acs.rds, wfh-show-call.txt, wfh-mn-county.json, wfh-answer-key.csv")
