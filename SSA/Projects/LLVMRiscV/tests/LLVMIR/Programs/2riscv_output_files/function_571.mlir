module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 570 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
