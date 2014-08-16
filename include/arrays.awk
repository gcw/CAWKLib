#CAWKLib array functions
#Author: G. Clifford Williams <gcw (at) notadiscussion.com>
#Purpose: This is a basic set of libraries from the CAWK project made
#         available separately for independent use.
#Notes: These functions were written with the intention of being used
#       with the bangcawk wrapper. I've since reworked them to be more
#       compatible with runawk and a few other wrappers/preprocessors.


function ary_length(ar_base,    ar_i, ar_return){
    #usage:ary_length(a)
    #purpose: returns the total number of defined elements in array 'a'
    for (ar_i in  ar_base) {
        ar_return++
    }
    return ar_return
}

function ary_width(ar_base,    ar_i, ar_current_width, ar_return){
    #usage:ary_width(a)
    #purpose: returns the width of array 'a'
    #notes: In this case width is number of elements in the 'widest' index
    for (ar_i in ar_base){
        ar_current_width = gsub(SUBSEP,SUBSEP,ar_i)
        if (ar_current_width > ar_return)
            ar_return = ar_current_width
    }
    return ++ar_return
}

function ary_choice(ar_base,   ar_i, ar_selected) {
    #usage: ary_choice(a)
    #purpose: return a random index from array 'a' 
    #calls: ary_length()
    #notes: this function does NOT call srand() to seed the PSNG. This
    #       means that values can be 'pushed' by seeding appropriately before
    #       the call to ary_choice(). You should do what ever is required for
    #       your version of awk to get good random values from rand() before
    #       using ary_choice()
    ar_selected = int(rand() * ary_length(ar_base) - 1) + 1
    for ( ar_i in ar_base )  { 
        if ( --ar_selected  == 0 ) 
        return ar_i
    }
}

function ary_grep(pt_base, ar_base, A_GREP_MATCHES,      ar_i, ar_match_count ){
    #usage: ary_grep( p, a1[, a2])
    #purpose: search through array 'a1' for pattern 'p'. Return the number of
    #         array elements matched. Array 'a2' (if set) is populated as such:
    #           a2[1] : index of element with first match (if applicable)
    #           a2[2] : index of element with second match (if applicable)
    #           a2[3] : index of element with third match (if applicable)
    #notes:
    #         to access the lines with matches one could use the following:
    #           matched_line = a1[a2[1]]
    for ( ar_i in ar_base ) {
        if ( ar_base[ar_i] ~ pt_base ) {
            ar_match_count++
            A_GREP_MATCHES[ar_match_count] = ar_i
        }
    }
    return ar_match_count
}
