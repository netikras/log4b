A simple logging "framework" for BASH scripts. Several loglevels ara available: 

${L_ALL}
${L_CRIT
${L_ERR}}
${L_WARN}
${L_INFO}
${L_DEBUG}
${L_TRACE}
${L_NONE}

INFO being the default one. Set log level by assigning it to "LOGLEVEL" variable.

usage examples:

    ## 2017-01-09 21:04:00.24345234 [INFO ]: hello
    log "hello";

    ## 2017-01-09 21:04:00.24345234 [INFO ]:
    log;


    ## 2017-01-09 21:04:00.24345234 [ERROR]: hello
    log ${L_ERROR} "hello";


    ## 
    LOGLEVEL=${L_CRIT};
    log ${L_ERROR} "hello";

    ## 2017-01-09 21:04:00.24345234 [ERROR]: hello
    log "ERROR" "hello"

    ## 1483987805 [DEBUG]: hello
    _LOG_TIMESTAMP_COMMAND="date +%s"
    log ${L_DEBUG} "hello"


For now only one appender exists -- ConsoleAppender. Other appenders might be added later on

