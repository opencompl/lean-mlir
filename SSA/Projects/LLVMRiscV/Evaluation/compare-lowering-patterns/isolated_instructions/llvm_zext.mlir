// llvm.zext
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i8) -> i64 {
    %0 = llvm.zext %arg0 : i8 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i16) -> i64 {
    %0 = llvm.zext %arg0 : i16 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i64 {
    %0 = llvm.zext %arg0 : i32 to i64
    return %0 : i64
  }
}