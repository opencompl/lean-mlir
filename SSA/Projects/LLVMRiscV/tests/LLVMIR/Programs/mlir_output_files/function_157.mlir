module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 156 : index} {
    %true = arith.constant true
    %0 = arith.remsi %true, %arg0 : i1
    %1 = arith.ori %arg0, %0 : i1
    return %1 : i1
  }
}
