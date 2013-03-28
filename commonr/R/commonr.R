
# __ ___ _ __  _ __  ___ _ _  _ _ 
#/ _/ _ \ '  \| '  \/ _ \ ' \| '_|
#\__\___/_|_|_|_|_|_\___/_||_|_|    - CommonJS Modules/1.1 goes R 



# default configuration
.config = list(
        basedir=".",
        paths=list()
)

# cache for loaded modules
.loaded_modules = new.env()

# go up the frames, looking for a magic require.r.tmpsrc variable 
# which signifies a module loading environment
.find_tmpsrc = function() {
        for(env in sys.frames()) {
                if(!is.null(env$require.r.tmpsrc)) {
                        return(env$require.r.tmpsrc)
                }
        }
        NULL
}

# get the basedir for loading modules
.get_basedir <- function() {

        # special handling for using require within a module
        # the environment a module is loaded in will set "require.r.tmpsrc" 
        # as the file name of the currently loading file
        tmpsrc = .find_tmpsrc()
        if(!is.null(tmpsrc)) {
                return(dirname(tmpsrc))
        }

        cmdArgs <- commandArgs(trailingOnly = FALSE)
        needle <- "--file="
        match <- grep(needle, cmdArgs)

        if (length(match) > 0) {
                # file was loaded with Rscript
                srcdir = dirname(sub(needle, "", cmdArgs[match]))

        } else {
                # file was 'source'd via R repl
                spath = sys.frames()[[1]]$ofile
                if(is.null(spath)) {
                        srcdir = '.'
                } else {
                        srcdir = dirname(normalizePath(spath))
                }
        }

        file.path(srcdir, .config$basedir)
}



# resolve a module path from its name
.resolve_module = function(module_name) {


        module_file = .config$paths[[module_name]]

        if(is.null(module_file)) {
                module_file = gsub('/', .Platform$file.sep, module_name)
        }

        module_file = file.path(.get_basedir(), module_file)

        if(!file.exists(module_file)) {
                module_file = paste(module_file, '.R', sep='')
        }

        if(!file.exists(module_file)) { 
                stop(sprintf("Cannot find module '%s' at '%s'!", module_name, module_file))
        }

        module_file
}

# load and return a module
.load_module = function(module_name) {

        load.env = new.env()
        module_file = .resolve_module(module_name)
        load.env$require.r.tmpsrc = module_file

        source(module_file, local=load.env)
        load.env$exports
}

# get a loaded module or load and return it
require.r = function(module_name) {

        if(is.null(.loaded_modules[[module_name]])) {
                .loaded_modules[[module_name]] = .load_module(module_name)
        }

        .loaded_modules[[module_name]]
}

# change configuration settings
require.r.config = function(...) {
        kwargs = as.list(sys.call())
        kwargs[1] = NULL

        env = parent.env(environment())

        unlockBinding('.config', env)

        for(k in names(kwargs)) {
                env$.config[[k]] = kwargs[[k]]
        }

        lockBinding('.config', env)
}
