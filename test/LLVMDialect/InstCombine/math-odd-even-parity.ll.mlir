module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @erf(f64) -> f64
  llvm.func @cos(f64) -> f64
  llvm.func @fabs(f64) -> f64
  llvm.func @use(f64) attributes {passthrough = ["nounwind"]}
  llvm.func @test_erf(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @erf(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %2 = llvm.fneg %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @test_cos_fabs(%arg0: f64) -> f64 {
    %0 = llvm.call @fabs(%arg0) : (f64) -> f64
    %1 = llvm.call @cos(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_erf_multi_use(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.call @erf(%0) : (f64) -> f64
    %2 = llvm.fneg %1  : f64
    llvm.return %2 : f64
  }
}
