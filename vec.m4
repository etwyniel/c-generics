#include <stdlib.h>
#include <assert.h>

include(generics.m4)
dnl
define(`_vec_struct_name', ``struct _vec_'_type_token(`$1')')dnl
define(`_vec_define_type', `_vec_struct_name(`$1')` {size_t cap; size_t size; $1 *data;}'')dnl
define(`VEC', `_register_type(_vec_define_type(`$1'))_vec_struct_name(`$1')')dnl
define(`_slice_struct_name', ``struct _slice_'_type_token(`$1')')dnl
define(`_slice_define_type', `_slice_struct_name(`$1')` {size_t size; $1 *data;}'')dnl
define(`SLICE', `_register_type(_slice_define_type(`$1'))_slice_struct_name(`$1')')dnl
dnl
define(`VEC_NEW', `ifelse(`$#', `2',dnl
`_scope(`__l', `({size_t __l = $2; (VEC(`$1')) {__l, 0, malloc(__l * sizeof(`$1'))};})')',dnl
`(VEC(`$1')) {0, 0, NULL}')')dnl
define(`VEC_FREE_P', `_scope(`__v', `({__auto_type __v = ($1); free(__v->data); __v->size = 0; __v->cap = 0;})')')dnl
dnl
define(`_vec_slice_p', `_scope(`__l1', `__l2', `__v', `dnl
({size_t __l1 = ($3); size_t __l2 = ($4); __auto_type __v = ($2);dnl
assert(__l1 <= __l2 && __l2 <= __v->size); (SLICE(`$1')) {__l2 - __l1, __v->data + __l1};})')')dnl
dnl
define(`VEC_SLICE', `pushdef(`__pos', index(`$3', `:'))dnl
pushdef(`__start', `ifelse(__pos, `0', `0', `substr(`$3', `0', __pos)')')dnl
pushdef(`__end', `ifelse(__pos, `eval(len(`$3') - 1)', `LEN_P(`$2')', `substr(`$3', eval(__pos + 1))')')dnl
_vec_slice_p(`$1', `$2', `__start', `__end')dnl
popdef(`__pos', `__start', `__end')')dnl
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
