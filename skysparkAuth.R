library(httr)
library(digest)
library(base64enc)
library(stringr)

#SkySpark REST documentation: http://www.skyfoundry.com/doc/docSkySpark/Rest

GetSkysparkCookie <- function(username, password, server, project){
  #function takes user name, password, server url, and Skyspark project name.  Url should NOT have / at the end
  #returns the cookie generated by the authentication process
  #cookie is then used in the header for all subsequent REST requests
  
  auth <- GET(paste0(server,"/auth/", project, "/api?",username))
  
  userNonce <- str_extract(content(auth), perl("(?<=nonce:)(.*)(?=\n)"))
  userSalt <- str_extract(content(auth), perl("(?<=userSalt:)(.*)(?=\n)"))
  
  userHmac <- base64enc::base64encode(hmac(password, paste0(username,":", userSalt), algo = "sha1", raw = TRUE, serialize = FALSE))
  userDigest <- base64enc::base64encode(digest(paste0(userHmac, ":", userNonce), algo = "sha1", raw = TRUE, serialize = FALSE))
  
  postBody <- paste0("nonce: ",userNonce, "\ndigest: ", userDigest)
  length <- length(unlist(strsplit(postBody, "")))
  
  postReturn <- POST(paste0(server, "/auth/", project, "/api?", username), 
                     add_headers("Content-Type" = "text/plain", "charset" = "utf-8", "Content-Length" = length), 
                     body = postBody, encode = "multipart")
  
  str_extract(content(postReturn), perl("(?<=cookie:)(.*)"))
}
