// llvm.mul
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw,nuw>  : i64
    return %0 : i64
  }
}
