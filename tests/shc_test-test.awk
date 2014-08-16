#Code to test shc_test functions
#Notes: this set of tests makes some very basic assumptions ( like / is a 
#       directory, / is not empty, etc) many tests cannot be implemented 
#       without making more assumptions that would have a great potential for
#       being wrong. For this reason the tests in this set are limited to a few
#       for basic functionality on the higher level wrapper functions
function result(test,outcome) {
    tests++
    printf("%s:\t%s\n",test,outcome)
    if ( outcome == "passed" ) 
        passed++
    if ( outcome == "failed" ) 
        failed++
    if ( outcome == "none" ) 
        unimplemented++
}

function file_isblock_test(file) {
    test = "file_isblock:is / (not) a block dev"
    file = "/"
    if (! file_isblock(file) )
        result(test, "passed")
    else
        result(test, "failed")
}

function file_ischar_test(file) {
    test = "file_ischar():is / (not) a character"
    file = "/"
    if (! file_ischar(file) )
        result(test, "passed")
    else
        result(test, "failed")
}

function file_isdir_test(file) {
    test = "file_isdir: is / a directory"
    file = "/"
    if (file_isdir(file))
        result(test, "passed")
    else
        result(test,"failed")
}

function file_isthere_test(file) {
    test = "file_isthere: does / exist"
    file = "/"
    if (file_isthere(file))
        result(test, "passed")
    else
        result(test, "failed")
}

function file_isreg_test(file) {
    test = "file_isreg: is / (not) a 'regular' file"
    file = "/"
    if (! file_isreg(file))
        result(test, "passed")
    else
        result(test, "failed")
}

function file_issgid_test(file) {
    test = "file_issgid: unimplemented"
    result(test, "none")
}

function file_issticky_test(file) {
    test = "file_issticky: is /tmp/ sticky "
    result(test, "none")
}

function file_isfifo_test(fifo) {
    test = "file_isfifo: is / (not) a fifo"
    file = "/"
    if (! file_isfifo(file))
        result(test,"passed")
    else
        result(test,"failed")
}

function file_isreadable_test(file) {
    test = "file_isreadable(): unimplemented"
    result(test,"none")
}

function file_isnotempty_test(file) {
    test = "file_isnotempty_test(): is / (not) empty"
    file = "/"
    if (file_isnotempty(file))
        result(test,"passed")
    else
        result(test,"failed")
}

function 

BEGIN { 
    passed = 0 
    failed = 0 
    file_isblock_test() 
    file_ischar_test() 
    file_isdir_test()
    file_isthere_test()
    file_isreg_test()
    file_issgid_test()
    file_issticky_test()
    file_isfifo_test()
    file_isreadable_test()
    file_isnotempty_test()

    print "=-=-=-=-=-=-=-=-=-=-=-"
    print "total tested:" tests
    print "=-=-=-=-=-=-=-=-=-=-=-"
    print "total failed:" failed
    print "total passed:" passed
    print "total unimplemented:" unimplemented
}
