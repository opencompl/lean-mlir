module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @tanAtanInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @atanf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %1 = llvm.call @tanf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @atanhTanhInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @tanhf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %1 = llvm.call @atanhf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @sinhAsinhInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @asinhf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %1 = llvm.call @sinhf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @asinhSinhInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @sinhf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %1 = llvm.call @asinhf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @coshAcoshInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @acoshf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %1 = llvm.call @coshf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @indirectTanCall(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.call %arg0() {fastmathFlags = #llvm.fastmath<fast>} : !llvm.ptr, () -> f32
    %1 = llvm.call @tanf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @tanAtanInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @atanf(%arg0) : (f32) -> f32
    %1 = llvm.call @tanf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @atanhTanhInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @tanhf(%arg0) : (f32) -> f32
    %1 = llvm.call @atanhf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @sinhAsinhInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @asinhf(%arg0) : (f32) -> f32
    %1 = llvm.call @sinhf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @asinhSinhInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @sinhf(%arg0) : (f32) -> f32
    %1 = llvm.call @asinhf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @coshAcoshInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @acoshf(%arg0) : (f32) -> f32
    %1 = llvm.call @coshf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @asinhf(f32) -> f32
  llvm.func @sinhf(f32) -> f32
  llvm.func @acoshf(f32) -> f32
  llvm.func @coshf(f32) -> f32
  llvm.func @tanhf(f32) -> f32
  llvm.func @atanhf(f32) -> f32
  llvm.func @tanf(f32) -> f32
  llvm.func @atanf(f32) -> f32
}
