module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 272 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.ashr %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
