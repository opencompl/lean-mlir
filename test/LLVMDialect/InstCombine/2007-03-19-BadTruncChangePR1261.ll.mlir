module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: i31) -> i16 {
    %0 = llvm.mlir.constant(16384 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.sext %arg0 : i31 to i32
    %3 = llvm.add %2, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.trunc %4 : i32 to i16
    llvm.return %5 : i16
  }
}
