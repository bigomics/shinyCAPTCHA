#' Server-side module component
#' @export
#' @param input input
#' @param output output
#' @param session session
#' @param secret Google secret for reCAPTCHA
#' @import httr 
#' @importFrom jsonlite fromJSON
#' @importFrom shiny isTruthy reactive
recaptcha <- function(id, secret) {
  shiny::moduleServer(id, function(input, output, session) {
    status <- reactive({
      if (isTruthy(input$recaptcha_response)) {
        url <- "https://www.google.com/recaptcha/api/siteverify"
        resp <- httr::POST(url, body = list(
          secret = secret,
          response = input$recaptcha_response
        ))
        jsonlite::fromJSON(httr::content(resp, "text"))
      } else {
        list(success = FALSE)
      }
    })
    return(status)
  })
}
# recaptcha <- function(input, output, session, secret = Sys.getenv("recaptcha_secret")) {
#   status <- reactive({
#     if (isTruthy(input$recaptcha_response)) {
#       url <- "https://www.google.com/recaptcha/api/siteverify"
#       
#       resp <- POST(url, body = list(
#         secret = secret,
#         response = input$recaptcha_response
#       ))
#       
#       fromJSON(content(resp, "text"))
#     } else {
#       list(success = FALSE)
#     }
#   })
#   
#   return(status)
#   
# }