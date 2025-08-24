module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 118 : index} {
    %true = arith.constant true
    %0 = arith.remsi %true, %arg0 : i1
    %1 = arith.ceildivui %arg0, %0 : i1
    return %1 : i1
  }
}
