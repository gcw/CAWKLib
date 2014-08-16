#CAWKLib Character Conversion functions
#Author: G. Clifford Williams <gcw (at) notadiscussion.com>
#Purpose: This is a basic set of libraries from the CAWK project made
#         available separately for independent use.
#Notes: These functions were written with the intention of being used
#       with the bangcawk wrapper. I've since reworked them to be more
#       compatible with runawk and a few other wrappers/preprocessors.
#
#------keep if calling with runawk--------#
#use alt_io.awk
#use arrays.awk
#------keep if calling with BangCAWK--------#
#include <alt_io.awk>
#include <arrays.awk>

function str_to_oct(st_base, st_length, st_return){
    #usage: str_to_oct(s[,sep])
    #purpose: returns string 's' encoded as octal values separated by OFS
    #example: str_to_oct("abcd")           --> "Abcd"
    st_length=length(st_base)
    for (st_i = 1; st_i <= st_length; st_i++)
    st_this_char=substr(st_base,st_i,1)
#    if ( st_this_char in st_OCT_TABLE )
        
}

function chr_mk_tables(   ch_i){
    #usage: chr_mk_tables()
    #purpose: generates d2CHAR and c2DEC tables for char 2 decimal and deimal
    #         2 character look-ups. d2CHAR has decimal indices and character 
    #         values c2DEC has character indices and decimal values
    if (! ch_MAX_TABLE_SIZE)
        ch_MAX_TABLE_SIZE = 255
    for (ch_i = 0 ; ch_i <= ch_MAX_TABLE_SIZE ; ch_i++) {
        d2CHAR[ch_i] = sprintf("%c",ch_i)
        c2DEC[d2CHAR[ch_i]] = ch_i
    }
}

function oct_mk_tables(   oc_i){
    #purpose: generates d2OCT and o2DEC tables for octal 2 decimal and deimal
    #         2 octal look-ups. d2OCT has decimal indices and octal values
    #         o2DEC has octal indices and decimal values
    if (! oc_MAX_TABLE_SIZE)
        oc_MAX_TABLE_SIZE = 1025
    for (oc_i = 0 ; oc_i <= oc_MAX_TABLE_SIZE ; oc_i++) {   
        d2OCT[oc_i] = sprintf("%o",oc_i)
        o2DEC[d2OCT[oc_i]] = oc_i
    }

}

function hex_mk_tables( hx_i){
    #purpose: generates d2HEX and h2DEC tables for hexadecimal 2 decimal and
    #         decimal 2 hexadecimal look-ups. d2OCT has decimal indices and 
    #         hexadecimal values h2DEC has hexadecimal indices and decimal 
    #         values
    if (! hx_MAX_TABLE_SIZE)
        hx_MAX_TABLE_SIZE = 1025
    for (hx_i = 0 ; hx_i <= hx_MAX_TABLE_SIZE ; hx_i++) {   
        d2HEX[hx_i] = sprintf("%x",hx_i)
        h2DEC[d2hxT[hx_i]] = hx_i
    }
}

BEGIN {
    oct_mk_tables()
    chr_mk_tables()
    hex_mk_tables()
#    for ( i = 0; i in d2OCT; i++ ) {
#        print "index: " i " VALUE: " d2OCT[i]
#    }
#    for ( i in o2DEC ) {
#        print "index: " i " VALUE: " o2DEC[i]
#    }
#    for ( i = 0; i in d2CHAR; i++ ) {
#        print "index: " i " VALUE: " d2CHAR[i]
#    }
#    for ( i in c2DEC ) {
#        print "index: " i " VALUE: " c2DEC[i]
#    }
#    for ( i = 0; i in d2HEX; i++ ) {
#        print "index: " i " VALUE: " d2HEX[i]
#    }
#    for ( i in h2DEC ) {
#        print "index: " i " VALUE: " h2DEC[i]
#    }


}
