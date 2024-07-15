module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(f64)
  llvm.func @powi_fneg_even_int(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.fneg %arg0  : f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fabs_even_int(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }
  llvm.func @powi_copysign_even_int(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.intr.copysign(%arg0, %arg1)  : (f64, f64) -> f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fneg_odd_int(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.fneg %arg0  : f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fabs_odd_int(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }
  llvm.func @powi_copysign_odd_int(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.copysign(%arg0, %arg1)  : (f64, f64) -> f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fmul_arg0_no_reassoc(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    %1 = llvm.fmul %0, %arg0  : f64
    llvm.return %1 : f64
  }
  llvm.func @powi_fmul_arg0(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %1 : f64
  }
  llvm.func @powi_fmul_arg0_use(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %1 : f64
  }
  llvm.func @powi_fmul_powi_no_reassoc1(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fmul_powi_no_reassoc2(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg0, %arg2)  : (f64, i32) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fmul_powi_no_reassoc3(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fmul_powi(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fmul_powi_fast_on_fmul(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fmul_powi_fast_on_powi(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fmul_powi_same_power(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fmul_powi_different_integer_types(%arg0: f64, %arg1: i32, %arg2: i16) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i16) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fmul_powi_use_first(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fmul_powi_use_second(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fmul_different_base(%arg0: f64, %arg1: f64, %arg2: i32, %arg3: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg2)  : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg1, %arg3)  : (f64, i32) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @different_types_powi(%arg0: f64, %arg1: i32, %arg2: i64) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg0, %arg2)  : (f64, i64) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_pow_powi(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_powf_powi(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f32, i32) -> f32
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fdiv_pow_powi_multi_use(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @fdiv_powf_powi_missing_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f32, i32) -> f32
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fdiv_powf_powi_missing_reassoc1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f32, i32) -> f32
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fdiv_powf_powi_missing_nnan(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f32, i32) -> f32
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fdiv_pow_powi_negative(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_pow_powi_negative_variable(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64
    llvm.return %1 : f64
  }
  llvm.func @fdiv_fmul_powi(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %2 = llvm.fmul %arg1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64
    llvm.return %3 : f64
  }
  llvm.func @fdiv_fmul_powi_2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64
    llvm.return %3 : f64
  }
  llvm.func @fdiv_fmul_powi_vector(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (vector<2xf32>, i32) -> vector<2xf32>
    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf32>
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @fdiv_fmul_powi_missing_reassoc1(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    llvm.return %3 : f64
  }
  llvm.func @fdiv_fmul_powi_missing_reassoc2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %2 = llvm.fmul %arg0, %arg0  : f64
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64
    llvm.return %3 : f64
  }
  llvm.func @fdiv_fmul_powi_missing_reassoc3(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64
    llvm.return %3 : f64
  }
  llvm.func @fdiv_fmul_powi_missing_nnan(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %3 : f64
  }
  llvm.func @fdiv_fmul_powi_negative_wrap(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_fmul_powi_multi_use(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    llvm.call @use(%1) : (f64) -> ()
    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64
    llvm.return %3 : f64
  }
  llvm.func @powi_fmul_powi_x(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fmul_powi_x_multi_use(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    llvm.call @use(%1) : (f64) -> ()
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fmul_powi_x_missing_reassoc(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fmul %1, %arg0  : f64
    llvm.return %2 : f64
  }
  llvm.func @powi_fmul_powi_x_overflow(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
}
