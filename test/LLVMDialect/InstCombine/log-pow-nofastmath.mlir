module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @mylog(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test3(%arg0: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) : (f64) -> f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @log(f64) -> f64
  llvm.func @exp2(f64) -> f64
}
