module  {
  llvm.func @strtol(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
  llvm.func @strtod(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> f64
  llvm.func @strtof(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> f32
  llvm.func @strtoul(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
  llvm.func @strtoll(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
  llvm.func @strtold(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> f64
  llvm.func @strtoull(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
  llvm.func @test_simplify1(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %2 = llvm.call @strtol(%arg0, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    llvm.return
  }
  llvm.func @test_simplify2(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %1 = llvm.call @strtod(%arg0, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> f64
    llvm.return
  }
  llvm.func @test_simplify3(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %1 = llvm.call @strtof(%arg0, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> f32
    llvm.return
  }
  llvm.func @test_simplify4(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %2 = llvm.call @strtoul(%arg0, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    llvm.return
  }
  llvm.func @test_simplify5(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %2 = llvm.call @strtoll(%arg0, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    llvm.return
  }
  llvm.func @test_simplify6(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %1 = llvm.call @strtold(%arg0, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> f64
    llvm.return
  }
  llvm.func @test_simplify7(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %2 = llvm.call @strtoull(%arg0, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    llvm.return
  }
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.call @strtol(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    llvm.return
  }
}
