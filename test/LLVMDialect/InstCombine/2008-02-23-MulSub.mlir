module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: i26) -> i26 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2885 : i26) : i26
    %1 = llvm.mlir.constant(2884 : i26) : i26
    %2 = llvm.mul %arg0, %0  : i26
    %3 = llvm.mul %arg0, %1  : i26
    %4 = llvm.sub %2, %3  : i26
    llvm.return %4 : i26
  }
}
