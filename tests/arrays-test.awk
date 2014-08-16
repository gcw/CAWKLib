#Code to test array functions
function result(test,outcome) {
    tests++
    printf("%s:\t%s\n",test,outcome)
    if ( outcome == "passed" ) 
        passed++
    if ( outcome == "failed" ) 
        failed++
}

function ary_length_test(array){
    test = "ary_length(): simple length test"
    split("123456789",array,"")
    if (ary_length(array) == 9)
        result(test, "passed")
    else
        result(test, "failed")
}

function ary_width_test(array){
    test = "ary_width(): simple width test"
    array[1,2,3,4,5] = blah
    array["a","b","c","e"] = blah2
    array[1,2,3,4,5,a,b,c] = blah
    if (ary_width(array) == 8)
        result(test, "passed")
    else
        result(test, "failed")
}

function ary_grep_test(test_array){
    test = "ary_grep(): simple grep and catch"
    test_array[1] = "apples oranges tomatoes cucumbers"
    test_array[2] = "strawberries cherries grapes oranges"
    test_array[3] = "mangoes bananas tomatoes"
    test_array[4] = "tangerines mandarins oranges limes lemons"
    test_array[5] = "apples black berries blue berries"
    if ( ary_grep("berries", test_array) == 2 )
        result(test, "passed")
    else
        result(test, "failed")

    test = "ary_grep(): simple grep and retrieval"
    if ( ary_grep("e[rR]", test_array, CAUGHT_LINES ) == 4 )
        result(test, "passed")
    else
        result(test, "passed")
    for (i in CAUGHT_LINES)
        print "\t\t" "CAUGHT_LINES["i "]:" CAUGHT_LINES[i]
}

BEGIN { 
    passed = 0 
    failed = 0 
    ary_length_test()
    ary_width_test()
    ary_grep_test()
    #print "\n\n"
    print "=-=-=-=-=-=-=-=-=-=-=-"
    print "total tested:" tests
    print "=-=-=-=-=-=-=-=-=-=-=-"
    print "total failed:" failed
    print "total passed:" passed
}
