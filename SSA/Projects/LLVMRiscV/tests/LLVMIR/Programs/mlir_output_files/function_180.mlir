module {
  func.func @main() -> i1 attributes {seed = 179 : index} {
    %false = arith.constant false
    %false_0 = arith.constant false
    %0 = arith.maxsi %false, %false_0 : i1
    return %0 : i1
  }
}
