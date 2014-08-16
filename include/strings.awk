#CAWKLib string functions
#Author: G. Clifford Williams <gcw (at) notadiscussion.com>
#Purpose: This is a basic set of libraries from the CAWK project made
#         available separately for independent use.
#Notes: These functions were written with the intention of being used
#       with the bangcawk wrapper. I've since reworked them to be more
#       compatible with runawk and a few other wrappers/preprocessors.

function str_capitalize(st_base, st_sep,    st_return, st_offset,\
                        st_old_offset, st_old_rl ,st_old_rs){
    #usage: str_capitalize(s[,sep])
    #purpose: returns string 's' with first character capitalized and the rest
    #         lowercase. if seperator 'sep' is set, every character in 's'
    #         that comes after 'sep' is treated as the beginning of a new
    #         string to be capitalized. 
    #example: str_capitalize("abcd")           --> "Abcd"
    #         str_capitalize("aBCD")           --> "Abcd"
    #         str_capitalize("123aBCD")        --> "123abcd"
    #         str_capitalize("12 bc"," ")      --> "12 Bc"
    #         str_capitalize("a:b:cd",":")     --> "A:B:Cd"
    #         str_capitalize("a$b$cd","$")     --> <infinite loop: see notes>
    #         str_capitalize("a$b$cd","\\$")   --> "A$B$Cd"
    #         str_capitalize("a$b$cd","[$]")   --> "A$B$Cd"
    #notes: Separator is a regular expression which means that regex meta
    #       characters ($,^,.,[,],|,(,),*,+,?) may need to be escaped with '\'
    #       '\\' would match a literal back slash. In most awk implementations
    #       '\\$' will resolve to '\$'. Alternately, you can use character
    #       classes '[]' in some cases to avoid meta character peculiarities
    if ( ! st_sep ) {
        st_return =  toupper(substr(st_base,1,1)) tolower(substr(st_base,2))
    }else{
        st_old_rl = RLENGTH
        st_old_rs = RSTART
        st_return = str_capitalize(st_base)
        while (match(substr(st_return,st_offset),st_sep) != 0) {
            st_offset = RSTART + RLENGTH + st_old_offset
            st_return = substr(st_return,1,st_offset - 1)\
                         str_capitalize(substr(st_return, st_offset))
            st_old_offset = st_offset - 1
        }
        RLENGTH = st_old_rl 
        RSTART = st_old_rs 
    }
     return st_return
}

function str_insert(st_base, st_index, st_ins,  st_length,st_return){
    #usage: str_insert(s1,i,s2)
    #purpose: returns string 's1' with string 's2' inserted at index 'i'
    #example: str_insert("12345",3,"X")  --> "12X345"
    #         str_insert("12345",5,"X")  --> "1234X5"
    #         str_insert("12345",-1,"X") --> "1234X5"
    #         str_insert("12345",-4,"X") --> "1X2345"
    #notes: if index is out of bounds 's2' will be either prepended
    #       or appended to the given string. negative numbers are treated
    #       as offsets from the end of 's1'. 1 is the first character
    #       -1 is the last character. 
    
    st_length = length(st_base)
    if ( ! st_ins ) {
        print "str_insert(): we need three parameters"
        exit 1
    }
    if ( st_index < 0 ) {
        st_index = ( st_length + 1 + st_index ) 
    }
    if (st_index <= 1) {  
        st_return = st_ins st_base
    }else if ( st_index > st_length ) {
        st_return = st_base st_ins
    }else {
        st_return = substr(st_base, 1, st_index - 1) st_ins \
                     substr(st_base, st_index)
    }
    return st_return
}

function str_repeat(st_base, st_num,   st_remain, st_return ) { 
    #usage: str_repeat(s,n)
    #purpose: repeat string 's' 'n' number of times. 
    #notes: this implementation comes entirely from Ben Zanin. it's _much_ more
    #       efficient than a for loop that concatenates iteratively. 
    #       
    if (st_num < 2) {
        st_remain = (st_num == 1)
    } else {
        st_remain = (st_num % 2 == 1)
        st_return = str_repeat(st_base, (st_num - st_remain) / 2)
    }
    st_return = st_return st_return
    if (st_remain) 
        st_return = st_return  st_base 
    return st_return    
}

function str_repeat_to(st_base, st_dest_len,   st_base_len,\
                        st_reps,st_return ){
    #usage: str_repeat_to(s,l)
    #purpose: returns a string of length 'l' made from cycling through
    #         characters in string 's'. If length is unspecified, null, or 0
    #         or if string has a length of 0, a single null is returned.
    #example: str_repeat_to("abc",12)   --> "abcabcabcabc"
    #         str_repeat_to("abc",13)   --> "abcabcabcabca"
    #         str_repeat_to("abc",4)    --> "abca"
    #         str_repeat_to("abc",2)    --> "ab"
    #         str_repeat_to("",2)       --> ""
    #         str_repeat_to("abc")      --> ""
    #calls: str_repeat()
    st_base_len = length(st_base)
    if ( st_dest_len == 0 || st_base_len == 0 ) {
        st_return = ""
    }else if ( st_dest_len >= 1 && st_dest_len <= st_base_len ) {
        st_return = substr(st_base,1,st_dest_len)
    }else if ( st_dest_len % st_base_len ) {
        st_reps = int( st_dest_len / st_base_len  + 1 )
        st_return = substr(str_repeat(st_base,st_reps),1,st_dest_len)
    }else{
        st_reps = st_dest_len / st_base_len
        st_return = substr(str_repeat(st_base,st_reps),1,st_dest_len)
    }
    return st_return
}

