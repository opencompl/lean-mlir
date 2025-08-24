module {
  func.func @main() -> i1 attributes {seed = 97 : index} {
    %true = arith.constant true
    %false = arith.constant false
    %0 = arith.remsi %true, %false : i1
    %1 = arith.maxsi %0, %0 : i1
    return %1 : i1
  }
}
