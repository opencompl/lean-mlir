module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 139 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.icmp "ne" %0, %0 : i64
    return %1 : i1
  }
}
