module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 353 : index} {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    return %0 : i1
  }
}