function str_reverse(st_base,    st_i, st_return ) {
    #usage: str_reverse(s)
    #purpose: returns 's' with characters reversed (eg. st_reverse("abc")
    #         would return "cba").
    for ( st_i = length(st_base) ; st_i > 0 ; st_i--) {
        if ( st_return ) 
            st_return = st_return substr(st_base,st_i,1)
        else 
            st_return = substr(st_base, st_i, 1)
    }
    return st_return
}

function str_squeeze(st_base, st_exclsn,   st_i, st_current,\
                        st_last, st_return){
    #usage: str_squeeze(s,exclsn)
    #purpose: return string 's' with runs of the same character reduced to 1
    #         instance of said character. Characters matching the regex 
    #         'exclsn' are not reduced
    #example: str_squeeze("Hello root")          --> "Helo rot"
    #         str_squeeze("___the----boot")      --> "_the-bot"
    #         str_squeeze("yellow pool","l") --> "yellow pol"
    #         str_squeeze("1223334444","[1-3]") --> "1223334"
    #notes: The match case here is done on a character by character basis which
    #       means that the exclusion regex cannot be used to negate a character
    #       based on the number of inclusions of that char. str_squeeze(s,"l")
    #       is the same as str_squeeze(s,"llll") as far as the matching engine
    #       is concerned. 
    #       Also, note that special characters will have to be escaped here as
    #       in str_capitalize() when it comes to the regex for exclusions
    for ( st_i = 1; st_i <= length(st_base) ; st_i++ ) {
        st_current = substr(st_base,st_i,1)
        if (! st_exclsn){
            if ( st_current != st_last )
                st_return = st_return st_current
        }else{
            if (st_current != st_last || st_current ~ st_exclsn)
                st_return = st_return st_current
        }
        st_last = st_current
    }
    return st_return
}

function str_center(st_base, st_dest_len, st_fill,   st_base_len,\
                    st_pad_right_len, st_pad_left_len, st_pad_len,\
                    st_pad_right, st_pad_left){
    #usage: str_center(s1,l[,s2])
    #purpose: return a string of length 'l' with string 's1' centered and
    #         and padded. If s2 is supplied it will be used to pad the new
    #         string. If length is not greater than the length of s1, return s1
    #example: str_center("abcd",10)             --> "   abcd   "
    #         str_center("abcd",10, ".")        --> "...abcd..."
    #         str_center("abcd",10, "1234567")  --> "123abcd123"
    #         str_center("abcd",1, ".")         --> "abcd"
    #calls: str_repeat_to()
    st_base_len = length(st_base)
    if ( st_base_len >= st_dest_len )
        return st_base
    if ( ! st_fill ) 
        st_fill = " "
    st_pad_len = st_dest_len - st_base_len
    st_pad_left_len = int(st_pad_len / 2)
    if (st_pad_len % 2)
        st_pad_right_len = int(st_pad_left_len = st_pad_len / 2) + 1
    else 
        st_pad_right_len = int(st_pad_left_len = st_pad_len / 2)
    st_pad_left = str_repeat_to(st_fill, st_pad_left_len)
    st_pad_right = str_repeat_to(st_fill, st_pad_right_len)
    return st_pad_left st_base st_pad_right
}

function str_matches(st_base, pt_base, ary_match_catch, st_old_rs, st_old_rl,
                        st_old_offset, st_offset, match_count ){
    #usage: str_matches(s, p[, a])
    #purpose: search string 's' for pattern 'p'. Return the total number of
    #         (non-nested) longest-matches of pattern 'p' in string 's'. 
    #         if optional array [a] is supplied it is populated as followes:
    #               a[n]            = value of match #n
    #               a[n,"START"]    = index of first char of match 1
    #               a[n,"LENGTH"]   = length of match #n
    #               here 'n' is a number less than or equal to the total number
    #               of matches.
    #example:
    #   str_matches( "cat dog fox", "[a-z]o[a-z]", matches )  -->   2  
    #       In the above example matches[1] would be set to "dog", 
    #       matches[1,"START"] will be set to 5 and matches[1,"LENGTH"] will
    #       be set to 3
    #   str_matches( "x a b c o", "[abc]" )                   -->   3
    #       In the above example there is not optional array to populate with
    #       with values, starting points, and lengths. 
    #   str_matches( "a b c d e f",/[abc]/)                   --> ERROR
    #       Invalid parameter (second argument should be "[abc]" instead of 
    #       /[abc]/
    #notes: your patterns should not be regex literals beginning and ending with 
    #       '/', instead they should be strings in double quotes. 

    if (RSTART)
        st_old_rs = RSTART
    if (RLENGTH)
        st_old_rl = RLENGTH
    st_base_len = length(st_base) 
    
    st_offset = 1
    #st_end = st_base_len
    while (match(substr(st_base, st_offset), pt_base)) {
        st_offset = RSTART + RLENGTH + st_old_offset
        ary_match_catch[++match_count] = substr(st_base, 
                                                st_old_offset + RSTART,
                                                RLENGTH)
        ary_match_catch[match_count,"START"] = RSTART + st_old_offset
        ary_match_catch[match_count,"LENGTH"] = RLENGTH
        st_old_offset = st_offset - 1
    }
    if (st_old_rs)
        RSTART = st_old_rs
    if (st_old_rl)
        RLENGTH = st_old_rl
    return match_count
}
