# example of multiple exports in a single R file. 
# By default, exports is an empty list. We can add functions to the list to export multiple things from one module:

exports$printf = function(format, ...) {
        cat(sprintf(format, ...))
}

exports$fprintf = function(file, format, ...) {
        cat(sprintf(format, ...), file=file)
}
