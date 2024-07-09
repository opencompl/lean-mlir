module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(f64)
  llvm.func @pow_ab_a(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %0, %arg0  : f64
    llvm.return %1 : f64
  }
  llvm.func @pow_ab_a_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %1 : f64
  }
  llvm.func @pow_ab_a_reassoc_commute(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fadd %arg0, %0  : f64
    %2 = llvm.intr.pow(%1, %arg1)  : (f64, f64) -> f64
    %3 = llvm.fmul %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %3 : f64
  }
  llvm.func @pow_ab_a_reassoc_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %1 : f64
  }
  llvm.func @pow_ab_recip_a(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  : f64
    %2 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %3 = llvm.fmul %1, %2  : f64
    llvm.return %3 : f64
  }
  llvm.func @pow_ab_recip_a_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    %3 = llvm.fmul %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %3 : f64
  }
  llvm.func @pow_ab_recip_a_reassoc_commute(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %3 : f64
  }
  llvm.func @pow_ab_recip_a_reassoc_use1(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    %3 = llvm.fmul %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %3 : f64
  }
  llvm.func @pow_ab_recip_a_reassoc_use2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    %3 = llvm.fmul %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%2) : (f64) -> ()
    llvm.return %3 : f64
  }
  llvm.func @pow_ab_recip_a_reassoc_use3(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    %3 = llvm.fmul %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.call @use(%2) : (f64) -> ()
    llvm.return %3 : f64
  }
  llvm.func @pow_ab_pow_cb(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg2, %arg1)  : (f64, f64) -> f64
    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }
  llvm.func @pow_ab_pow_cb_reassoc(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg2, %arg1)  : (f64, f64) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @pow_ab_pow_cb_reassoc_use1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg2, %arg1)  : (f64, f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @pow_ab_pow_cb_reassoc_use2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg2, %arg1)  : (f64, f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @pow_ab_pow_cb_reassoc_use3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg2, %arg1)  : (f64, f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @pow_ab_pow_ac(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg0, %arg2)  : (f64, f64) -> f64
    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }
  llvm.func @pow_ab_x_pow_ac_reassoc(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg0, %arg2)  : (f64, f64) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @pow_ab_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %1 : f64
  }
  llvm.func @pow_ab_reassoc_extra_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %1 : f64
  }
  llvm.func @pow_ab_x_pow_ac_reassoc_extra_use(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg0, %arg2)  : (f64, f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @pow_ab_x_pow_ac_reassoc_multiple_uses(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg0, %arg2)  : (f64, f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }
}
