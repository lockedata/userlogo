#' Customize useR! logo
#'
#' @param colour hex code of the colour for use and "!"
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

  modify_logo("userlogo-withyear-square",
              colour = colour,
              year = year, folder = folder)

  modify_logo("userlogo-withyear",
              colour = colour,
              year = year, folder = folder)

}

modify_logo <- function(logofile, colour, year, folder){
  logo_path <- system.file("extdata", paste0(logofile, ".svg"),
                           package = "userlogo")

  logo <- xml2::read_xml(logo_path)

  col_path <- xml2::xml_find_all(logo,
                                 "//d1:path[@id='side']",
                                 xml2::xml_ns(logo))

  current_style <- xml2::xml_attr(col_path, "style")
  new_style <- sub("#2165b6", colour,
                   current_style)
  xml2::xml_set_attr(col_path, "style", new_style)

  # year
  year_parts <- xml2::xml_find_all(logo, "//d1:text[@id='y1' or @id='y2' or @id='y3' or @id='y4']",
                                   xml2::xml_ns(logo))
  xml2::xml_set_text(year_parts, substring(year, 1:4, 1:4))

  # save
  svg_path <- file.path(folder, paste0(logofile, ".svg"))
  xml2::write_xml(logo,
                  svg_path)
  browser()
  svg <- magick::image_read_svg(svg_path,
                                width = 2177.1023,
                                height = 1574.6538)
  magick::image_write(svg, file.path(folder, paste0(logofile, ".png")))
}
