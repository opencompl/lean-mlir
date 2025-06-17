module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 266 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    return %1 : i1
  }
}
