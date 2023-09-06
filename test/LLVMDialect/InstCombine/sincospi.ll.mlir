module  {
  llvm.mlir.global external @var32(0.000000e+00 : f32) : f32
  llvm.mlir.global external @var64(0.000000e+00 : f64) : f64
  llvm.func @__sinpif(f32) -> f32
  llvm.func @__cospif(f32) -> f32
  llvm.func @__sinpi(f64) -> f64
  llvm.func @__cospi(f64) -> f64
  llvm.func @test_instbased_f32() -> f32 {
    %0 = llvm.mlir.addressof @var32 : !llvm.ptr<f32>
    %1 = llvm.load %0 : !llvm.ptr<f32>
    %2 = llvm.call @__sinpif(%1) : (f32) -> f32
    %3 = llvm.call @__cospif(%1) : (f32) -> f32
    %4 = llvm.fadd %2, %3  : f32
    llvm.return %4 : f32
  }
  llvm.func @test_constant_f32() -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @__sinpif(%0) : (f32) -> f32
    %2 = llvm.call @__cospif(%0) : (f32) -> f32
    %3 = llvm.fadd %1, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @test_instbased_f64() -> f64 {
    %0 = llvm.mlir.addressof @var64 : !llvm.ptr<f64>
    %1 = llvm.load %0 : !llvm.ptr<f64>
    %2 = llvm.call @__sinpi(%1) : (f64) -> f64
    %3 = llvm.call @__cospi(%1) : (f64) -> f64
    %4 = llvm.fadd %2, %3  : f64
    llvm.return %4 : f64
  }
  llvm.func @test_constant_f64() -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @__sinpi(%0) : (f64) -> f64
    %2 = llvm.call @__cospi(%0) : (f64) -> f64
    %3 = llvm.fadd %1, %2  : f64
    llvm.return %3 : f64
  }
  llvm.func @test_fptr(%arg0: !llvm.ptr<func<f64 (f64)>>, %arg1: f64) -> f64 {
    %0 = llvm.call @__sinpi(%arg1) : (f64) -> f64
    %1 = llvm.call %arg0(%arg1) : (f64) -> f64
    %2 = llvm.fadd %0, %1  : f64
    llvm.return %2 : f64
  }
}
