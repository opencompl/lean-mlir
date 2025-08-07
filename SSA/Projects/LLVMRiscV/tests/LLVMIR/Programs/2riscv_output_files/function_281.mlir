module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 280 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    return %1 : i1
  }
}
