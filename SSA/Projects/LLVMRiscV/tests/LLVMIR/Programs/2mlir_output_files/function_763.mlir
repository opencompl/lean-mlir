module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 762 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
