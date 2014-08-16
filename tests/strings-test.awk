#Code to test string functions
function result(test,outcome) {
    tests++
    printf("%s:\t%s\n",test,outcome)
    if ( outcome == "passed" ) 
        passed++
    if ( outcome == "failed" ) 
        failed++
}

function str_capitalize_test(string) {
    test = "str_capitalize(): simple mode unset"
    string = "abcd abcd"
    if (str_capitalize(string) == "Abcd abcd" )
        result(test, "passed")
    else
        result(test, "failed")

    test = "str_capitalize(): simple mode unset"
    string = "123aBcD aBCd"
    if (str_capitalize(string) == "123abcd abcd" )
        result(test, "passed")
    else
        result(test, "failed")

    test = "str_capitalize(): simple mode unset"
    string = "aBcD aBCd"
    if (str_capitalize(string) == "Abcd abcd" )
        result(test, "passed")
    else
        result(test, "failed")

    test = "str_capitalize(): double space mode 1"
    string = "Abcd  Abcd"
    if (str_capitalize(string," ") == "Abcd  Abcd")
        result(test, "passed")
    else
        result(test, "failed")

    test = "str_capitalize(): special char mode 1 \"$\""
    string = "abcd$abcd"
    if (str_capitalize(string,"\\$") == "Abcd$Abcd" )
        result(test, "passed")
    else
        result(test, "failed")
}

function str_reverse_test(string){
    test = "str_reverse(): short string"
    string = "abcd1234"
    if (str_reverse(string) == "4321dcba")
        result(test, "passed")
    else
        result(test, "failed")

    test = "str_reverse(): alpha+symbols"
    string = "abc!@#$%^&*()xyz"
    if (str_reverse(string) == "zyx)(*&^%$#@!cba")
        result(test, "passed")
    else
        result(test, "failed")

    test = "str_reverse(): long string"
    string = "1234567890qwertyuiopasdfghjklzxcvbnm1234567890qwertyuiopasdfghjklzxcvbnm,."
    if (str_reverse(string) == ".,mnbvcxzlkjhgfdsapoiuytrewq0987654321mnbvcxzlkjhgfdsapoiuytrewq0987654321")
        result(test, "passed")
    else
        result(test, "failed")
} 

function str_insert_test(string){
    test = "str_insert(): simple insert"
    string = "1234567890"
    insertion = "abc"
    if ( str_insert(string, 5, insertion) == "1234abc567890")
        result(test, "passed")
    else
        result(test, "failed")

    test = "str_insert(): simple negative index (-1)"
    string = "1234567890"
    insertion = "X"
    if ( str_insert(string, -1, insertion) == "123456789X0")
        result(test, "passed")
    else
        result(test, "failed")

    test = "str_insert(): simple negative index (-4)"
    string = "1234567890"
    insertion = "X"
    if ( str_insert(string, -4, insertion) == "123456X7890")
        result(test, "passed")
    else
        result(test, "failed")

    test = "str_insert(): out of bounds index (11)"
    string = "1234567890"
    insertion = "X"
    if ( str_insert(string, 11, insertion) == "1234567890X")
        result(test, "passed")
    else
        result(test, "failed")

    test = "str_insert(): out of bounds index (-11)"
    string = "1234567890"
    insertion = "X"
    if ( str_insert(string, -11, insertion) == "X1234567890")
        result(test, "passed")
    else
        result(test, "failed")
}

function str_squeeze_test(string){
    test = "str_squeeze(): simple squeeze '1223334444'"
    string =  "1223334444"
    if ( str_squeeze(string) == "1234" )
        result(test,"passed")
    else
        result(test,"failed")

    test = "str_squeeze(): simple squeeze '1a22bb333ccc'"
    string =  "1a22bb333ccc"
    if ( str_squeeze(string) == "1a2b3c" )
        result(test,"passed")
    else
        result(test,"failed")

    test = "str_squeeze(): exclusion squeeze '1a22bb333ccc'"
    string =  "1a22bb333ccc"
    if ( str_squeeze(string,"[a-b]") == "1a2bb3c" )
        result(test,"passed")
    else
        result(test,"failed")

    test = "str_squeeze(): exclusion squeeze 'aaa^^$$%%'"
    string =  "aaa^^$$%%"
    if ( str_squeeze(string,"[\\$,\\^]") == "a^^$$%" )
        result(test,"passed")
    else
        result(test,"failed")
}

function str_repeat_test(string){
    test = "string_repeat: abc * 3"
    string = "abc"
    if ( str_repeat(string,3) == "abcabcabc" )
        result(test,"passed")
    else
        print str_repeat_to(string,12)
        #result(test,"failed")
}

function str_repeat_to_test(string){
    test = "string_repeat_to: abc,12"
    string = "abc"
    if ( str_repeat_to(string,12) == "abcabcabcabc" )
        result(test,"passed")
    else
        result(test,"failed")

    test = "string_repeat_to: abcde,7"
    string = "abcde"
    if (str_repeat_to(string,7) == "abcdeab" )
        result(test,"passed")
    else
        result(test,"failed")

    test = "string_repeat_to: <null>, 13"
    string = ""
    if (str_repeat_to(string,13) == "" )
        result(test,"passed")
    else
        result(test,"failed")
        
    test = "string_repeat_to: abc"
    string = "abc"
    if (str_repeat_to(string) == "" )
        result(test,"passed")
    else
        result(test,"failed")

    test = "string_repeat_to: abc, 2"
    string = "abc"
    if (str_repeat_to(string,2) == "ab" )
        result(test,"passed")
    else
        result(test,"failed")
}

function str_center_test(string){
    test = "str_center_test: abc, 11, "
    string = "abc"
    if ( str_center(string,11) == "    abc    " )
        result(test,"passed")
    else
        result(test,"failed")

    test = "str_center_test: abc, 11, '!@#$%^' "
    string = "abc"
    if ( str_center(string,11,"!@#$%^") == "!@#$abc!@#$" )
        result(test,"passed")
    else
        result(test,"failed")

    test = "str_center_test: abc, 5, '*' "
    string = "abc"
    if ( str_center(string,5,"*") == "*abc*" )
        result(test,"passed")
    else
        result(test,"failed")

    test = "str_center_test: abc, 1  "
    string = "abc"
    if ( str_center(string,1) == "abc" )
        result(test,"passed")
    else
        result(test,"failed")
}

function str_match_all_test(string){
    test = "str_match_all_test: abc, 11, "
    string = "abc"
    if ( str_center(string,11) == "    abc    " )
        result(test,"passed")
    else
        result(test,"failed")
}

BEGIN { 
    passed = 0 
    failed = 0 
    str_capitalize_test()
    str_insert_test()
    str_repeat_test()
    str_repeat_to_test()
    str_reverse_test()
    str_squeeze_test()
    str_center_test()
    #print "\n\n"
    print "=-=-=-=-=-=-=-=-=-=-=-"
    print "total tested:" tests
    print "=-=-=-=-=-=-=-=-=-=-=-"
    print "total failed:" failed
    print "total passed:" passed
}
