install.packages("httr")
require("httr")

# Fill in your API credentials.
API_ID <- '3HUOQWVK0WDIH3N1I4CZXVESB'
API_SECRET <- 'sZTgiwMeeAtGRnvtmHGKAEYYs+Rr/uBh1djYAxiUwoM'

resp <- httr::GET("https://tahmoapi.mybluemix.net/v1/stations", accept_json(), authenticate(API_ID, API_SECRET))
cont <- content(resp, as = "parsed", type = "application/json")

if(cont['status'] != 'success') {
  print('API request failed')
} else {
  stations <- cont[['stations']]
  for(i in seq_along(stations)) {
    # Print station name.
    print(stations[[i]][['name']])
  }
}