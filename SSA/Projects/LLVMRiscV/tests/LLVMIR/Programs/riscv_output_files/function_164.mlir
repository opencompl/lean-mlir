module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 attributes {seed = 163 : index} {
    %false = arith.constant false
    %0 = arith.cmpi sge, %false, %arg0 : i1
    %false_0 = arith.constant false
    %1 = arith.ceildivui %arg0, %false_0 : i1
    %false_1 = arith.constant false
    %2 = arith.divsi %1, %false_1 : i1
    %3 = arith.maxsi %arg1, %2 : i1
    %4 = arith.andi %0, %3 : i1
    return %4 : i1
  }
}
