#include <stdio.h>
#include <stdlib.h>

include(`vec.m4')

int main() {
	VEC(int) v;
	v = VEC_NEW(int);
	_vec_double_p(&v);
	printf("capacity: %zu\n", v.cap);
	PUSH_P(&v, 55, 95, 88, 1, 2, 3, 4);
	printf("Data:");
	for (size_t i = 0; i < v.size; i++) {
		printf(" %d", v.data[i]);
	}
	printf("\n");
	printf("size: %zuB\n", sizeof(v));

	free(v.data);
}
