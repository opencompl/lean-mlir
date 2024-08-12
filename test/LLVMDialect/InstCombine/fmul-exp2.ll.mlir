module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(f64)
  llvm.func @exp2_a_exp2_b(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp2(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @exp2_a_exp2_b_multiple_uses(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp2(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @exp2_a_a(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %1 : f64
  }
  llvm.func @exp2_a_exp2_b_multiple_uses_both(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp2(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @exp2_a_exp2_b_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp2(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @exp2_a_exp2_b_exp2_c_exp2_d(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp2(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %3 = llvm.intr.exp2(%arg2)  : (f64) -> f64
    %4 = llvm.fmul %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %5 = llvm.intr.exp2(%arg3)  : (f64) -> f64
    %6 = llvm.fmul %4, %5  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %6 : f64
  }
}
