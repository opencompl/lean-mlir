module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @scalar_zext_slt(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(500 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @vector_zext_slt(%arg0: vector<4xi16>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[500, 0, 501, 65535]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.zext %arg0 : vector<4xi16> to vector<4xi32>
    %2 = llvm.icmp "slt" %1, %0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }
}
