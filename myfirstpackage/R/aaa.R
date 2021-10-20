#' @title Hello World to 'myfirstpackage' Users
#' @description Displays "Hello world, I have one name", where \code{name}
#' can be replaced.
#' @param name character, will replace \code{name} in the displayed text
#' @details The details are highly encouraged, but not mandatory
#' @return Returns the printed message
#' @examples
#'
#' hello_world("apple")
#' hello_world("pen")
#' hello_world("penpal apple apple pen")
#'
#' @export
hello_world <- function(name = "pen"){
  print(sprintf("Hello World, I have one %s!", name))
}

hidden_message <- function(){
  print("You cannot see me")
}
