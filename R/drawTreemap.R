#' drawTreemap
#'
#' Draws the treemap object that was obtained by running \code{\link{voronoiTreemap}} or
#' \code{\link{sunburstTreemap}}. Many graphical parameters can be customized but some
#' settings that determine the appearance of treemaps are already made 
#' during treemap generation. Such parameters are primarily cell size and
#' initial shape of the treemap.
#'
#' @param treemap (treemapResult) Either a \code{voronoiResult} or \code{sunburstResult}
#'   object that contains polygons and metadata as output from running 
#'   \code{\link{voronoiTreemap}} or \code{\link{sunburstTreemap}}.
#' @param levels (numeric) A numeric vector representing the hierarchical levels 
#'   that are drawn. The default is to draw all levels.
#' @param color_type (character) One of "categorical", "cell_size", "both", or "custom_color".
#'   For "categorical", each cell is colored based on the (parent) category it belongs.
#'   Colors may repeat if there are many cells. For "cell_size", cells are colored
#'   according to their relative area. For "both", cells are be colored the same
#'   way as for "categorical", but lightness is adjusted according to cell area.
#'   For "custom_color", a color index is used that was specified by 
#'   \code{custom_color} during treemap generation. Use \code{NULL} to omit drawing colors. 
#' @param color_level (numeric) A numeric vector representing the hierarchical level 
#'   that should be used for cell coloring. Must be one of \code{levels}.
#'   Default is to use the lowest level cells for Voronoi treemaps and all levels
#'   for sunburst treemaps.
#' @param color_palette (character) A character vector of colors used to fill cells.
#'   The default is to use \code{\link{rainbow_hcl}} from package \code{colorspace}
#' @param border_level (numeric) A numeric vector representing the hierarchical level that should be
#'   used for drawing cell borders, or NULL to omit drawing borders, The default is
#'   that all borders are drawn.
#' @param border_size (numeric) A single number indicating initial line width of the highest level 
#'   cells. Is reduced each level, default is 6 pts. Alternatively a vector of 
#'   \code{length(border_level)}, then each border is drawn with the specified width.
#' @param border_color (character) A single character indicating color for cell borders, 
#'   default is a light grey. Alternatively a vector of \code{length(border_level)}, 
#'   then each border is drawn with the specified color.
#' @param label_level (numeric) A numeric vector representing the hierarchical level that should be
#'   used for drawing cell labels, or NULL to omit drawing labels. The default is the
#'   deepest level (every cell has a label).
#' @param label_size (numeric) A single number indicating relative size of each label 
#'   in relation to its parent cell. Alternatively a numeric vector of 
#'   \code{length(label_level)} that specifies relative size of labels for each level 
#'   individually.
#' @param label_color (character) A single character indicating color for cell labels.
#'   Alternatively a vector of \code{length(label_level)}, then each label 
#'   is drawn with the specified color.
#' @param title (character) An optional title, default to \code{NULL}.
#' @param title_size (numeric) The size (or 'character expansion') of the title.
#' @param title_color (character) Color for title.
#' @param legend (logical) Set to TRUE if a color key should be drawn. Default is FALSE.
#' @param custom_range (numeric) A numeric vector of length 2 that can be used
#'   to rescale the values in \code{custom_color} to the range of choice.
#'   The default is \code{NULL} and it only has an effect if \code{custom_color}
#'   was specified when generating the treemap.
#' @param width (numeric) The width (0 to 0.9) of the viewport that the treemap will occupy.
#' @param height (numeric) The height (0 to 0.9) of the viewport that the treemap will occupy.
#' @param layout (numeric) Vector of length 2 indicating the number of rows and columns
#'   that the plotting area is supposed to be subdivided in. Useful only together with
#'   \code{position}, which indicates the position of the specific treemap. Use \code{add = TRUE}
#'   to omit starting a new page every time you call \code{drawTreemap()}.
#' @param position (numeric) Vector of length 2 indicating the position where the current
#'   treemap should be drawn. Useful only together with \code{layout}, which indicates 
#'   the number of rows and columns the plotting area is subdivided into. Use \code{add = TRUE}
#'   to omit starting a new page every time you call \code{drawTreemap()}.
#' @param add (logical) Defaults to \code{FALSE}, creating a new page when drawing
#'   a treemap. When multiple treemaps should be plotted on the same page, this should be
#'   set to TRUE, and position of treemaps specified by \code{layout} and \code{position} arguments.
#' 
#' @return The function does not return a value (except NULL). It creates a grid viewport and
#'   draws the treemap.
#' 
#' @seealso \code{\link{voronoiTreemap}} for generating the treemap that is
#'   the input for the drawing function
#'
#' @examples
#' # load example data
#' data(mtcars)
#' mtcars$car_name = gsub(" ", "\n", row.names(mtcars))
#' 
#' # generate treemap; set seed to obtain same pattern every time
#' tm <- voronoiTreemap(
#'   data = mtcars,
#'   levels = c("gear", "car_name"),
#'   cell_size = "wt",
#'   shape = "rounded_rect",
#'   seed = 123
#' )
#' 
#' # draw treemap
#' drawTreemap(tm, label_size = 2)
#' 
#' # draw different variants of the same treemap on one page using
#' # the 'layout' and 'position' arguments (indicating rows and columns)
#' drawTreemap(tm, title = "treemap 1", label_size = 2,
#'   color_type = "categorical", color_level = 1,
#'   layout = c(1,3), position = c(1, 1))
#' 
#' drawTreemap(tm, title = "treemap 2", label_size = 2,
#'   color_type = "categorical", color_level = 2, border_size = 3,
#'   add = TRUE, layout = c(1,3), position = c(1, 2))
#' 
#' drawTreemap(tm, title = "treemap 3", label_size = 2,
#'   color_type = "cell_size", color_level = 2,
#'   color_palette = heat.colors(10),
#'   border_color = grey(0.4), label_color = grey(0.4),
#'   add = TRUE, layout = c(1,3), position = c(1, 3),
#'   title_color = "black")
#' 
#' # ---------------------------------------------
#' 
#' # generate sunburst treemap
#' tm <- sunburstTreemap(
#'   data = mtcars,
#'   levels = c("gear", "cyl"),
#'   cell_size = "hp"
#' )
#' 
#' # draw treemap
#' drawTreemap(tm,
#'   title = "A sunburst treemap",
#'   legend = TRUE,
#'   border_size = 2,
#'   label_color = grey(0.6)
#' )
#' 
#' @importFrom dplyr %>%
#' @importFrom grid grid.newpage
#' @importFrom grid grid.text
#' @importFrom grid grid.polygon
#' @importFrom grid grid.draw
#' @importFrom grid grid.layout
#' @importFrom grid gpar
#' @importFrom grid unit
#' @importFrom grid viewport
#' @importFrom grid pushViewport
#' @importFrom grid popViewport
#' @importFrom colorspace rainbow_hcl
#' @importFrom scales rescale
#' @importFrom lattice draw.colorkey
#' @importFrom grDevices colorRampPalette
#' @importFrom grDevices grey
#' @importFrom stats setNames
#' @importFrom utils tail
#' 
#' @export drawTreemap
#' 
drawTreemap <- function(
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
  add = FALSE)
{
  
  # validate input data and parameters
  validate_treemap(treemap, 
  width, height, layout, position, add,
  levels, color_level, border_level, 
  label_level, color_palette,
  border_color, label_color, 
  custom_range, title)
  
  # determine color levels based on treemap type
  if (is.null(color_level)) {
    if (inherits(treemap, "sunburstResult")) {
      color_level = levels
    } else {
      color_level = min(levels)
    }
  }
  
  # new grid page is the default
  if (!add) {
    grid::grid.newpage()
  }
  
  
  # generate main grid viewport
  # optionally subdividing the plot area by layout argument
  grid::pushViewport(
    grid::viewport(
      layout = grid::grid.layout(
        nrow = layout[1], 
        ncol = layout[2]
      )
    )
  )
  
  # generate child viewport for drawing one treemap 'object' 
  # including title and legend
  grid::pushViewport(
    grid::viewport(
      layout.pos.row = position[1],
      layout.pos.col = position[2]
    )
  )
  
  # generate viewport to draw treemap in, with some user-specified margins
  # plus optional margins if legend or title is drawn
  grid::pushViewport(
    grid::viewport(
      x = {if (legend) 0.45 else 0.5},
      y = {if (!is.null(title)) 0.475 else 0.5},
      xscale = c(0, 2000),
      yscale = c(0, 2000),
      width = {if (legend) width - 0.1 else width},
      height = {if (!is.null(title)) height - 0.05 else height}
    )
  )
  
  
  # DRAWING POLYGONS
  # There are different possible cases to determine the cell color
  # depending on the user's choice
  treemap <- add_color(treemap, color_palette, color_type, 
    color_level, custom_range)
  # the treemap object is a nested list
  # use apply function to draw the single polygons for desired level
  lapply(treemap@cells, function(tm_slot) {
    if (tm_slot$level %in% color_level) {
      drawPoly(tm_slot$poly, tm_slot$name, 
        fill = tm_slot$color, lwd = NA, col = NA)
    }
    # in case of color_type == "both" draw also lowest level
    if (color_type == "both" & 
        tm_slot$level == max(levels) &
        !(tm_slot$level %in% color_level)
    ) {
      drawPoly(tm_slot$poly, tm_slot$name, 
        fill = tm_slot$color, lwd = NA, col = NA)
    }
  }) %>% invisible
  
  
  # DRAWING BORDERS
  if (!is.null(border_color) & !is.null(border_size)) {
    
    # draw only borders for the correct level
    lapply(treemap@cells, function(tm_slot) {
      if (tm_slot$level %in% border_level) {
        
        # determine border size and color from supplied options;
        # if single value is supplied for border size
        if (length(border_size) == 1) {
          
          # differentiate between voronoi treemap where we want decreasing
          # lwd of borders with decreasing level, and sunburst treemap where
          # we want the same size
          if (inherits(treemap, "sunburstResult")) {
            border_lwd <- border_size
          } else {
            border_lwd <- border_size / tm_slot$level
          }
          
          # or use different sizes for each level
        } else {
          border_lwd <- border_size[tm_slot$level]
        }
        
        if (length(border_color) > 1) {
          border_col <- border_color[tm_slot$level]
        } else {
          border_col <- border_color
        }
        
        drawPoly(tm_slot$poly, tm_slot$name, 
          fill = NA, lwd = border_lwd, col = border_col)

      }
    }) %>% invisible
    
  }
  
  
  # DRAWING LABELS
  if (
    !is.null(label_level) & 
    !is.null(label_size) & 
    !is.null(label_color)
  ) {
    
    # two possible options: labels for voronoi treemaps
    # and labels for sunburst treemaps
    if (inherits(treemap, "sunburstResult")) {
      
      if (length(label_level) > 1) {
        stop("'label_level' should only have length 1 (labels for one level only)")
      } else {
        draw_label_sunburst(
          treemap@cells, label_level, label_size, label_color,
          treemap@call$diameter_outer
        )
      }
      
    } else {
      draw_label_voronoi(
        treemap@cells, label_level, label_size, label_color
      )
    }
  
  }
  
    
  # DRAW OPTIONAL TITLE
  if (!is.null(title)) {
    
    # pop viewport back to parent
    grid::popViewport()
    
    # generate viewport for title
    grid::pushViewport(
      grid::viewport(y = 0.95, height = 0.1)
    )
    grid::grid.text(
      title, 
      y = 0.5, 
      gp = grid::gpar(cex = title_size, col = title_color)
    )
    
  }
  
  # DRAW OPTIONAL LEGEND
  if (legend) {
    
    # pop viewport back to parent
    grid::popViewport()
    
    # generate viewport for legend; viewport for legend is also scaled
    # depending on title and height arguments
    grid::pushViewport(
      grid::viewport(
        x = 0.95,
        y = {if (!is.null(title)) 0.475 else 0.5},
        width = 0.1,
        height = {if (!is.null(title)) height - 0.05 else height}
      )
    )
    
    # create legend as a list of options
    pal <- treemap@call$palette
    colorkey <- list(
      space = "right",
      col = pal,
      at = 0:length(pal),
      labels = c(names(pal), ""),
      width = 0.8,
      axis.line = list(alpha = 1, col = border_color, lwd = 1, lty = 1),
      axis.text = list(alpha = 1, cex = 0.8, col = title_color, font = 1, lineheight = 1)
    )
    
    # draw using draw.colorkey from lattice::levelplot
    grid.draw(
      lattice::draw.colorkey(key = colorkey)
    )
    
  }
  
  # Finally pop the viewport back to the parent viewport
  # in order to allow adding more plots
  popViewport(3)
  
}

