module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fabs_sqrt_src_maybe_nan(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%0)  : (f64) -> f64
    %2 = llvm.fcmp "ord" %1, %1 : f64
    llvm.return %2 : i1
  }
  llvm.func @select_maybe_nan_lhs(%arg0: i1, %arg1: f64, %arg2: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fadd %arg2, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %2 = llvm.select %arg0, %arg1, %1 : i1, f64
    %3 = llvm.fcmp "ord" %2, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @select_maybe_nan_rhs(%arg0: i1, %arg1: f64, %arg2: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %2 = llvm.select %arg0, %1, %arg2 : i1, f64
    %3 = llvm.fcmp "ord" %2, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @nnan_fadd(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %3 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %4 = llvm.fadd %2, %3  : f64
    %5 = llvm.fcmp "ord" %4, %4 : f64
    llvm.return %5 : i1
  }
  llvm.func @nnan_fadd_maybe_nan_lhs(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %2 = llvm.fadd %arg0, %1  : f64
    %3 = llvm.fcmp "ord" %2, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @nnan_fadd_maybe_nan_rhs(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %2 = llvm.fadd %1, %arg1  : f64
    %3 = llvm.fcmp "ord" %2, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @nnan_fmul(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %3 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %4 = llvm.fmul %2, %3  : f64
    %5 = llvm.fcmp "ord" %4, %4 : f64
    llvm.return %5 : i1
  }
  llvm.func @nnan_fsub(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %3 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %4 = llvm.fsub %2, %3  : f64
    %5 = llvm.fcmp "ord" %4, %4 : f64
    llvm.return %5 : i1
  }
  llvm.func @func() -> f64
  llvm.func @nnan_fneg() -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.call @func() {fastmathFlags = #llvm.fastmath<nnan>} : () -> f64
    %2 = llvm.fsub %0, %1  : f64
    %3 = llvm.fcmp "ord" %2, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @nnan_unary_fneg() -> i1 {
    %0 = llvm.call @func() {fastmathFlags = #llvm.fastmath<nnan>} : () -> f64
    %1 = llvm.fneg %0  : f64
    %2 = llvm.fcmp "ord" %1, %1 : f64
    llvm.return %2 : i1
  }
  llvm.func @fpext_maybe_nan(%arg0: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fcmp "ord" %0, %0 : f64
    llvm.return %1 : i1
  }
  llvm.func @fptrunc_maybe_nan(%arg0: f64) -> i1 {
    %0 = llvm.fptrunc %arg0 : f64 to f32
    %1 = llvm.fcmp "ord" %0, %0 : f32
    llvm.return %1 : i1
  }
  llvm.func @nnan_fdiv(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %3 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %4 = llvm.fdiv %2, %3  : f64
    %5 = llvm.fcmp "ord" %4, %4 : f64
    llvm.return %5 : i1
  }
  llvm.func @nnan_frem(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %3 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %4 = llvm.frem %2, %3  : f64
    %5 = llvm.fcmp "ord" %4, %4 : f64
    llvm.return %5 : i1
  }
  llvm.func @llvm.canonicalize.f64(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nocallback", "nofree", "nosync", "nounwind", "speculatable", "willreturn"]}
}
