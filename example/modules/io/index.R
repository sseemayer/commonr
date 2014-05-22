# example of multiple exports in a single R file. 
# By default, exports is an empty list. We can add functions to the list to export multiple things from one module:

exports$printf = require.r("./printf")
exports$fprintf = require.r("./fprintf")
