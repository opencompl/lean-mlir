module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 298 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.mul %0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
