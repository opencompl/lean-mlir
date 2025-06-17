module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 attributes {seed = 388 : index} {
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    return %1 : i1
  }
}
