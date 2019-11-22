
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gdt

<!-- badges: start -->

<!-- badges: end -->

The goal of gdt is to make {data.table} easier to use.

## Installation

You can install development version from [GitHub](https://github.com/)
with:

``` r
# install.packages("devtools")
devtools::install_github("mtfairbanks/gdt")
```

## Notable Functions

Notable functions in {gdt}:

  - `agg()`: Used inside a data.table for aggregations
  - `as_dt()`: Used to operate safely on data.tables without altering
    the original object
  - `dt_pivot_longer()` & `dt_pivot_wider()`
  - `dt_case_when()`
  - `dt_left_join()`, `dt_inner_join()`, etc.
  - `dt_rename()`
  - `dt_count()`
  - `let_if()` & `let_at`: Equivalent to `mutate_if()` & `mutate_at()`
  - `%notin%`

## General syntax

The code chunk below shows the {gdt} syntax:

``` r
library(pacman)
p_load(gdt)

example_dt <- data.table(x = c(1,2,3), y = c(4,5,6), z = c("a", "a", "b"))

example_dt %>%
  as_dt() %>% # Safely operate on data.tables
  .[, list(x, y, z)] %>% # Select columns
  .[x < 4 & y > 1] %>% # Filter columns
  .[order(x, y)] %>% # Reorder columns
  .[, ':='(double_x = x * 2,
           double_y = y * 2)] %>% # Add columns
  .[, agg(avg_x = mean(x)), by = z] %>% # Summarize/aggregate data
  dt_rename(new_z = z,
            new_avg_x = avg_x) # Rename one or multiple columns
#>    new_z new_avg_x
#> 1:     a       1.5
#> 2:     b       3.0
```

#### dt() helper

The `dt()` function makes {data.table} easily
pipable:

``` r
example_dt <- data.table(x = c(1,2,3), y = c(4,5,6), z = c("a", "a", "b"))

example_dt %>%
  dt(, list(x, y, z)) %>%
  dt(x < 4 & y > 1) %>%
  dt(order(x, y)) %>%
  dt(, ':='(double_x = x * 2,
            double_y = y * 2)) %>%
  dt(, agg(avg_x = mean(x)), by = z)
#>    z avg_x
#> 1: a   1.5
#> 2: b   3.0
```
