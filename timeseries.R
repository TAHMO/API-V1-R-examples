install.packages("httr")
require("httr")

# Fill in your API credentials.
API_ID <- '3HUOQWVK0WDIH3N1I4CZXVESB'
API_SECRET <- 'sZTgiwMeeAtGRnvtmHGKAEYYs+Rr/uBh1djYAxiUwoM'

# Specify the station id, start date and end date for the timeseries you would like to request.
stationId <- 'TA00058'
startDate <- '2018-01-01T00:00'
endDate <- '2018-01-31T23:59'

resp <- httr::GET(paste("https://tahmoapi.mybluemix.net/v1/timeseries/", stationId, "/?startDate=", startDate, "&endDate=", endDate, sep=""), accept_json(), authenticate(API_ID, API_SECRET))
cont <- content(resp, as = "parsed", type = "application/json")

if(cont['status'] != 'success') {
  print('API request failed')
} else {
  station <- cont[['station']]
  timeseries <- cont[['timeseries']]
  
  if(exists('temperature', where=timeseries))
  {
    timestamps <- names(timeseries[['temperature']])
    values <- timeseries[['temperature']]

    for(i in 1:length(timestamps)){
      # Print timestamp and value of observations.
      print(paste(timestamps[i],values[i]))
    }
  }
}