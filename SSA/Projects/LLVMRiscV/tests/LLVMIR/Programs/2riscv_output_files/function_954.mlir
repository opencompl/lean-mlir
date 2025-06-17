module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 953 : index} {
    %0 = llvm.or %arg1, %arg0 {isDisjointFlag} : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    return %1 : i1
  }
}
