#include <stdlib.h>
#include <assert.h>

include(generics.m4)
dnl
define(`_res_struct_name', ``struct _res_'_type_token(`$1')_`'_type_token(`$2')')dnl
define(`_res_define_type', `_res_struct_name(`$1', `$2')` {char is_ok; union{$1 ok; $2 err;} val;}'')dnl
define(`RESULT', `_register_type(`_res_define_type(`$1', `$2')')_res_struct_name($1, $2)')dnl
define(`OK',  `(_res_struct_name(`$1', `$2')) {1, {.ok = $3}}')
define(`ERR', `(_res_struct_name(`$1', `$2')) {0, {.err = $3}}')
define(`RES_UNWRAP', `_scope(`__r', `({__auto_type __r = ($1); assert(IS_OK(__r)); __r.val.ok;})')')
define(`RES_UNWRAP_ERR', `_scope(`__r', `({__auto_type __r = ($1); assert(IS_ERR(__r)); __r.val.err;})')')
define(`IS_OK', `(`$1'.is_ok == 1)')dnl
define(`IS_ERR', `(`$1'.is_ok == 0)')dnl
