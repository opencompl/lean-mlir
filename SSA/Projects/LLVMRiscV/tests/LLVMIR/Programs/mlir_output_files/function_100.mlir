module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 99 : index} {
    %true = arith.constant true
    %0 = arith.cmpi ne, %arg0, %true : i1
    return %0 : i1
  }
}
