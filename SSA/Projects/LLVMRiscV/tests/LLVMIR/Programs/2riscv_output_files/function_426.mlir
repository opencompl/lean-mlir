module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 425 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
