#' Customize useR! logo
#'
#' @param colour hex code of the color for use and "!"
#' @param year year of the conference
#' @param folder folder where to save the svg and PNG
#'
#' @export
#'
#' @examples
#' create_logo(colour = "#ffc0cb",
#'             year = 2020,
#'             folder = tempdir())
create_logo <- function(colour = "#ffc0cb",
                        year = 2020,
                        folder){
  # check arguments
  if(nchar(year) != 4){
    stop("year should be a 4 number argument e.g. 2020")
  }

  # load default logo
  logo_path <- system.file("extdata", "userlogo.svg",
                           package = "userlogo")

  logo <- xml2::read_xml(logo_path)

  col_path <- xml2::xml_children(logo)[6]
  current_style <- xml2::xml_attr(col_path, "style")
  new_style <- sub("#494949", colour,
                   current_style)
  xml2::xml_set_attr(col_path, "style", new_style)


  # year
  year_parts <- xml2::xml_find_all(logo, "//d1:tspan", xml2::xml_ns(logo))
  xml2::xml_set_text(year_parts, substring(year, 1:4, 1:4))

  # save
  svg_path <- file.path(folder, "userlogo.svg")
  xml2::write_xml(logo,
                  svg_path)
  svg <- magick::image_read_svg(svg_path)
  magick::image_write(svg, file.path(folder, "userlogo.png"))
}
