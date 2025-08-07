module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 attributes {seed = 77 : index} {
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.mul %0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
