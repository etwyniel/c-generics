#include <stdlib.h>
#include <stdio.h>

include(option.m4);
include(vec.m4);
include(string.m4);
include(result.m4);

OPTION(double) d;

RESULT(int, char) test() {
    return OK(int, char, 200);
}

int main() {
    RESULT(int, char) r = test();
    printf("Ok(%d)\n", RES_UNWRAP(r));
    RESULT(int, STRING) s = ERR(int, STRING, STRING("This is an error."));
    printf("%s\n", RES_UNWRAP_ERR(s).data);
    printf("size: %zuB\n", sizeof(s));
}
