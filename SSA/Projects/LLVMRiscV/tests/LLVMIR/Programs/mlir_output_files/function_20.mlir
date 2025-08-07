module {
  func.func @main() -> i1 attributes {seed = 19 : index} {
    %false = arith.constant false
    %false_0 = arith.constant false
    %0 = arith.ori %false, %false_0 : i1
    %false_1 = arith.constant false
    %1 = arith.ceildivsi %0, %false_1 : i1
    return %1 : i1
  }
}
