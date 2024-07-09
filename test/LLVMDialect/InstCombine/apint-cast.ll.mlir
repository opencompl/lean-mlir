module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i17) -> i17 {
    %0 = llvm.mlir.constant(8 : i37) : i37
    %1 = llvm.zext %arg0 : i17 to i37
    %2 = llvm.lshr %1, %0  : i37
    %3 = llvm.shl %1, %0  : i37
    %4 = llvm.or %2, %3  : i37
    %5 = llvm.trunc %4 : i37 to i17
    llvm.return %5 : i17
  }
  llvm.func @test2(%arg0: i167) -> i167 {
    %0 = llvm.mlir.constant(9 : i577) : i577
    %1 = llvm.mlir.constant(8 : i577) : i577
    %2 = llvm.zext %arg0 : i167 to i577
    %3 = llvm.lshr %2, %0  : i577
    %4 = llvm.shl %2, %1  : i577
    %5 = llvm.or %3, %4  : i577
    %6 = llvm.trunc %5 : i577 to i167
    llvm.return %6 : i167
  }
}
