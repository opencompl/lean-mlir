module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 98 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    return %1 : i1
  }
}
