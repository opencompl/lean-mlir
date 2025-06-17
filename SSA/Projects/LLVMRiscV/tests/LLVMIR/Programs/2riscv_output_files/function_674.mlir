module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 673 : index} {
    %0 = llvm.udiv %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    return %1 : i1
  }
}
