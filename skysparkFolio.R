library(httr)

GetSkysparkFolio <- function(expr, cookie, server, project){
  #expr is an Axon code chunk.  Any quotes used in expr must be properly escaped.
  #e.g. expr <- "read(point and dis == \"Point Name\")" 
  #cookie needs to be generated from the function GetSkysparkCookie(username, password, server, project)
  #sever url should not contain / at the end
  #returns the results of the Folio/Axon code chunk in CSV format.  Return format can be changed to zinc, JSON, or xml by modifying headers
  
  apiUrl <- paste0(server, "/api/", project, "/eval")
  
  requestBody <- paste0("ver: \"2.0\"\nexpr\n\"", expr, "\"")
  
  POST(url = apiUrl,
       config = add_headers("Content-Type" = "text/plain", "charset" = "utf-8", "Accept" = "text/csv", "Cookie" = cookie),
       body = requestBody,
       encode = "multipart")
}