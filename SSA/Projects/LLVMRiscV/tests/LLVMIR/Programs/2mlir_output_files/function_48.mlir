module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 47 : index} {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    return %1 : i64
  }
}
