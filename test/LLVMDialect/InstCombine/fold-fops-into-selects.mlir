module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i1) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    %3 = llvm.fsub %0, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @test2(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %arg1 : i1, f32
    %3 = llvm.fadd %1, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @test3(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %arg1 : i1, f32
    %3 = llvm.fsub %1, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @test4(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %arg1 : i1, f32
    %3 = llvm.fmul %1, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @test5(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %arg1 : i1, f32
    %3 = llvm.fdiv %1, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @test6(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %arg1 : i1, f32
    %3 = llvm.fdiv %2, %1  : f32
    llvm.return %3 : f32
  }
  llvm.func @test7(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %arg1 : i1, f32
    %3 = llvm.fdiv %2, %1  : f32
    llvm.return %3 : f32
  }
}
