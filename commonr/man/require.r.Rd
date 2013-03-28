\name{require.r}
\alias{require.r}
\title{
require.r
}
\description{
Load a module by name
}
\usage{
require.r(module_name)
}
\arguments{
  \item{module_name}{
  The name of the module, possibly containing subfolders (the '/' character will automatically be translated into a delimiter suitable for your system).
}
}
\value{
  Returns the value of the 'exports' variable in the imported module
}
\author{
Stefan Seemayer
}
