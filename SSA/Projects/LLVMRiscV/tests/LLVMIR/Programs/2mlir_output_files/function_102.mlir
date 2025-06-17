module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 101 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    return %1 : i64
  }
}
