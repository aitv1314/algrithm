#include "math.h"
#include "stdio.h"

// straight line interpolation
class Interpolation {
 public:
  void straiht_line_interpolation(int x, int y);

  static void InterPolationTestCase(int x, int y) {
    printf("\nfunc: %s\n", __func__);
    auto ip = new Interpolation;
    ip->straiht_line_interpolation(x, y);

    printf("func: %s end\n", __func__);
  }
};