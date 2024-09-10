module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @cast() -> f80 {
    %0 = llvm.mlir.constant(0 : i80) : i80
    %1 = llvm.bitcast %0 : i80 to f80
    llvm.return %1 : f80
  }
  llvm.func @invcast() -> i80 {
    %0 = llvm.mlir.constant(0.000000e+00 : f80) : f80
    %1 = llvm.bitcast %0 : f80 to i80
    llvm.return %1 : i80
  }
}
