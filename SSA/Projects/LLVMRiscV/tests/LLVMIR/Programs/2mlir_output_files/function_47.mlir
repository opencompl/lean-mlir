module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 46 : index} {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    return %1 : i64
  }
}
