module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @positive_sign_arg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<arcp>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @positive_sign_arg_vec_splat(%arg0: vector<3xf64>) -> vector<3xf64> {
    %0 = llvm.mlir.constant(dense<4.200000e+01> : vector<3xf64>) : vector<3xf64>
    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<ninf>} : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    llvm.return %1 : vector<3xf64>
  }
  llvm.func @negative_sign_arg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @negative_sign_arg_vec_splat(%arg0: vector<3xf64>) -> vector<3xf64> {
    %0 = llvm.mlir.constant(dense<-4.200000e+01> : vector<3xf64>) : vector<3xf64>
    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    llvm.return %1 : vector<3xf64>
  }
  llvm.func @known_positive_sign_arg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg1)  : (f32) -> f32
    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @known_positive_sign_arg_vec(%arg0: vector<3xf64>, %arg1: vector<3xi32>) -> vector<3xf64> {
    %0 = llvm.uitofp %arg1 : vector<3xi32> to vector<3xf64>
    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<arcp>} : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    llvm.return %1 : vector<3xf64>
  }
  llvm.func @not_known_positive_sign_arg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.maxnum(%arg0, %0)  : (f32, f32) -> f32
    %2 = llvm.intr.copysign(%arg1, %1)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @copysign_sign_arg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg1, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f32, f32) -> f32
    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fneg_mag(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.intr.copysign(%0, %arg1)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fabs_mag(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.copysign(%0, %arg1)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }
}
