module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 24 : index} {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    return %0 : i1
  }
}
