module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @pow_intrinsic_third_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.33333333333333331 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_intrinsic_third_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.333333343 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_intrinsic_third_approx(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.33333333333333331 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_intrinsic_third_approx(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.333333343 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_libcall_third_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.33333333333333331 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_libcall_third_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.333333343 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_intrinsic_negthird_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.33333333333333331 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_intrinsic_negthird_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.333333343 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_intrinsic_negthird_approx(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.33333333333333331 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_intrinsic_negthird_approx(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.333333343 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_libcall_negthird_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.33333333333333331 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_libcall_negthird_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.333333343 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow(f64, f64) -> f64
  llvm.func @powf(f32, f32) -> f32
}
