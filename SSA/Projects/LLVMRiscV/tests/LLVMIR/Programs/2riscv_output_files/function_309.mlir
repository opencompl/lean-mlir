module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 308 : index} {
    %0 = llvm.or %arg0, %arg1 {isDisjointFlag} : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    return %1 : i1
  }
}
