/*
一只青蛙一次可以跳上1级台阶，也可以跳上2级台阶。求该青蛙跳上一个 10 级的台阶总共有多少种跳法。
*/

#include <map>
#include <ctime>
#include <iostream>

class Dp1 {
 public:
  int GetNumOfWays(int n);

  static void DpTestCase1(int n) {
    auto dp1 = new Dp1;

    std::time_t t1 = std::time(0);
    int ways = dp1->GetNumOfWays(n);
    std::time_t t2 = std::time(0);
    std::cout << "n = " << n << "; ways = " << ways << "; time cost = " << t2 - t1 << "s" << std::endl;
  }

 public:
  std::map<int, int> ways_;
};