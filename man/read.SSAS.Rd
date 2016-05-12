\name{read.SSAS}
\alias{read.SSAS}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Connects and returns data as data.frame from Microsoft SQL Server Analysis Services
}
\description{
Connects and returns data as data.frame from Microsoft SQL Server Analysis Services. It requires configured HTTP Access to Analysis Services on Internet Information Services (IIS)
}
\usage{
read.SSAS(url, username, password, catalog, mdx)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{url}{
     (String) HTTP Access to Analysis Services on Internet Information Services URL
}
  \item{username}{
     (String) Username in format "DOMAIN\\Username"
}
  \item{password}{
     (String) Password
}
  \item{catalog}{
     (String) SSAS Database
}
  \item{mdx}{
     (String) MDX query
}
}
\details{
To be done, later time.
}
\value{
Returns data.frame with output of MDX query.
}

\author{
Jan Antos
}


%% ~Make other sections like Warning with \section{Warning }{....} ~


\examples{
# no examples yet
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
