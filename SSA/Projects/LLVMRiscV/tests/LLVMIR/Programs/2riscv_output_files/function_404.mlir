module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 403 : index} {
    %0 = llvm.icmp "eq" %arg0, %arg0 : i64
    return %0 : i1
  }
}
