dnl Type agnostic helper macros for creating generic code
define(`_type_token', `patsubst(translit(`$1', ` '), `\*', `_p')')dnl
define(`__counter_val__', `0')dnl
define(`__counter__', `__counter_val__`'define(`__counter_val__', incr(__counter_val__))')dnl
define(`_localvar', `pushdef(`$1', `$1__local_'__counter__)')dnl
define(`_scope', `ifelse(`$#', `1', `$1', `_localvar(`$1')_scope(shift($@))popdef(`$1')')')dnl
dnl
define(`_register_type', `pushdef(`_registered_types', `$1')')dnl
dnl
define(`_define_all_types', `ifdef(`_registered_types',dnl
`ifdef(_type_token(`_registered_types'), `',dnl
`define(_type_token(`_registered_types'))_registered_types;
')popdef(`_registered_types')_define_all_types')')dnl
dnl
divert(incr(divnum))dnl
m4wrap(`divert(decr(divnum))_define_all_types`'undivert(incr(divnum))')dnl
