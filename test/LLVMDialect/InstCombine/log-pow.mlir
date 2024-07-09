module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @log_pow(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @pow(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @log_powi_const(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    %2 = llvm.call @log(%1) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @log_powi_nonconst(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @logf64_powi_nonconst(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    %1 = llvm.intr.log(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @logf_powfi_const(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, i32) -> f32
    %2 = llvm.call @logf(%1) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @logf_powfi_nonconst(%arg0: f32, %arg1: i32) -> f32 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, i32) -> f32
    %1 = llvm.call @logf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @log_powi_not_fast(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @log10f_powf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @powf(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    %1 = llvm.intr.log10(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @log2v_powv(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    %1 = llvm.intr.log2(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @log_pow_not_fast(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @pow(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @function_pointer(%arg0: !llvm.ptr, %arg1: f32) -> f32 {
    %0 = llvm.call %arg0() : !llvm.ptr, () -> f32
    %1 = llvm.call @logf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @log10_exp(%arg0: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %1 = llvm.call @log10(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @logv_exp2v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.exp2(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf32>) -> vector<2xf32>
    %1 = llvm.intr.log(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @log2f_exp10f(%arg0: f32) -> f32 {
    %0 = llvm.call @exp10f(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %1 = llvm.call @log2f(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @log_exp2_not_fast(%arg0: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) : (f64) -> f64
    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pr43617(%arg0: f64, %arg1: i32, %arg2: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call %arg2(%arg1) {fastmathFlags = #llvm.fastmath<fast>} : !llvm.ptr, (i32) -> f64
    %3 = llvm.intr.log(%2)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %4 = llvm.fmul %3, %1  : f64
    llvm.return %4 : f64
  }
  llvm.func @log(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @logf(f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @log2f(f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @log10(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @exp(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @exp2(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @exp10f(f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @pow(f64, f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @powf(f32, f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
}
