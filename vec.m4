#include <stdlib.h>

include(generics.m4)
dnl
define(`_vec_struct_name', ``struct _vec_'_type_token(`$1')')dnl
define(`_vec_define_type', `_vec_struct_name(`$1')` {size_t cap; size_t size; $1 *data;}'')dnl
define(`VEC', `_register_type(_vec_define_type(`$1'))_vec_struct_name(`$1')')dnl
dnl
define(`VEC_NEW', `ifelse(`$#', `2',dnl
`_scope(`__l', `({size_t __l = $2; (VEC(`$1')) {__l, 0, malloc(__l * sizeof(`$1'))};})')',dnl
`(VEC(`$1')) {0, 0, NULL}')')dnl
define(`VEC_FREE_P', `_scope(`__v', `({__auto_type __v = ($1); free(__v->data); __v->size = 0; __v->cap = 0;})')')
dnl
define(`_vec_double_p', `_scope(`__v', `({dnl
__auto_type __v=($1);dnl
if (__v->cap == 0) __v->cap = 1;dnl
__v->cap*=2;dnl
__v->data=realloc(__v->data,sizeof(*__v->data)*__v->cap);dnl
})')')dnl
dnl
define(`_push_unchecked_p', `($1)->data[($1)->size++]=($2);')dnl
dnl
define(`PUSH_ALL_UNCHECKED_P', `ifelse(`$#', `2',dnl
`_push_unchecked_p($1, $2)',dnl
`ifelse(eval(`$# > 1'), `1',dnl
`_push_unchecked_p(`$1', `$2')PUSH_ALL_UNCHECKED_P(`$1', shift(shift($@)))')')')dnl
dnl
define(`PUSH_P', `_scope(`__v', `({dnl
__auto_type __v = (`$1');dnl
while(__v->size + eval(`$# - 1')>=__v->cap) _vec_double_p(__v);dnl
PUSH_ALL_UNCHECKED_P($@)dnl
__v;})')')dnl
define(`LEN', `($1.size)')dnl
define(`LEN_P', `($1->size)')dnl
