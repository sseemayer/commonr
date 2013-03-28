#!/usr/bin/env Rscript

library(commonr)
require.r.config(basedir='modules')

add = require.r("math/add")
increment = require.r("math/increment")

io = require.r("io")
printf = io$printf
fprintf = io$fprintf

result = add(2, 2)
result2 = increment(result)

printf("The answer to (2+2)+1 is %d\n", result2)
fprintf(stderr(), "I am written to STDERR\n")
