#CAWKLib sh_test functions
#Author: G. Clifford Williams <gcw (at) notadiscussion.com>
#Purpose: This library adds file test functionality via the unix 'test'
#         command.
#Notes: We only need the file tests as everything else can be done by AWK.
#       This library uses system() to execute shell commands and the return
#       value is the shell exit code. Typically in the shell an exit code of 0
#       means success. 


function shc_test(sh_p1,sh_p2,sh_p3,   sh_test_cmd){
    #usage: sh_test(param1, param2[, param3])
    #purpose: lowlevel wrapper for 'test' command 
    #example: sh_test("f","/etc/passwd") -> 0 (if /etc/passwd is a reg. file)
    #         sh_test("d","/tmp")        -> 0 (if /tmp is a directory
    #         sh_test("L","/dev/cdrom")  -> 0 (if /dev/cdrom is a sym link)
    #         sh_test("file1","ot","file2") -> 0 (if file1 is older than file2)
    #         sh_test("file1","nt","file2") -> 0 (if file1 is newer than file2)
    #notes: Unless you know what you're doing you should use the other
    #       functions. Return values from sh_test are the exit codes from the 
    #       test command and may cause some confusion if you expect success to
    #       be '0' to AWK 
    #       tests:
    #           -b  block device
    #           -c  character device
    #           -d  directory
    #           -e  exists
    #           -f  regular file
    #           -g  sgid flag is set
    #           -h  <<not supported use -L>>
    #           -k  sticky bit is set 
    #           -p  named pipe (FIFO)
    #           -r  readable
    #           -s  size greater than zero
    #           -t  file_descriptor is open and associated with a terminal
    #           -u  suit flag is set
    #           -w  writable
    #           -x  executable
    #           -L  symbolic link
    #           -O  euid is same as process
    #           -G  egid is same as process
    #           -S  socket
    #           -nt 'f1' newer than 'f2'
    #           -ot 'f1' older than 'f2'
    #           -ef 'f1' refers to same file as 'f2' 
    
    if ( ! sh_p3 && sh_p1  ~ /[bcdefgkprstuwxLOGS]/ && length(sh_p1) == 1 ) {
        sh_test_cmd = "test -" sh_p1 " " sh_p2
    }else if (sh_p3 && sh_p2 ~ /[nt,ot,ef]/ && length(sh_p2) == 2) {
        sh_test_cmd = "test " sh_p1 " -" sh_p2 " " sh_p3
    }else{
        print "invalid parameters"
        exit
    }

    return system(sh_test_cmd)
}

