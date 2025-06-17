module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 attributes {seed = 154 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "slt" %0, %arg2 : i64
    return %1 : i1
  }
}
