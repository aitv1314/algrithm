/*
一只青蛙一次可以跳上1级台阶，也可以跳上2级台阶。求该青蛙跳上一个 10 级的台阶总共有多少种跳法。
*/

#include <map>
#include <chrono>
#include <iostream>

class Dp1 {
 public:
  int GetNumOfWays(int n);

  static void DpTestCase1(int n) {
    std::cout << "func: " << __func__ << std::endl;

    auto dp1 = new Dp1;
    uint64_t t1 =
        std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch())
            .count();

    int ways = dp1->GetNumOfWays(n);

    uint64_t t2 =
        std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch())
            .count();

    std::cout << "n = " << n << "; ways = " << ways << "; time cost = " << t2 - t1 << "ns" << std::endl;
    std::cout << "func: " << __func__ << " end" << std::endl;
  }

 public:
  std::map<int, int> ways_;
};