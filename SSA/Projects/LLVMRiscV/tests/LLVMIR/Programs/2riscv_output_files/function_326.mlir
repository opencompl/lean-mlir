module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 325 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
