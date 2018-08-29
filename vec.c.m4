#include <stdio.h>
#include <stdlib.h>

include(vec.m4)

int main() {
	VEC(int) v;
	v = VEC_NEW(int);
	printf("capacity: %zu\n", v.cap);
	PUSH_P(&v, 55, 95, 88, 1, 2, 3, 4);
	printf("Data:");
	for (size_t i = 0; i < v.size; i++) {
		printf(" %d", v.data[i]);
	}
	printf("\n");
	printf("size: %zuB\n", sizeof(v));

	size_t end = 7;
	SLICE(int) sl = VEC_SLICE(int, &v, :end);
	printf("Slice length: %zu\n", sl.size);
	for (size_t i = 0; i < sl.size; i++) {
		printf("slice[%zu]: %d\n", i, sl.data[i]);
	}

	free(v.data);
}
