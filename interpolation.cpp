// straight line interpolation

#include "interpolation.hpp"

void Interpolation::straiht_line_interpolation(int x, int y) {
  // position now
  int draw[2] = {0, 0};

  // E:target position
  // F:future
  // i:interpolation step
  // error

  int E, error, F, i;

  E = abs(x) + abs(y);
  F = 0;

  // E determines circle times
  for (i = 0; i < E; ++i) {
    // step 1 : compute F to firgure out where to go next(x and y)
    if (F >= 0) {
      // step 2 : figure out forward or backward by target position
      if (x > 0)
        ++draw[0];
      else
        --draw[0];

      // step 3 : compute new error
      error = abs(1 * y - 0 * x);
      F = F - error;

      printf("(%d,%d)\r\n", draw[0], draw[1]);
    } else {
      if (y > 0)
        ++draw[1];
      else
        --draw[1];

      error = abs(0 * y - 1 * x);
      F = F + error;

      printf("(%d,%d)\r\n", draw[0], draw[1]);
    }
  }
}