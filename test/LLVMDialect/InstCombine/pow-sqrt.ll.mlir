module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @pow_libcall_half_no_FMF(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_intrinsic_half_no_FMF(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_libcall_half_approx(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<afn>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_intrinsic_half_approx(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @powf_intrinsic_half_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_libcall_half_no_FMF_base_ninf(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.call @pow(%1, %0) : (f64, f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @pow_libcall_half_ninf(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_intrinsic_half_ninf(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<ninf>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @pow_libcall_half_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<nsz>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_intrinsic_half_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_libcall_half_ninf_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf, nsz>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_intrinsic_half_ninf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<ninf, nsz>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_libcall_half_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_intrinsic_half_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_libcall_neghalf_no_FMF(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_libcall_neghalf_reassoc_ninf(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_libcall_neghalf_afn(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_intrinsic_neghalf_no_FMF(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @pow_intrinsic_neghalf_reassoc(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @pow_intrinsic_neghalf_afn(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @pow_libcall_neghalf_ninf(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf, afn>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_intrinsic_neghalf_ninf(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<ninf, afn>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @pow_libcall_neghalf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<nsz, afn>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_intrinsic_neghalf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<nsz, afn>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_intrinsic_neghalf_ninf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<ninf, nsz, afn>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_libcall_neghalf_ninf_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf, nsz, afn>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_libcall_neghalf_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_intrinsic_neghalf_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow(f64, f64) -> f64
  llvm.func @powf(f32, f32) -> f32
}
