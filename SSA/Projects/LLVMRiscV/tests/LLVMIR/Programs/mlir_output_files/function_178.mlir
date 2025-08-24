module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 177 : index} {
    %true = arith.constant true
    %0 = arith.ori %true, %arg0 : i1
    return %0 : i1
  }
}
