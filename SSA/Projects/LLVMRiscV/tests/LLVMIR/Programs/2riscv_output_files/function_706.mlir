module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 705 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
