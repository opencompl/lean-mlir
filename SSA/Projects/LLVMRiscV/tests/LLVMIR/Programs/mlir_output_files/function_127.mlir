module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 126 : index} {
    %0 = arith.maxui %arg0, %arg0 : i1
    %false = arith.constant false
    %1 = arith.ori %false, %arg0 : i1
    %2 = arith.floordivsi %0, %1 : i1
    return %2 : i1
  }
}
