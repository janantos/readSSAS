read.SSAS <-
function (url, username, password, catalog, mdx)
{

#headerFields <-
#  c(Accept = "text/xml",
#    Accept = "multipart/*",
#    'Content-Type' = "text/xml; charset=utf-8",
#    SOAPAction="urn:schemas-microsoft-com:xml-analysis:Execute")

body <- paste('<?xml version="1.0" encoding="UTF-8"?>
  <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
  <Execute xmlns="urn:schemas-microsoft-com:xml-analysis">
  <Command>
  <Statement>',gsub("\n", " ", as.character(XML::xmlTextNode(mdx))[6]),
  '</Statement>
  </Command>
  <Properties>
  <PropertyList>
  <DataSourceInfo/>
  <Catalog>',catalog,'</Catalog>
  <Format>Tabular</Format>
  <AxisFormat>TupleFormat</AxisFormat>
  </PropertyList>
  </Properties>
  </Execute>
  </soap:Body>
  </soap:Envelope>
  ', sep=""
)
  

soapresponse <- POST(url, body=body, authenticate(username, password))
#parsing return status   
status <- http_status(soapresponse)[['category']]

if (status == "Success")
{ 
  docxml <- xmlParse(content(soapresponse,"text", encoding = "UTF-8"), asText = T)
  if (length(xpathSApply(docxml,"/soap:Envelope/soap:Body/soap:Fault")[1][[1]]) == 0)
  {
  #parsing return data
  df <- xmlToDataFrame(docxml, nodes = xmlChildren(xmlRoot(docxml)[["Body"]][["ExecuteResponse"]][["return"]][["root"]])[2:length(xmlChildren(xmlRoot(docxml)[["Body"]][["ExecuteResponse"]][["return"]][["root"]]))],stringsAsFactors = F)
  
  # convert to numeric every column possible
  for (col in names(df)){
     suppressWarnings(if (all(!is.na(as.numeric(df[[col]][!is.na(df[[col]])])))) {df[[col]] <- sapply(df[[col]], as.numeric)})
  }
  # set human readable column names
  namesdf <- data.frame(xmlname = xpathSApply(docxml
						, "//xsd:schema/xsd:complexType[@name='row']/xsd:sequence/xsd:element/@name"
						, namespaces = c(xsd = "http://www.w3.org/2001/XMLSchema"
						, sql = "urn:schemas-microsoft-com:xml-sql"))
			    ,name = xpathSApply(docxml
						,"//xsd:schema/xsd:complexType[@name='row']/xsd:sequence/xsd:element/@sql:field"
						,namespaces = c(xsd = "http://www.w3.org/2001/XMLSchema"
						, sql = "urn:schemas-microsoft-com:xml-sql"))
  )
  names(df) = namesdf[match(names(df),namesdf$xmlname),][['name']]
  return(df)
  } 
  else {
    stop(xmlValue(xpathApply(docxml,"/soap:Envelope/soap:Body/soap:Fault")[1][[1]]))
  } 
} else {

stop(http_status(soapresponse))
} 

}
