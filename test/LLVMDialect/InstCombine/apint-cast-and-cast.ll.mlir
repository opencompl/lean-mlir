module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i43) -> i19 {
    %0 = llvm.mlir.constant(1 : i43) : i43
    %1 = llvm.bitcast %arg0 : i43 to i43
    %2 = llvm.and %1, %0  : i43
    %3 = llvm.trunc %2 : i43 to i19
    llvm.return %3 : i19
  }
  llvm.func @test2(%arg0: i677) -> i73 {
    %0 = llvm.mlir.constant(1 : i677) : i677
    %1 = llvm.bitcast %arg0 : i677 to i677
    %2 = llvm.and %1, %0  : i677
    %3 = llvm.trunc %2 : i677 to i73
    llvm.return %3 : i73
  }
}
