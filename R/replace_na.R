#' Replace missing values
#'
#' @description
#' Replace NAs with specified values
#'
#' @param .x A data.frame/data.table or a vector
#' @param replace If `.x` is a data frame, a `list()` of replacement values for specified columns.
#' If `.x` is a vector, a single replacement value.
#'
#' @export
#' @md
#'
#' @examples
#' test_df <- data.table(
#'   x = c(1, 2, NA),
#'   y = c(NA, 1, 2))
#'
#' # Using replace_na.() inside mutate()
#' test_df %>%
#'   mutate.(x = replace_na.(x, 5))
#'
#' # Using replace_na.() on a data frame
#' test_df %>%
#'   replace_na.(list(x = 5, y = 0))
replace_na. <- function(.x, replace = NA) {
  UseMethod("replace_na.")
}

#' @export
replace_na..default <- function(.x, replace = NA) {

  vec_assert(replace, size = 1)

  if (class(replace) %in% c("integer", "double", "numeric")) {
    nafill(.x, "const", fill = replace)
  } else {
    ifelse.(is.na(.x), replace, .x)
  }
}

#' @export
replace_na..data.frame <- function(.x, replace = list()) {

  .x <- as_tidytable(.x)

  stopifnot(is_list(replace))

  if (length(replace) == 0) return(.x)

  replace_vars <- intersect(names(replace), names(.x))

  for (i in seq_along(replace_vars)) {

    .var <- replace_vars[[i]]

    .replace_val <- replace[[i]]
    check_replacement(.replace_val)

    .x[[.var]] <- ifelse.(is.na(.x[[.var]]), .replace_val, .x[[.var]])
  }

  .x
}

check_replacement <- function(x) {
  n <- length(x)
  if (n == 1) {
    return()
  }

  abort("Replacement values must be of length 1")
}

#' @export
#' @rdname dt_verb
#' @inheritParams replace_na.
dt_replace_na <- function(.x, replace = NA) {
  deprecate_soft("0.5.2", "tidytable::dt_replace_na()", "replace_na.()")

  replace_na.(.x, replace)
}
