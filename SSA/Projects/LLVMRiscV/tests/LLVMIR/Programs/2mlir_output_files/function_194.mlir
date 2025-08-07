module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 193 : index} {
    %0 = llvm.sdiv %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.shl %0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
