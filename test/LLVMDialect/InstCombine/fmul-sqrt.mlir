module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(f64)
  llvm.func @sqrt_a_sqrt_b(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_a_sqrt_b_multiple_uses(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @sqrt_a_sqrt_b_reassoc_nnan(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_a_sqrt_b_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  : (f64) -> f64
    %2 = llvm.intr.sqrt(%arg2)  : (f64) -> f64
    %3 = llvm.intr.sqrt(%arg3)  : (f64) -> f64
    %4 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<nnan, arcp, reassoc>} : f64
    %5 = llvm.fmul %4, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64
    %6 = llvm.fmul %5, %3  {fastmathFlags = #llvm.fastmath<nnan, ninf, reassoc>} : f64
    llvm.return %6 : f64
  }
  llvm.func @rsqrt_squared(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.fmul %2, %2  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %3 : f64
  }
  llvm.func @rsqrt_x_reassociate_extra_use(%arg0: f64, %arg1: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    %3 = llvm.fmul %2, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f64
    llvm.store %2, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.return %3 : f64
  }
  llvm.func @x_add_y_rsqrt_reassociate_extra_use(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fdiv %0, %2  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %4 = llvm.fmul %1, %3  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    llvm.store %3, %arg2 {alignment = 8 : i64} : vector<2xf32>, !llvm.ptr
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @sqrt_divisor_squared(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg1, %0  : f64
    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_dividend_squared(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.sqrt(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %1 = llvm.fdiv %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @sqrt_divisor_squared_extra_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg1, %0  : f64
    llvm.call @use(%1) : (f64) -> ()
    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_dividend_squared_extra_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.fdiv %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_divisor_not_enough_FMF(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg1, %0  : f64
    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @rsqrt_squared_extra_use(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.call @use(%2) : (f64) -> ()
    %3 = llvm.fmul %2, %2  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %3 : f64
  }
}
