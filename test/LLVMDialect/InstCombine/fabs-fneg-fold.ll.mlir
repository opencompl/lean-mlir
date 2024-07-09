module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fabs_fneg_basic(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.intr.fabs(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fabs_fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.intr.fabs(%0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @fabs_fneg_f64(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.intr.fabs(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @fabs_fneg_v4f64(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.fneg %arg0  : vector<4xf64>
    %1 = llvm.intr.fabs(%0)  : (vector<4xf64>) -> vector<4xf64>
    llvm.return %1 : vector<4xf64>
  }
  llvm.func @fabs_fneg_f16(%arg0: f16) -> f16 {
    %0 = llvm.fneg %arg0  : f16
    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @fabs_copysign_nnan(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fabs_copysign_ninf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fabs_copysign_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fabs_copysign_nnan_negative(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fabs_copysign_ninf_negative(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fabs_copysign_nsz_negative(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fabs_fneg_no_fabs(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.return %0 : f32
  }
  llvm.func @fabs_fneg_splat_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-2.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %0  : vector<2xf32>
    %2 = llvm.intr.fabs(%1)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fabs_fneg_splat_poison_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fneg %6  : vector<2xf32>
    %8 = llvm.intr.fabs(%7)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %8 : vector<2xf32>
  }
  llvm.func @fabs_fneg_non_splat_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[2.000000e+00, 3.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %0  : vector<2xf32>
    %2 = llvm.intr.fabs(%1)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @use(f32)
  llvm.func @fabs_fneg_multi_use(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.intr.fabs(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }
}