function file_isblock(sh_file){
    #usage: file_isblock(f)
    #purpose: returns 1 (true) if file 'f' is a block device; 0 (false) if not
    #example: file_isblock("/etc/passwd") -> 0 (shouldn't be a block dev)
    #         file_isblock("/dev/disk0") -> 1 (if /dev/disk0 is a block dev)
    #notes: these return values permit use of this function in constructs like
    #       'if (file_isblock(file_var)) {body}' with the expected result as
    #       0 is 'false' and 1 (or any other value that's not zero or null) is
    #       'true'
    if ( shc_test("b",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_ischar(sh_file){
    #usage: file_ischar(f)
    #purpose: returns 1 (true) if file 'f' is a character device; 
    #         returns 0 (false) if not
    #notes: see exmaples and notes for file_isblock()
    if ( shc_test("c",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_isdir(sh_file){
    #usage: file_isdir(f)
    #purpose: returns 1 (true) if file 'f' is directory; else returns 0 (false) 
    #notes: see exmaples and notes for file_isblock()
    if ( shc_test("d",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_isthere(sh_file){
    #usage: file_isthere(f)
    #purpose: returns 1 (true) if file 'f' exists; returns 0 (false) if not
    #notes: see exmaples and notes for file_isblock()
    if ( shc_test("e",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_isreg(sh_file){
    #usage: file_isreg(f)
    #purpose: returns 1 (true) if 'f' is a regular file; else returns 0 (false)
    #notes: see exmaples and notes for file_isblock()
    if ( shc_test("f",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_issgid(sh_file){
    #usage: file_issgid(f)
    #purpose: returns 1 (true) if file 'f' has set gid flag set
    #         returns 0 (false) if not
    #notes: see exmaples and notes for file_isblock()
    if ( shc_test("g",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_issticky(sh_file){
    #usage: file_issticky(f)
    #purpose: returns 1 (true) if file 'f' has sticky bit set
    #         returns 0 (false) if not;
    #notes: see exmaples and notes for file_isblock()
    if ( shc_test("k",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_isfifo(sh_file){
    #usage: file_isfifo(f)
    #purpose: returns 1 (true) if file 'f' is a named pipe (FIFO)
    #         returns 0 (false) if not
    #notes: see exmaples and notes for file_isblock()
    if ( shc_test("p",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_isreadable(sh_file){
    #usage: file_isreadable(f)
    #purpose: returns 1 (true) if file 'f' is readable
    #         returns 0 (false) if not
    #notes: see exmaples and notes for file_isblock()
    if ( shc_test("r",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_isnotempty(sh_file){
    #usage: file_isnotempty(f)
    #purpose: returns 1 (true) if file 'f' has a size greater than 0
    #         returns 0 (false) if not
    #notes: see exmaples and notes for file_isblock()
    if ( shc_test("s",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_hasterm(sh_file){
    #usage: file_hasterm(fd)
    #purpose: returns 1 (true) if file descriptor 'fd' is open and associated 
    #         with a terminal; returns 0 (false) if not
    #notes: see exmaples and notes for file_isblock()
    if ( shc_test("t",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_issuid(sh_file){
    #usage: file_issuid(f)
    #purpose: returns 1 (true) if file 'f' has set uid flag set
    #         returns 0 (false) if not
    #notes: see exmaples and notes for file_isblock()
    if ( shc_test("u",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_iswritable(sh_file){
    #usage: file_iswritable(f)
    #purpose: returns 1 (true) if file 'f' is writable
    #         returns 0 (false) 
    #notes: this check only verifies whether the write bit is set. This means
    #       that a file on a read only file system could return 'true' even
    #       thought you can't actually write to it. 
    #       see exaples and notes for file_isblock()
    if ( shc_test("w",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_isexecutable(sh_file){
    #usage: file_isexecutable(f)
    #purpose: returns 1 (true) if file 'f' is executable
    #         returns 0 (false)  if not
    #notes: this check only verifies whether the execute bit is set. For
    #       directories this indicates whether the directory is searchable
    #       see exaples and notes for file_isblock()
    if ( shc_test("x",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_islink(sh_file){
    #usage: file_islink(f)
    #purpose: returns 1 (true) if  file 'f' is a symbolic link
    #         returns 0 (false) if not
    #notes: hard links are indistinguishable from 'regular files' thus 
    #       mitigating potential ambiguity over this functions purpose
    #       see exaples and notes for file_isblock()
    if ( shc_test("L",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_hasmyuid(sh_file){
    #usage: file_hasmyuid(f)
    #purpose: returns 1 (true) if the owner of file 'f' matches the euid of the
    #         current process; returns 0 (false) if not
    #notes: see exmaples and notes for file_isblock()
    if ( shc_test("O",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_hasmygid(sh_file){
    #usage: file_hasmygid(f)
    #purpose: returns 1 (true) if the group of file  'f' matches egid of the
    #         current process; returns 0 (false) if not
    #notes: see exmaples and notes for file_isblock()
    if ( shc_test("G",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_issocket(sh_file){
    #usage: file_issocket(f)
    #purpose: returns 1 (true) if 'f' is a socket; returns 0 (false) if not
    #notes: see exmaples and notes for file_isblock()
    if ( shc_test("S",sh_file) == 0 )
        return 1
    else 
        return 0 
}

function file_newerthan(sh_file1, sh_file2){
    #usage: file_newerthan(f1,f2)
    #purpose: returns 1 (true) if file 'f1' is newer than file 'f2'
    #         returns 0 (false) if not
    if ( shc_test(sh_file1,"nt",sh_file2) == 0 )
        return 1
    else
        return 0
}

function file_olderthan(sh_file1, sh_file2){
    #usage: file_olderthan(f1,f2)
    #purpose: returns 1 (true) if file 'f1' is older than file 'f2'
    #         returns 0 (false) if not
    if ( shc_test(sh_file1,"ot",sh_file2) == 0 )
        return 1
    else
        return 0
}

function file_samefile(sh_file1, sh_file2){
    #usage: file_samefile(f1,f2)
    #purpose: returns 1 (true) if file 'f1' and 'f2' refer to the same file
    #         returns 0 (false) if not
    if ( shc_test(sh_file1,"ef",sh_file2) == 0 )
        return 1
    else
        return 0
}
