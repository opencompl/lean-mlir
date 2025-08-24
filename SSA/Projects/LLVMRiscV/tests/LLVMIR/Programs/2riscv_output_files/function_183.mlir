module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 182 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    return %1 : i1
  }
}
