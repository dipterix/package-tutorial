tryCatch({
  if(system.file(package="remotes") == ''){
    utils::install.packages("remotes", repos = "https://cloud.r-project.org/")
  }
  if(system.file(package="learnr") == ''){
    remotes::install_cran("learnr", repos = "https://cloud.r-project.org/", upgrade = "never", build = FALSE)

  }

  if(system.file(package="git2r") == ''){
    remotes::install_cran("git2r", repos = "https://cloud.r-project.org/", upgrade = "never", build = FALSE)
  }

}, error = function(e){
  stop("Please make sure packages `remotes`, `learnr`, `git2r` have been installed. Run \n  ",
       "install.packages(c('remotes', 'learnr', 'git2r'))", call. = FALSE)
})

tutorial_path <- function(check = FALSE){
  path <- file.path(tempdir(), "..", "dipterix-tutorial")
  if(check){
    dir.create(path, recursive = TRUE, showWarnings = FALSE)
  }
  if(dir.exists(path)){
    path <- normalizePath(path)
  }
  path
}

download_tutorials <- function(){

  path <- tutorial_path(check = FALSE)
  if(dir.exists(path)){
    unlink(path, recursive = TRUE, force = TRUE)
  }
  path <- tutorial_path(check = TRUE)

  git2r::clone("https://github.com/dipterix/package-tutorial", local_path = path)
  invisible(path)
}

start_tutorial <- function(chapter = 101){
  path <- tutorial_path(check = FALSE)
  if(!dir.exists(path)){
    path <- download_tutorials()
  }
  setwd(path)
  chapter_path <- file.path(path, 'tutorials', sprintf("chapter-%s", chapter))
  tryCatch({
    rmarkdown::run(file.path(chapter_path, sprintf("chapter-%s.Rmd", chapter)), dir = chapter_path, shiny_args = list(launch.browser = TRUE))
  }, error = function(e){
    stop("Error occured (file corrupted). Please run `download_tutorials()` to make sure the tutorial is up-to-date before starting")
  })

}



