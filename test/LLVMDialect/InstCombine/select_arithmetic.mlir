module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1a(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %4 = llvm.select %arg0, %0, %1 : i1, f32
    %5 = llvm.select %arg0, %2, %3 : i1, f32
    %6 = llvm.fadd %4, %5  : f32
    llvm.return %6 : f32
  }
  llvm.func @test1b(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %4 = llvm.mlir.constant(2.500000e-01 : f32) : f32
    %5 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %6 = llvm.select %arg0, %0, %1 : i1, f32
    %7 = llvm.select %arg0, %2, %3 : i1, f32
    %8 = llvm.select %arg0, %4, %5 : i1, f32
    %9 = llvm.fadd %6, %7  : f32
    %10 = llvm.fadd %8, %7  : f32
    %11 = llvm.fadd %10, %9  : f32
    llvm.return %11 : f32
  }
  llvm.func @test2(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %4 = llvm.select %arg0, %0, %1 : i1, f32
    %5 = llvm.select %arg0, %2, %3 : i1, f32
    %6 = llvm.fsub %4, %5  : f32
    llvm.return %6 : f32
  }
  llvm.func @test3(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %4 = llvm.select %arg0, %0, %1 : i1, f32
    %5 = llvm.select %arg0, %2, %3 : i1, f32
    %6 = llvm.fmul %4, %5  : f32
    llvm.return %6 : f32
  }
  llvm.func @use_float(f32)
  llvm.func @test4(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %4 = llvm.select %arg0, %0, %1 : i1, f32
    %5 = llvm.select %arg0, %2, %3 : i1, f32
    %6 = llvm.fmul %4, %5  : f32
    llvm.call @use_float(%4) : (f32) -> ()
    llvm.return %6 : f32
  }
  llvm.func @test5(%arg0: i1 {llvm.zeroext}, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %arg1, %0 : i1, f32
    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<contract>} : f32
    llvm.call @use_float(%1) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @fmul_nnan_nsz(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %arg1, %0 : i1, f32
    %3 = llvm.select %arg0, %1, %arg1 : i1, f32
    %4 = llvm.fmul %2, %3  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32
    llvm.return %4 : f32
  }
  llvm.func @fadd_nsz(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.select %arg0, %1, %arg1 : vector<2xi1>, vector<2xf32>
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @fsub_nnan(%arg0: i1, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, f64
    %2 = llvm.select %arg0, %arg1, %0 : i1, f64
    %3 = llvm.fsub %1, %2  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    llvm.return %3 : f64
  }
  llvm.func @fdiv_nnan_nsz(%arg0: i1, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %2 = llvm.select %arg0, %arg2, %0 : i1, f64
    %3 = llvm.select %arg0, %1, %arg1 : i1, f64
    %4 = llvm.fdiv %2, %3  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    llvm.return %4 : f64
  }
}
