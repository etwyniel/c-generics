dnl Type agnostic helper macros for creating generic code
dnl
dnl Changing quote characters so the single quote (') can be used in C code
changequote([, ])dnl In case the file is included multiple times and the quotes have already been changed
changequote(«, »)dnl Otherwise this is equivalent to changequote(«,», «'»)
dnl
dnl Making sure _define_all_types only runs once (not strictly necessary)
ifdef(«_GENERICS_M4», «», «define(«_GENERICS_M4»)dnl
dnl Converts a type name into a single token (e.g. "struct MyStruct *" -> "struct_MyStruct_p")
define(«_type_token», «translit(patsubst(«$1», «\*», «_p»), « ,»)»)dnl
dnl
define(«__counter_val__», «0»)dnl
define(«__counter__», «__counter_val__«»define(«__counter_val__», incr(__counter_val__))»)dnl
dnl
define(«myincr», «ifdef(«$1», «define(«$1», incr($1))», «define(«$1», 0)»)»)dnl
define(«mydecr», «define(«$1», decr($1))»)dnl
define(«_localvar», «pushdef(«$1», «$1_»$2)»)dnl
dnl Helper for using local variables in nesting macros without conflicts
define(«_scope», «ifelse(«$#», «1», «$1», «dnl
myincr(«$1_num»)dnl
_localvar(«$1», $1_num)dnl
_scope(shift($@))dnl
popdef(«$1»)dnl
mydecr(«$1_num»)dnl
»)»)dnl
dnl Register a type definition to be written at the top of the output file
define(«_register_type», «pushdef(«_registered_types», «$1»)»)dnl
dnl
define(«_define_all_types», «ifdef(«_registered_types»,dnl
«ifdef(_type_token(«_registered_types»), «»,dnl
«define(_type_token(«_registered_types»))_registered_types;
»)popdef(«_registered_types»)_define_all_types»)»)dnl
dnl
dnl Storing output from including file(s) in a temporary buffer
divert(incr(divnum))dnl In case other scripts are using diversion, not using absolute diversion numbers
dnl At EOF, writing type definitions registered while processing the including file(s),
dnl and restoring their contents to the main buffer (so the types are defined before being used)
m4wrap(«divert(decr(divnum))_define_all_types«»undivert(incr(divnum))»)»)dnl
