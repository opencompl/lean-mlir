module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 95 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
