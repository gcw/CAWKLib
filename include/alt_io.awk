#CAWKLib sh_test functions
#Author: G. Clifford Williams <gcw (at) notadiscussion.com>
#Purpose: This library adds file test functionality via the unix 'test'
#         command.
#Notes: We only need the file tests as everything else can be done by AWK.
#       This library uses system() to execute shell commands and the return
#       value is the shell exit code. Typically in the shell an exit code of 0
#       means success. 


function print_error(error_string,  error_command){
    #usage: print_error()
    #purpose: print to stderror without using /dev/* special devices with print
    #notes: this implementation uses the 'cat' command which we consider to be
    #       "standard" on all *nix systems
    error_command = "cat 1>&2"
    print error_string | error_command
    #fflush(error_command)
    close(error_command)
}

function shc_make_fifo( fifo_name, fifo_perms){
    #usage: shc_make_fifo(fname[, perms])
    #purpose: create fifo file named 'fname' with permissions specified in
    #'perms'. Return 1 on success and 0 on failure
    #notes: 
    if ( fifo_perms )
        fifo_cmd = "mkfifo -m " fifo_perms " " fifo_name
    else
        fifo_cmd = "mkfifo " fifo_name
    return ( system(fifo_cmd) == 0 ? 1 : 0 )
}

function shc_cmnd_snag( cmnd_string, base_ary,  cmnd_out_counter ){
    #usage: shc_cmnd_snag(s, a)
    #purpose: capture the standard output of command 's' to array 'a' 
    #         return the number of lines of output
    #notes: I/O redirection is not handled directly buy this function. If you
    #       want to use file descriptors it's up to you include that in your
    #       command
    for ( cmnd_out_counter = 1 ;
            cmnd_string | getline base_ary[cmnd_out_counter] ;
            cmnd_out_counter += 1){
        #empty loop
    }
    close(cmnd_string)
    return cmnd_out_counter -  1
}
