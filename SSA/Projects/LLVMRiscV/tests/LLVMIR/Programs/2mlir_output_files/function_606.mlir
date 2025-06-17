module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 605 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
