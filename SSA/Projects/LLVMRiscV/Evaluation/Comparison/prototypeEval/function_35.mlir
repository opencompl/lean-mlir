module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 87 : index} {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    return %0 : i1
  }
}
