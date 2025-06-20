module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 25 : index} {
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.mul %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
