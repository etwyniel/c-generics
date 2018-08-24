#include <stdio.h>
#include <stdlib.h>

#include <stdlib.h>

struct _vec_int {size_t cap; size_t size; int *data;};

struct _vec_int {size_t cap; size_t size; int *data;};





int main() {
	struct _vec_intdnl
 v;
	v = (struct _vec_intdnl
) {0, 0, NULL};
	({__auto_type __v__local_0=(&v);if (__v__local_0->cap == 0) __v__local_0->cap = 1;__v__local_0->cap*=2;__v__local_0->data=realloc(__v__local_0->data,sizeof(*__v__local_0->data)*__v__local_0->cap);});
	printf("capacity: %zu\n", v.cap);
	({__auto_type __v__local_1 = (&v);while(__v__local_1->size + 7>=__v__local_1->cap) ({__auto_type __v__local_2=(__v__local_1);if (__v__local_2->cap == 0) __v__local_2->cap = 1;__v__local_2->cap*=2;__v__local_2->data=realloc(__v__local_2->data,sizeof(*__v__local_2->data)*__v__local_2->cap);});(&v)->data[(&v)->size++]=(55);(&v)->data[(&v)->size++]=(95);(&v)->data[(&v)->size++]=(88);(&v)->data[(&v)->size++]=(1);(&v)->data[(&v)->size++]=(2);(&v)->data[(&v)->size++]=(3);(&v)->data[(&v)->size++]=(4);__v__local_1;});
	printf("Data:");
	for (size_t i = 0; i < v.size; i++) {
		printf(" %d", v.data[i]);
	}
	printf("\n");
	printf("size: %zuB\n", sizeof(v));

	free(v.data);
}
