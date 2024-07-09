module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1() -> i8 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.fptoui %0 : f32 to i8
    llvm.return %1 : i8
  }
  llvm.func @test2() -> i8 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fptosi %0 : f32 to i8
    llvm.return %1 : i8
  }
  llvm.func @test3(%arg0: f32) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }
  llvm.func @fneg_fptrunc(%arg0: f32) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fptrunc %1 : f32 to f16
    llvm.return %2 : f16
  }
  llvm.func @unary_fneg_fptrunc(%arg0: f32) -> f16 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }
  llvm.func @fneg_fptrunc_vec_poison(%arg0: vector<2xf32>) -> vector<2xf16> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fsub %6, %arg0  : vector<2xf32>
    %8 = llvm.fptrunc %7 : vector<2xf32> to vector<2xf16>
    llvm.return %8 : vector<2xf16>
  }
  llvm.func @unary_fneg_fptrunc_vec(%arg0: vector<2xf32>) -> vector<2xf16> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.fptrunc %0 : vector<2xf32> to vector<2xf16>
    llvm.return %1 : vector<2xf16>
  }
  llvm.func @"test4-fast"(%arg0: f32) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fptrunc %1 : f32 to f16
    llvm.return %2 : f16
  }
  llvm.func @"test4_unary_fneg-fast"(%arg0: f32) -> f16 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }
  llvm.func @test5(%arg0: f32, %arg1: f32, %arg2: f32) -> f16 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %2 = llvm.select %1, %arg2, %0 : i1, f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }
  llvm.func @test6(%arg0: vector<1xf64>) -> vector<1xf32> {
    %0 = llvm.frem %arg0, %arg0  : vector<1xf64>
    %1 = llvm.fptrunc %0 : vector<1xf64> to vector<1xf32>
    llvm.return %1 : vector<1xf32>
  }
  llvm.func @test7(%arg0: f64) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.frem %arg0, %0  : f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test8(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.frem %1, %0  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test_fptrunc_fptrunc(%arg0: f64) -> f16 {
    %0 = llvm.fptrunc %arg0 : f64 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }
  llvm.func @sint_to_fptrunc(%arg0: i32) -> f16 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }
  llvm.func @masked_sint_to_fptrunc1(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }
  llvm.func @masked_sint_to_fptrunc2(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }
  llvm.func @masked_sint_to_fptrunc3(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }
  llvm.func @sint_to_fpext(%arg0: i32) -> f64 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }
  llvm.func @masked_sint_to_fpext1(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @masked_sint_to_fpext2(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @masked_sint_to_fpext3(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @uint_to_fptrunc(%arg0: i32) -> f16 {
    %0 = llvm.uitofp %arg0 : i32 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }
  llvm.func @masked_uint_to_fptrunc1(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }
  llvm.func @masked_uint_to_fptrunc2(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }
  llvm.func @masked_uint_to_fptrunc3(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }
  llvm.func @uint_to_fpext(%arg0: i32) -> f64 {
    %0 = llvm.uitofp %arg0 : i32 to f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }
  llvm.func @masked_uint_to_fpext1(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @masked_uint_to_fpext2(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @masked_uint_to_fpext3(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @fptosi_nonnorm(%arg0: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    llvm.return %0 : i32
  }
  llvm.func @fptoui_nonnorm(%arg0: f32) -> i32 {
    %0 = llvm.fptoui %arg0 : f32 to i32
    llvm.return %0 : i32
  }
  llvm.func @fptosi_nonnnorm(%arg0: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    llvm.return %0 : i32
  }
  llvm.func @fptoui_nonnnorm(%arg0: f32) -> i32 {
    %0 = llvm.fptoui %arg0 : f32 to i32
    llvm.return %0 : i32
  }
  llvm.func @fptosi_nonnorm_copysign(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.copysign(%0, %arg0)  : (f32, f32) -> f32
    %2 = llvm.fptosi %1 : f32 to i32
    llvm.return %2 : i32
  }
  llvm.func @fptosi_nonnorm_copysign_vec(%arg0: vector<2xf32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.copysign(%1, %arg0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fptosi %2 : vector<2xf32> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @fptosi_nonnorm_fmul(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fptosi %1 : f32 to i32
    llvm.return %2 : i32
  }
  llvm.func @fptosi_select(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    %3 = llvm.fptosi %2 : f32 to i32
    llvm.return %3 : i32
  }
  llvm.func @mul_pos_zero_convert(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fptosi %2 : f32 to i32
    llvm.return %3 : i32
  }
}
