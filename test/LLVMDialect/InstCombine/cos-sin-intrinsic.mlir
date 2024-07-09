module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @undef_arg() -> f64 {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.intr.cos(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @undef_arg2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.intr.cos(%arg0)  : (f32) -> f32
    %2 = llvm.intr.cos(%0)  : (f32) -> f32
    %3 = llvm.fadd %2, %1  : f32
    llvm.return %3 : f32
  }
  llvm.func @fneg_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.intr.cos(%1)  : (f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @unary_fneg_f32(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.intr.cos(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.intr.cos(%1)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @unary_fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.intr.cos(%0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @fneg_cos_fmf(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %2 = llvm.intr.cos(%1)  {fastmathFlags = #llvm.fastmath<nnan, afn>} : (vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @unary_fneg_cos_fmf(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %1 = llvm.intr.cos(%0)  {fastmathFlags = #llvm.fastmath<nnan, afn>} : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @fabs_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.cos(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fabs_fneg_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fsub %0, %1  : f32
    %3 = llvm.intr.cos(%2)  : (f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @fabs_unary_fneg_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.intr.cos(%1)  : (f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @fabs_fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %2 = llvm.fsub %0, %1  : vector<2xf32>
    %3 = llvm.intr.cos(%2)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @fabs_unary_fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %1 = llvm.fneg %0  : vector<2xf32>
    %2 = llvm.intr.cos(%1)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fneg_sin(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.intr.sin(%1)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @unary_fneg_sin(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.intr.sin(%0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @fneg_sin_fmf(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %2 = llvm.intr.sin(%1)  {fastmathFlags = #llvm.fastmath<nnan, arcp, afn>} : (vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @unary_fneg_sin_fmf(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %1 = llvm.intr.sin(%0)  {fastmathFlags = #llvm.fastmath<nnan, arcp, afn>} : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
}
