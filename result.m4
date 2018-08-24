#include <stdlib.h>
#include <assert.h>

include(generics.m4)
dnl
define(`_res_struct_name', ``struct _res_'_type_token(`$1')_`'_type_token(`$2')')dnl
define(`_res_define_type', `_res_struct_name(`$1', `$2')` {char is_ok; union{$1 ok; $2 err;} val;};
'')dnl
define(`_res_define_all_types', `ifdef(`_res_registered_types',dnl
`_res_define_type(dnl
_res_registered_types`'popdef(`_res_registered_types'),dnl
_res_registered_types`'popdef(`_res_registered_types'))_res_define_all_types')')dnl
define(`_res_register_type', `ifdef(`_def_res_$3_$4', `',dnl
`define(`_def_res_$3_$4')pushdef(`_res_registered_types', `$2')pushdef(`_res_registered_types', `$1')')')dnl
define(`RESULT', `_res_register_type(`$1', `$2', `_type_token(`$1')', `_type_token(`$2')')_res_struct_name(`$1', `$2')')dnl
define(`OK',  `(_res_struct_name(`$1', `$2')) {1, {.ok = $3}}')
define(`ERR', `(_res_struct_name(`$1', `$2')) {0, {.err = $3}}')
define(`RES_UNWRAP', `_scope(`__r', `({__auto_type __r = ($1); assert(IS_OK(__r)); __r.val.ok;})')')
define(`RES_UNWRAP_ERR', `_scope(`__r', `({__auto_type __r = ($1); assert(IS_ERR(__r)); __r.val.err;})')')
define(`IS_OK', `(`$1'.is_ok == 1)')dnl
define(`IS_ERR', `(`$1'.is_ok == 0)')dnl
dnl
dnl
divert(incr(divnum))dnl
m4wrap(`divert(decr(divnum))_res_define_all_types`'undivert(incr(divnum))')dnl
