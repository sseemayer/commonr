# example of multiple exports in a single R file. 
# We will initialize the exports as an empty list and then add objects to it step by step.

exports = list()

exports$printf = function(format, ...) {
        cat(sprintf(format, ...))
}

exports$fprintf = function(file, format, ...) {
        cat(sprintf(format, ...), file=file)
}
