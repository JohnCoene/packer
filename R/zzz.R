storage <- new.env()

.onAttach <- function(...){
	packageStartupMessage(msg())
}

msg <- function(){
	sprintf(
		"\033[32m%s\033[39m engine set",
		engine_get()
	)
}