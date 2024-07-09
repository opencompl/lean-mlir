module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @pow(f64, f64) -> f64
  llvm.func @test_simplify_3(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify_4f(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify_4(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify_15(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.500000e+01> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @test_simplify_neg_7(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-7.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @test_simplify_neg_19(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.900000e+01 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify_11_23(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.123000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify_32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.200000e+01 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify_33(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3.300000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify_16_5(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.650000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify_neg_16_5(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-1.650000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify_0_5_libcall(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify_neg_0_5_libcall(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify_neg_8_5(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-8.500000e+00 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify_7_5(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<7.500000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @test_simplify_3_5(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<3.500000e+00> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }
  llvm.func @shrink_pow_libcall_half(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.call @pow(%1, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @PR43233(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
}
