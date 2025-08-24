module {
  func.func @main() -> i1 attributes {seed = 152 : index} {
    %false = arith.constant false
    %false_0 = arith.constant false
    %0 = arith.remui %false, %false_0 : i1
    %false_1 = arith.constant false
    %1 = arith.muli %0, %false_1 : i1
    %2 = arith.remui %0, %1 : i1
    %3 = arith.remsi %0, %2 : i1
    return %3 : i1
  }
}
