# commonr - CommonJS Module/1.1 - style module management for R

Organize your R project on the filesystem level without creating packages! `commonr` is an R implementation of the [JavaScript CommonJS Module/1.1](http://wiki.commonjs.org/wiki/Modules/1.1) specification that lets you create modules as R files in the filesystem without having to worry about cluttering your global environment with lots of `source('myfile.R')` calls.

A package is simply defined as an R script file where all symbols that should be exported are set to the magical `exports` variable - exports could for example be just one function (see `add.R` and `increment.R` below) or a list object (see `io.R` below). You can load packages simply by calling `require.r` with the relative path to the package file.

## Example

*modules/math/add.R:*

    exports = function(a, b) {
        a + b
    }

*modules/math/increment.R:*

    add = require.r('add')

    exports = function(a) {
        add(a, 1)
    }

*modules/io.R:*

    exports = list()

    exports$fprintf = function(file, format, ...) {
        cat(sprintf(format, ...), file=file)
    }

    exports$printf = function(format, ...) {
        exports$fprintf(stdout(), format, ...)
    }

*test.R:*

    library(commonr)

    # modules are located in the modules/ subdirectory
    require.r.config(basedir='modules')

    # load the module located in modules/math/add.R into the variable add
    add = require.r('math/add')

    # load the function printf from the module io located in modules/io.R into the variable printf
    printf = require.r('io')$printf

    printf("Freedom is the right to say that 2 + 2 = %d", add(2,2))

## Installation

Clone this git repository and use `R CMD INSTALL` to install:

        $ git clone https://github.com/sseemayer/commonr.git
        $ R CMD INSTALL commonr/commonr

## License

MIT
