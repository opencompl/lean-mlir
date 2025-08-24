module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 attributes {seed = 518 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    return %1 : i1
  }
}
