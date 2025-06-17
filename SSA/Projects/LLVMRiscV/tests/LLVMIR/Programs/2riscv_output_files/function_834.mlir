module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 833 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    return %1 : i1
  }
}
