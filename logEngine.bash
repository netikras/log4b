#!/bin/bash


L_ALL=0;
L_CRIT=1;
L_ERR=2;
L_WARN=3;
L_INFO=4;
L_DEBUG=5;
L_TRACE=6;
L_NONE=99;

LOGLEVEL=${LOGLEVEL:-${L_INFO}};


_LOGLEVELS_PREF=();
_LOGLEVELS_PREF[L_NONE]="[MUTE ]";
_LOGLEVELS_PREF[L_CRIT]="[CRIT ]";
_LOGLEVELS_PREF[L_ERR]="[ERR  ]";
_LOGLEVELS_PREF[L_WARN]="[WARN ]";
_LOGLEVELS_PREF[L_INFO]="[INFO ]";
_LOGLEVELS_PREF[L_DEBUG]="[DEBUG]";
_LOGLEVELS_PREF[L_TRACE]="[TRACE]";
_LOGLEVELS_PREF[L_ALL]="[ALL  ]";


_LOG_TIMESTAMP_COMMAND="date +%s";
_LOG_TIMESTAMP_COMMAND="date +%Y-%m-%dT%H:%M:%S.%N";

_log() {
    local logLevel="${1}";
    local message="${2}";
    
    echo -e "$(${_LOG_TIMESTAMP_COMMAND}) ${_LOGLEVELS_PREF[${logLevel}]}: ${message}";
}


log() {
    
    local logLevel="${1}";
    local message="${2}";
    
    [ "${message}" == "" ] && {
        [ "${logLevel}" == "" ] && {
            message="";
        } || {
            message="${logLevel}";
        }
        logLevel=${L_INFO};
    }

    logLevel=$(resolveLoglevel "${logLevel}");
    
    meetsCurrentLogLevel ${logLevel} && {
        _log "${logLevel}" "${message}";
    }
}


isValidLoglevel() {
    local value="${1}"
    local valid=0;
    
    case ${value} in
        ${L_ALL});;
        ${L_CRIT});;
        ${L_ERR});;
        ${L_WARN});;
        ${L_INFO});;
        ${L_DEBUG});;
        ${L_TRACE});;
        ${L_NONE});;
        *) valid=1;;
    esac;
    
    return ${valid};
}

resolveLoglevel() {
    local value="${1:-${L_INFO}}";
    isValidLoglevel "${value}" || {
        case ${value} in
            "NONE")  value=${L_NONE};;
            "none")  value=${L_NONE};;
    
            "CRIT")  value=${L_CRIT};;
            "crit")  value=${L_CRIT};;
    
            "ERR")   value=${L_ERR};; 
            "ERROR") value=${L_ERR};;
            "err")   value=${L_ERR};; 
            "error") value=${L_ERR};;
    
            "WARN")  value=${L_WARN};;
            "warn")  value=${L_WARN};;
    
            "INFO")  value=${L_INFO};;
            "info")  value=${L_INFO};;
    
            "DEBUG") value=${L_DEBUG};;
            "debug") value=${L_DEBUG};;
    
            "TRACE") value=${L_TRACE};;
            "trace") value=${L_TRACE};;
    
            "ALL")   value=${L_ALL};;
            "all")   value=${L_ALL};;
    
            *)       value=${L_INFO};
            ;;
        esac;
    }
    echo "${value}";
}

meetsCurrentLogLevel() {
    local loglevel="${1}";
    
    [[ ${LOGLEVEL} -ge ${loglevel} ]] && {
        return 0;
    } || {
        return 1;
    }
    
}


LOGLEVEL=$(resolveLoglevel "${LOGLEVEL}");


