module {
  func.func @main() -> i64 attributes {seed = 28 : index} {
    %c-7735419487501869099_i64 = arith.constant -7735419487501869099 : i64
    %c7921516532864124901_i64 = arith.constant 7921516532864124901 : i64
    %0 = arith.subi %c-7735419487501869099_i64, %c7921516532864124901_i64 : i64
    %1 = arith.shli %0, %0 : i64
    %2 = arith.muli %0, %1 : i64
    return %2 : i64
  }
}
