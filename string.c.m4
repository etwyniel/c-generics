#include <stdio.h>
#include <stdlib.h>

include(string.m4);

void simple_op() {
    STRING s = STRING("Test");
    for (int i = 0; i < 100000; i++) {
        PUSH_STR(&s, "Test");
    }
    free(s.data);
}

void bench() {
    printf("Running benchmark...\n");
    for (int i = 0; i < 10000; i++) {
        simple_op();
    }
}

int main() {
    STRING s = STRING("Test");
    printf("%s\n", s.data);
    PUSH_STR(&s, ". Adding onto the string.");
    printf("%s\n", s.data);
    printf("Vec len: %zu, strlen: %zu\n", LEN(s), strlen(s.data));
    //bench();
    STRING empty = STRING("");
    PUSH_STR(&empty, "");
    printf("Vec len: %zu, strlen: %zu, cap: %zu\n", LEN(empty), strlen(empty.data), empty.cap);
    PUSH_STR(&empty, " Concatenated");
    STRING conc = CONCAT(&s, &empty);
    printf("%s\n", conc.data);

    VEC_FREE_P(&s);
    VEC_FREE_P(&empty);
    VEC_FREE_P(&conc);
}
