module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 attributes {seed = 113 : index} {
    %0 = arith.select %arg0, %arg0, %arg1 : i1
    %1 = arith.cmpi ugt, %arg0, %0 : i1
    return %1 : i1
  }
}
