module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 attributes {seed = 583 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    return %1 : i1
  }
}
