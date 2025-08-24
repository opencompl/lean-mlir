module {
  func.func @main() -> i1 attributes {seed = 155 : index} {
    %true = arith.constant true
    %false = arith.constant false
    %0 = arith.subi %true, %false : i1
    %1 = arith.addi %0, %0 overflow<nuw> : i1
    %2 = arith.divsi %1, %1 : i1
    return %2 : i1
  }
}
