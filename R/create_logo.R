create_logo <- function(colour = "#ffc0cb",
                        year = 2020,
                        folder){

  if(nchar(year) != 4){
    stop("year should be a 4 number argument e.g. 2020")
  }

  logo_path <- system.file("extdata", "userlogo.svg",
                           package = "userlogo")

  logo <- xml2::read_xml(logo_path)

  col_path <- xml2::xml_children(logo)[6]
  current_style <- xml2::xml_attr(col_path, "style")
  new_style <- sub("#494949", colour,
                   current_style)
  xml2::xml_set_attr(col_path, "style", new_style)

  xml2::write_xml(logo,
                  file.path(folder, "userlogo.svg"))
}
