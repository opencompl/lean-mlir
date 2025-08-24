module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 86 : index} {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.ashr %3, %1 : i64
    return %4 : i64
  }
}
