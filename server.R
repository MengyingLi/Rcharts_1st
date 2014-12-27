## @knitr server
require(shiny)
require(rCharts)
require(dplyr)
df2 = read.csv("foursquare_checkin.csv", stringsAsFactors = FALSE)

df2$colors = brewer.pal(6, 'RdYlGn')[as.numeric(as.factor(df2$Category))]
mean_lat <- mean(df2$venue_lat) # outcome: 50.90956
mean_lon <- mean(df2$venue_lng) 
df2_sub = filter(df2,Category ==input$Category)
df2_sub_list = toJSONArray2(df2_sub,json = F)
shinyServer(function(input, output, session){
  output$map_container <- renderMap({
    map <- Leaflet$new()
    map$tileLayer(provider = 'Stamen.TonerLite')
    map$setView(c(mean_lat, mean_lon), zoom = 5)
    map$geoJson(toGeoJSON(dat_sub_list, lat = 'venue_lat', lon = 'venue_lng'),
                onEachFeature = '#! function(feature, layer){
                layer.bindPopup(feature.properties.venue_name)
  } !#',
                pointToLayer =  "#! function(feature, latlng){
                return L.circleMarker(latlng, {
                radius: 4,
                fillColor: feature.properties.colors || 'red',    
                color: '#000',
                weight: 1,
                fillOpacity: 0.8
                })
} !#"         
  )
  map
  })
})
