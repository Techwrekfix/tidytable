# Suppress R CMD check note
#' @import data.table
#' @import tidyselect
#' @import glue glue
#' @rawNamespace import(rlang, except = `:=`)
#' @importFrom lifecycle deprecate_soft deprecate_warn expect_deprecated
#' @importFrom methods as
#' @importFrom stats as.formula na.omit
#' @importFrom tibble glimpse trunc_mat
#' @importFrom utils capture.output head tail type.convert
#' @importFrom vctrs vec_assert vec_as_names vec_as_names_legacy vec_cast vec_in
#' @importFrom vctrs vec_ptype_abbr vec_ptype_common vec_recycle vec_size vec_unique
NULL

globalVariables(c(".", "name", "value", "..all_cols", "..select_cols",
                  "..keep_names", "..unite_cols", "..keep_cols", ".env", ".id", "where"))

#' @docType import

## Reexports ------------------------

## tidyselect ------------------------
#' @export
tidyselect::starts_with

#' @export
tidyselect::contains

#' @export
tidyselect::ends_with

#' @export
tidyselect::everything

#' @export
tidyselect::any_of

#' @export
tidyselect::all_of

#' @export
tidyselect::matches

#' @export
tidyselect::num_range

#' @export
tidyselect::last_col

## data.table ------------------------
#' @export
data.table::data.table

#' @export
data.table::setDTthreads

## rlang ------------------------
#' @export
rlang::enquo

#' @export
rlang::enquos

## tibble ------------------------
#' @export
tibble::glimpse
