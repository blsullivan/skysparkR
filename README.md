# skysparkR

Contains R helper functions for importing and manipulating SkySpark data.

##skysparkAuth.R

GetSkysparkCookie(username, password, server, project)
 
 &nbsp;&nbsp;&nbsp; Retrieves cookie from server using advanced authentication
  
##skysparkFolio.R

GetSkysparkFolio(expr, cookie, server, project, datatype)
 
&nbsp;&nbsp;&nbsp;  Allows execution of a Folio code chunk, with data returned in CSV, JSON, or Zinc.  Requires cookie from GetSkysparkCookie()
  
##skysparkPeriodDecode.R

FromBase64(character)
 
&nbsp;&nbsp;&nbsp;  Helper function for decodePeriod().

FecodePeriod(periodString)
 
 &nbsp;&nbsp;&nbsp; Takes a spark "period" string and converts it to a data frame with each spark occurence as its own row.




