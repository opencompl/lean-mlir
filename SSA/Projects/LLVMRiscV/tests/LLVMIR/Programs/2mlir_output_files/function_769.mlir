module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 768 : index} {
    %0 = llvm.mul %arg1, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
