module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 983 : index} {
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    return %1 : i1
  }
}
