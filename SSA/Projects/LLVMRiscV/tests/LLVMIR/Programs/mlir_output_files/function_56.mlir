module {
  func.func @main() -> i1 attributes {seed = 55 : index} {
    %false = arith.constant false
    %false_0 = arith.constant false
    %0 = arith.remsi %false, %false_0 : i1
    %true = arith.constant true
    %1 = arith.shrsi %0, %true : i1
    %2 = arith.select %0, %1, %0 : i1
    %3 = arith.subi %1, %2 : i1
    %4 = arith.shrui %3, %0 : i1
    %5 = arith.shrsi %0, %4 : i1
    return %5 : i1
  }
}
