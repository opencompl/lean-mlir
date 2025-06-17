module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 283 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.urem %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
