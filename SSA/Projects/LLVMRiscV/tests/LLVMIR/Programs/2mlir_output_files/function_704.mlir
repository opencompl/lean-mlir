module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 703 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    return %1 : i1
  }
}
