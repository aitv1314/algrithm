#include "dp.hpp"
#include <map>
#include <iostream>

int Dp1::GetNumOfWays(int n) {
  if (n == 1) return 1;
  if (n == 2) return 2;

  auto iter = ways_.find(n);
  if (iter != ways_.end()) return iter->second;

  int ways = GetNumOfWays(n - 1) + GetNumOfWays(n - 2);
  ways_[n] = ways;
  return ways;
}
