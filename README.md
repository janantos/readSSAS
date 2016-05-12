# readSSAS
Connects and returns data as data.frame from Microsoft SQL Server Analysis Services

TODO: add Discovery command functionality

## Usage
```
library(readSSAS)
urlstr <- "http://my-web-srv01/OLAP/msmdpump.dll"
username <- "domain\\username"
password <- "password"
catalog <- "Adventure Works DW2014"
mdx <- "Select [Measures].[Internet Sales Amount] on Columns,
[Customer].[Customer].[Customer] on Rows
From [Adventure Works]"
 
resultset <- read.SSAS(urlstr, username, password, catalog, mdx)
```

## History

12/05/2016 initial commit

## Licence

GPL-3

