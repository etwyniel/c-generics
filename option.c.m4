#include <stdlib.h>
#include <stdio.h>

include(`option.m4')

OPTION(int) side_effects(int num) {
	printf("I'm side effect n°%d\n", num);
	//return SOME(int, 101);
	return NONE(int);
}

OPTION(void*) omalloc(size_t size) {
	void* ptr = malloc(size);
	return ptr ? SOME(void*, ptr) : NONE(void*);
}

OPTION(char *) *test_string() {
	OPTION(char *) *r = OPT_UNWRAP(omalloc(sizeof(OPTION(char *))));
	*r = SOME(char *, "Hello World");
	return r;
}

OPTION(int) test() {
	//return SOME(int, 5);
	return NONE(int);
}

int main() {
	int c = 20;
	int k = OPT_UNWRAP_OR(side_effects(1), {printf("Assigning c to k\n"); c;});
	printf("k: %d\n", k);
	int* i = OPT_UNWRAP_OR(omalloc(sizeof(int)), {_Exit(1); NULL;});
	OPTION(int) x = test();
	if (IS_SOME(x)) {
		printf("Got some: %d\n", OPT_UNWRAP(x));
	} else {
		printf("Got none, default: %d\n", OPT_UNWRAP_OR(x, 99));
	}

	OPTION(char *) *str = test_string();
	if (IS_SOME_P(str)) {
		printf("Got some: %s\n", OPT_UNWRAP_P(str));
	}
	free(i);
	free(str);
	return 0;
}
