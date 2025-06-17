module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 123 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    return %1 : i1
  }
}
