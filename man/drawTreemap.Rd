% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/drawTreemap.R
\name{drawTreemap}
\alias{drawTreemap}
\title{drawTreemap}
\usage{
drawTreemap(
  treemap,
  levels = 1:length(treemap@call$levels),
  color_type = "categorical",
  color_level = NULL,
  color_palette = NULL,
  border_level = levels,
  border_size = 6,
  border_color = grey(0.9),
  label_level = max(levels),
  label_size = 1,
  label_color = grey(0.9),
  title = NULL,
  title_size = 1,
  title_color = grey(0.5),
  legend = FALSE,
  custom_range = NULL,
  width = 0.9,
  height = 0.9,
  layout = c(1, 1),
  position = c(1, 1),
  add = FALSE
)
}
\arguments{
\item{treemap}{(treemapResult) Either a \code{voronoiResult} or \code{sunburstResult}
object that contains polygons and metadata as output from running 
\code{\link{voronoiTreemap}} or \code{\link{sunburstTreemap}}.}

\item{levels}{(numeric) A numeric vector representing the hierarchical levels 
that are drawn. The default is to draw all levels.}

\item{color_type}{(character) One of "categorical", "cell_size", "both", or "custom_color".
For "categorical", each cell is colored based on the (parent) category it belongs.
Colors may repeat if there are many cells. For "cell_size", cells are colored
according to their relative area. For "both", cells are be colored the same
way as for "categorical", but lightness is adjusted according to cell area.
For "custom_color", a color index is used that was specified by 
\code{custom_color} during treemap generation. Use \code{NULL} to omit drawing colors.}

\item{color_level}{(numeric) A numeric vector representing the hierarchical level 
that should be used for cell coloring. Must be one of \code{levels}.
Default is to use the lowest level cells for Voronoi treemaps and all levels
for sunburst treemaps.}

\item{color_palette}{(character) A character vector of colors used to fill cells.
The default is to use \code{\link{rainbow_hcl}} from package \code{colorspace}}

\item{border_level}{(numeric) A numeric vector representing the hierarchical level that should be
used for drawing cell borders, or NULL to omit drawing borders, The default is
that all borders are drawn.}

\item{border_size}{(numeric) A single number indicating initial line width of the highest level 
cells. Is reduced each level, default is 6 pts. Alternatively a vector of 
\code{length(border_level)}, then each border is drawn with the specified width.}

\item{border_color}{(character) A single character indicating color for cell borders, 
default is a light grey. Alternatively a vector of \code{length(border_level)}, 
then each border is drawn with the specified color.}

\item{label_level}{(numeric) A numeric vector representing the hierarchical level that should be
used for drawing cell labels, or NULL to omit drawing labels. The default is the
deepest level (every cell has a label).}

\item{label_size}{(numeric) A single number indicating relative size of each label 
in relation to its parent cell. Alternatively a numeric vector of 
\code{length(label_level)} that specifies relative size of labels for each level 
individually.}

\item{label_color}{(character) A single character indicating color for cell labels.
Alternatively a vector of \code{length(label_level)}, then each label 
is drawn with the specified color.}

\item{title}{(character) An optional title, default to \code{NULL}.}

\item{title_size}{(numeric) The size (or 'character expansion') of the title.}

\item{title_color}{(character) Color for title.}

\item{legend}{(logical) Set to TRUE if a color key should be drawn. Default is FALSE.}

\item{custom_range}{(numeric) A numeric vector of length 2 that can be used
to rescale the values in \code{custom_color} to the range of choice.
The default is \code{NULL} and it only has an effect if \code{custom_color}
was specified when generating the treemap.}

\item{width}{(numeric) The width (0 to 0.9) of the viewport that the treemap will occupy.}

\item{height}{(numeric) The height (0 to 0.9) of the viewport that the treemap will occupy.}

\item{layout}{(numeric) Vector of length 2 indicating the number of rows and columns
that the plotting area is supposed to be subdivided in. Useful only together with
\code{position}, which indicates the position of the specific treemap. Use \code{add = TRUE}
to omit starting a new page every time you call \code{drawTreemap()}.}

\item{position}{(numeric) Vector of length 2 indicating the position where the current
treemap should be drawn. Useful only together with \code{layout}, which indicates 
the number of rows and columns the plotting area is subdivided into. Use \code{add = TRUE}
to omit starting a new page every time you call \code{drawTreemap()}.}

\item{add}{(logical) Defaults to \code{FALSE}, creating a new page when drawing
a treemap. When multiple treemaps should be plotted on the same page, this should be
set to TRUE, and position of treemaps specified by \code{layout} and \code{position} arguments.}
}
\value{
The function does not return a value (except NULL). It creates a grid viewport and
  draws the treemap.
}
\description{
Draws the treemap object that was obtained by running \code{\link{voronoiTreemap}} or
\code{\link{sunburstTreemap}}. Many graphical parameters can be customized but some
settings that determine the appearance of treemaps are already made 
during treemap generation. Such parameters are primarily cell size and
initial shape of the treemap.
}
\examples{
# load example data
data(mtcars)
mtcars$car_name = gsub(" ", "\n", row.names(mtcars))

# generate treemap; set seed to obtain same pattern every time
tm <- voronoiTreemap(
  data = mtcars,
  levels = c("gear", "car_name"),
  cell_size = "wt",
  shape = "rounded_rect",
  seed = 123
)

# draw treemap
drawTreemap(tm, label_size = 2)

# draw different variants of the same treemap on one page using
# the 'layout' and 'position' arguments (indicating rows and columns)
drawTreemap(tm, title = "treemap 1", label_size = 2,
  color_type = "categorical", color_level = 1,
  layout = c(1,3), position = c(1, 1))

drawTreemap(tm, title = "treemap 2", label_size = 2,
  color_type = "categorical", color_level = 2, border_size = 3,
  add = TRUE, layout = c(1,3), position = c(1, 2))

drawTreemap(tm, title = "treemap 3", label_size = 2,
  color_type = "cell_size", color_level = 2,
  color_palette = heat.colors(10),
  border_color = grey(0.4), label_color = grey(0.4),
  add = TRUE, layout = c(1,3), position = c(1, 3),
  title_color = "black")

# ---------------------------------------------

# generate sunburst treemap
tm <- sunburstTreemap(
  data = mtcars,
  levels = c("gear", "cyl"),
  cell_size = "hp"
)

# draw treemap
drawTreemap(tm,
  title = "A sunburst treemap",
  legend = TRUE,
  border_size = 2,
  label_color = grey(0.6)
)

}
\seealso{
\code{\link{voronoiTreemap}} for generating the treemap that is
  the input for the drawing function
}
