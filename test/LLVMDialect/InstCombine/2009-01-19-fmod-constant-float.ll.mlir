module  {
  llvm.func @test1() -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.alloca %3 x f32 : (i32) -> !llvm.ptr<f32>
    %5 = llvm.alloca %3 x f32 : (i32) -> !llvm.ptr<f32>
    %6 = llvm.bitcast %2 : i32 to i32
    %7 = llvm.frem %1, %0  : f64
    %8 = llvm.fptrunc %7 : f64 to f32
    llvm.store %8, %5 : !llvm.ptr<f32>
    %9 = llvm.load %5 : !llvm.ptr<f32>
    llvm.store %9, %4 : !llvm.ptr<f32>
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %10 = llvm.load %4 : !llvm.ptr<f32>
    llvm.return %10 : f32
  }
  llvm.func @test2() -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(-1.000000e-01 : f64) : f64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.alloca %3 x f32 : (i32) -> !llvm.ptr<f32>
    %5 = llvm.alloca %3 x f32 : (i32) -> !llvm.ptr<f32>
    %6 = llvm.bitcast %2 : i32 to i32
    %7 = llvm.frem %1, %0  : f64
    %8 = llvm.fptrunc %7 : f64 to f32
    llvm.store %8, %5 : !llvm.ptr<f32>
    %9 = llvm.load %5 : !llvm.ptr<f32>
    llvm.store %9, %4 : !llvm.ptr<f32>
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %10 = llvm.load %4 : !llvm.ptr<f32>
    llvm.return %10 : f32
  }
  llvm.func @test3() -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.alloca %3 x f32 : (i32) -> !llvm.ptr<f32>
    %5 = llvm.alloca %3 x f32 : (i32) -> !llvm.ptr<f32>
    %6 = llvm.bitcast %2 : i32 to i32
    %7 = llvm.frem %1, %0  : f64
    %8 = llvm.fptrunc %7 : f64 to f32
    llvm.store %8, %5 : !llvm.ptr<f32>
    %9 = llvm.load %5 : !llvm.ptr<f32>
    llvm.store %9, %4 : !llvm.ptr<f32>
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %10 = llvm.load %4 : !llvm.ptr<f32>
    llvm.return %10 : f32
  }
  llvm.func @test4() -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(-1.000000e-01 : f64) : f64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.alloca %3 x f32 : (i32) -> !llvm.ptr<f32>
    %5 = llvm.alloca %3 x f32 : (i32) -> !llvm.ptr<f32>
    %6 = llvm.bitcast %2 : i32 to i32
    %7 = llvm.frem %1, %0  : f64
    %8 = llvm.fptrunc %7 : f64 to f32
    llvm.store %8, %5 : !llvm.ptr<f32>
    %9 = llvm.load %5 : !llvm.ptr<f32>
    llvm.store %9, %4 : !llvm.ptr<f32>
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %10 = llvm.load %4 : !llvm.ptr<f32>
    llvm.return %10 : f32
  }
}
