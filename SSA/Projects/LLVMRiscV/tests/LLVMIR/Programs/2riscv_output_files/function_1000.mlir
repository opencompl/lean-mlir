module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 999 : index} {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    return %1 : i64
  }
}
