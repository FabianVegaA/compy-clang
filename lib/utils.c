#include "range.h"

int main(){
    struct gen *g = range(0, 10, 2, NULL);
    int next;

    do{
        next = g->next(g);
        if (next == INT_MAX){
            printf("StopIteration\n");
            break;
        }
        printf("%d\n", next);
    } while (1);

    return 0;
}