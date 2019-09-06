
library(tidyverse)
library(friendlyeval)

double_col <- function(dat, arg){
  mutate(dat, result = {{arg}}*2)
} # this part passing expressions to function can be solved by double curly braces

double_col(mtcars, cyl)

double_col2 <- function(dat, arg){
  # arg <- parse(arg)
  mutate(dat, result =.data[[arg]] * 2)
} # OK this is one way of solving the string to function problem
## working call form:
double_col2(mtcars, arg = 'cyl')

double_col3 <- function(dat, arg){
  # arg <- parse(arg)
  mutate(dat, result = !!treat_string_as_col(arg) * 2)
} # OK this is one way of solving the string to function problem
## working call form:
double_col3(mtcars, arg = 'cyl')

double_col4 <- function(dat, arg){
  arg <- sym(arg)
  mutate(dat, result = {{arg}} * 2)
} #
## working call form:
double_col4(mtcars, arg = 'cyl')



double_anything <- function(dat, arg){
  mutate(dat, result = (!!treat_input_as_expr(arg)) * 2)
}

## working call form:
double_anything(mtcars, cyl * am)

double_anything2 <- function(dat, arg){
  mutate(dat, result = {{arg}} * 2)
}

## working call form:
double_anything2(mtcars, cyl * am)

reverse_group_by <- function(dat, ...){
  ## this expression is split out for readability, but it can be nested into below.
  groups <- treat_inputs_as_cols(...)

  group_by(dat, !!!rev(groups))
}

## working call form
reverse_group_by(mtcars, gear, am)

reverse_group_by2 <- function(dat, ...){
  ## this expression is split out for readability, but it can be nested into below.
  groups <- rev(...)
  group_by(dat, {{groups}})
}

## working call form
reverse_group_by2(mtcars, gear, am)
