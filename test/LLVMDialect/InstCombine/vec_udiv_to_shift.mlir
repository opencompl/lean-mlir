module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @udiv_vec8x16(%arg0: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<32> : vector<8xi16>) : vector<8xi16>
    %1 = llvm.udiv %arg0, %0  : vector<8xi16>
    llvm.return %1 : vector<8xi16>
  }
  llvm.func @udiv_vec4x32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
}
