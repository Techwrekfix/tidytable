#' Case when
#'
#' @description
#' This function allows you to use multiple if/else statements in one call.
#'
#' Note that this function is called differently than `dplyr::case_when`. See examples.
#'
#' @param ... Sequence of condition/value designations
#' @param default Default value. Set to NA by default.
#'
#' @export
#'
#' @examples
#' test_df <- tidytable(
#'   a = 1:10,
#'   b = 11:20,
#'   c = c(rep("a", 6), rep("b", 4)),
#'   d = c(rep("a", 4), rep("b", 6)))
#'
#' test_df %>%
#'   mutate.(x = case.(b < 13, 3,
#'                     a > 4, 2,
#'                     default = 10))
#' test_df %>%
#'   mutate.(x = case.(c == "a", "a",
#'                     default = d))
case. <- function(..., default = NA) {
  dots <- enquos(...)
  dots_length <- length(dots)

  index <- '+'(1, 1:dots_length) %% 2

  conditions <- dots[index == 0]
  values <- dots[index == 1]

  if (length(conditions) == 0) abort("No conditions supplied")
  if (length(values) == 0) abort("No values supplied")

  if (length(conditions) != length(values))
    abort("The length of conditions does not equal the length of values")

  calls <- default

  for (i in rev(seq_along(conditions))) {
    calls <- call("ifelse.",
                  quo(rlang::'%|%'(!!conditions[[i]], FALSE)),
                  values[[i]],
                  calls)
  }

  eval_tidy(calls)
}

#' @export
#' @rdname dt_verb
#' @inheritParams case.
dt_case <- function(..., default = NA) {
  deprecate_soft("0.5.2", "tidytable::dt_case()", "case.()")

  case.(..., default = default)
}
