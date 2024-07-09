module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fabsl(f80) -> f80
  llvm.func @replace_fabs_call_f80(%arg0: f80) -> f80 {
    %0 = llvm.call @fabsl(%arg0) : (f80) -> f80
    llvm.return %0 : f80
  }
  llvm.func @fmf_replace_fabs_call_f80(%arg0: f80) -> f80 {
    %0 = llvm.call @fabsl(%arg0) {fastmathFlags = #llvm.fastmath<nnan>} : (f80) -> f80
    llvm.return %0 : f80
  }
}
