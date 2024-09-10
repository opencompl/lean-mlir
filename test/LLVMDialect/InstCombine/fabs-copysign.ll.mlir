module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(f64)
  llvm.func @fabs_copysign(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f64
    llvm.return %1 : f64
  }
  llvm.func @fabs_copysign_commuted(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f64
    llvm.return %1 : f64
  }
  llvm.func @fabs_copysign_vec(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<4xf64>
    llvm.return %1 : vector<4xf64>
  }
  llvm.func @fabs_copysign_vec_commuted(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<4xf64>
    llvm.return %1 : vector<4xf64>
  }
  llvm.func @fabs_copysignf(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f32
    llvm.return %1 : f32
  }
  llvm.func @fabs_copysign_use(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f64
    llvm.return %1 : f64
  }
  llvm.func @fabs_copysign_mismatch(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  : f64
    llvm.return %1 : f64
  }
  llvm.func @fabs_copysign_commuted_mismatch(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %1 = llvm.fdiv %0, %arg0  : f64
    llvm.return %1 : f64
  }
  llvm.func @fabs_copysign_no_nnan(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f64
    llvm.return %1 : f64
  }
  llvm.func @fabs_copysign_no_ninf(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    llvm.return %1 : f64
  }
}
