module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 116 : index} {
    %false = arith.constant false
    %0 = arith.floordivsi %arg0, %false : i1
    %1 = arith.ceildivsi %0, %arg0 : i1
    %2 = arith.divui %1, %0 : i1
    return %2 : i1
  }
}
