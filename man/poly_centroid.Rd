% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/polygon_centroids.R
\name{poly_centroid}
\alias{poly_centroid}
\title{poly_centroid}
\usage{
poly_centroid(poly_x, poly_y)
}
\arguments{
\item{poly_x}{(numeric)  X coordinates of each vertices of the polygon}

\item{poly_y}{(numeric)  Y coordinates of each vertices of the polygon}
}
\value{
A numeric, the area of the polygon.
}
\description{
Mainly for internal use. Determines the centroids of a polygon based on 
its x and y coordinates.
This function is a reimplementation of `soiltexture::TT.polygon.centroids()`
and only re-implemented to avoid extra dependencies.
}
\seealso{
soiltexture::TT.polygon.centroids()
}
