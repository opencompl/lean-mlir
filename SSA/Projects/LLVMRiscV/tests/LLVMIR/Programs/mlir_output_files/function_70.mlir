module {
  func.func @main() -> i1 attributes {seed = 69 : index} {
    %true = arith.constant true
    %true_0 = arith.constant true
    %0 = arith.ceildivui %true, %true_0 : i1
    return %0 : i1
  }
}
