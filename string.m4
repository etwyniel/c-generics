#include <string.h>

include(vec.m4);
include(generics.m4);
define(`PUSH_STR', `_scope(`__s', `__l', `__v',dnl
`({char *__s = ($2); VEC(char) *__v = ($1); size_t __l = strlen(__s) + 1;dnl
if (__v->cap == 0) __v->cap = 1;dnl
while(__v->cap < __v->size + __l) {_vec_double_p(__v);}dnl
memcpy(__v->data + __v->size, __s, __l);dnl
__v->size += __l - 1; __v;})')')dnl
dnl
define(`STRING', `ifelse(`$#', `0', `VEC(char)', `_scope(`__v', `__s', `({dnl
char *__s = ($1);dnl
VEC(char) __v = VEC_NEW(char, strlen(__s) + 1);dnl
PUSH_STR(&__v, __s);dnl
__v;dnl
})')')')dnl
dnl
define(`CONCAT', `_scope(`__s1', `__s2', `__s3', `({dnl
VEC(char) *__s1 = ($1); VEC(char) *__s2 = ($2);dnl
VEC(char) __s3 = VEC_NEW(char, LEN_P(__s1) + LEN_P(__s2) + 1);dnl
memcpy(__s3.data, __s1->data, LEN_P(__s1));dnl
memcpy(__s3.data + LEN_P(__s1), __s2->data, LEN_P(__s2));dnl
__s3.size = LEN_P(__s1) + LEN_P(__s2);dnl
__s3;dnl
})')')dnl
