#include "range.h"

int range_next(struct range_gen *p){
    switch (p->continue_from){
    case 0:
        p->continue_from = 1;
        return p->start;
    case 1:
        if (p->start >= p->end - 2 * p->step){
            p->continue_from = 2;
        } else {
             p->continue_from = 1;
        }
        p->start += p->step;
        return p->start;
    case 2:
        return INT_MAX;
    }
    return INT_MIN;
}

struct gen *range(int start, int end, int step, struct gen *g){
    struct range_gen *p = (struct range_gen *)malloc(sizeof(struct range_gen));
    p->next = range_next;
    p->continue_from = 0;
    p->start = start;
    p->end = end;
    p->step = step;
    p->g = g;
    return (struct gen *)p;
}