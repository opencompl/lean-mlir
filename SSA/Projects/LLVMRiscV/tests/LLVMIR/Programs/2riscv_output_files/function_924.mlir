module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 923 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    return %1 : i1
  }
}
