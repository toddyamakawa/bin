
// USAGE: malloc_debug.c
// DESCRIPTION: Debug memory leaks

// https://news.ycombinator.com/item?id=33965665
#define MALLOC_DEBUG(size) malloc(size); printf("malloc %s:%d\n", __FILE__, __LINE__)
#define FREE_DEBUG(ptr) free(ptr); printf("free %s:%d\n", __FILE__, __LINE__)

