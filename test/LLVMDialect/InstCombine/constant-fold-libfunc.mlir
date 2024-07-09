module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @acos(f64) -> f64 attributes {passthrough = ["willreturn"]}
  llvm.func @test_simplify_acos() -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_acos_nobuiltin() -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_acos_strictfp() -> f64 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
}
