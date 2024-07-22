module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @sqrt_div_fast(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_div(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  : f64
    %1 = llvm.intr.sqrt(%0)  : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_div_reassoc_arcp(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_div_reassoc_missing(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_div_reassoc_missing2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_div_reassoc_missing3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp>} : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_div_arcp_missing(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_div_arcp_missing2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_div_arcp_missing3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @use(f64)
  llvm.func @sqrt_div_fast_multiple_uses_1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_div_fast_multiple_uses_2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.call @use(%1) : (f64) -> ()
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_non_div_operator(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
}
