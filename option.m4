#include <assert.h>


include(generics.m4)
dnl Use to define functions/variables
define(`_opt_struct_name', ``struct _option_'_type_token(`$1')')dnl
define(`_opt_register_type', `ifdef(`_def_option_$2', `', `define(`_def_option_$2')pushdef(`_opt_registered_types', `$1')')')dnl
define(`_opt_define_type', `_opt_struct_name(`$1') {char is_some; $1 data;};
')dnl
define(`_opt_define_all_types', `ifdef(`_opt_registered_types', `_opt_define_type(_opt_registered_types)popdef(`_opt_registered_types')_opt_define_all_types')')dnl
define(`OPTION', `_opt_register_type(`$1', `_type_token(`$1')')_opt_struct_name(`$1')')dnl
dnl
dnl Use to create option values
define(`SOME', `(_opt_struct_name($1)) {1, $2}')dnl
define(`NONE', `(_opt_struct_name($1)) {0}')dnl
dnl
dnl For operating on options
define(`IS_SOME', `(($1).is_some == 1)')dnl
define(`IS_NONE', `(($1).is_some == 0)')dnl
define(`OPT_UNWRAP', `_scope(`__o', `({__auto_type __o = ($1); assert(IS_SOME(__o)); __o.data;})')')dnl
define(`OPT_UNWRAP_OR', `_scope(`__o', `({__auto_type __o = ($1); IS_SOME(__o) ? __o.data : ($2);})')')dnl
dnl
dnl For operating on pointers to option
define(`IS_SOME_P', `(($1)->is_some == 1)')dnl
define(`IS_NONE_P', `(($1)->is_some == 0)')dnl
define(`OPT_UNWRAP_P', `_scope(`__o', `({__auto_type __o = ($1); assert(IS_SOME_P(__o)); __o->data;})')')dnl
define(`OPT_UNWRAP_OR_P', `_scope(`__o', `({__auto_type __o = ($1); IS_SOME_P(__o) ? __o->data : ($2);})')')dnl
dnl
divert(incr(divnum))dnl
m4wrap(`divert(decr(divnum))_opt_define_all_types`'undivert(incr(divnum))')dnl
