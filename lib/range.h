#ifndef RANGE_H
#define RANGE_H

#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include "gen.h"

struct range_gen{
    int (*next)();
    int continue_from;
    int start;
    int end;
    int step;
    struct gen *g;
};

int range_next(struct range_gen *);

struct gen *range(int, int, int, struct gen *);

#endif