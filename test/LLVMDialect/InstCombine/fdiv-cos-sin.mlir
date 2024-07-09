module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fdiv_cos_sin(%arg0: f64) -> f64 {
    %0 = llvm.intr.cos(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sin(%arg0)  : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_strict_cos_strict_sin_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.intr.cos(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_reassoc_cos_strict_sin_strict(%arg0: f64, %arg1: !llvm.ptr {llvm.dereferenceable = 2 : i64}) -> f64 {
    %0 = llvm.intr.cos(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sin(%arg0)  : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_reassoc_cos_reassoc_sin_strict(%arg0: f64) -> f64 {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %1 = llvm.intr.sin(%arg0)  : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_cos_sin_reassoc_multiple_uses(%arg0: f64) -> f64 {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @fdiv_cos_sin_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_cosf16_sinf16_reassoc(%arg0: f16) -> f16 {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f16) -> f16
    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f16) -> f16
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f16
    llvm.return %2 : f16
  }
  llvm.func @fdiv_cosf_sinf_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f32) -> f32
    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f32) -> f32
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fdiv_cosfp128_sinfp128_reassoc(%arg0: f128) -> f128 {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f128) -> f128
    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f128) -> f128
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f128
    llvm.return %2 : f128
  }
  llvm.func @use(f64)
}
