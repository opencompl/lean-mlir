module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 64 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    return %0 : i64
  }
}
