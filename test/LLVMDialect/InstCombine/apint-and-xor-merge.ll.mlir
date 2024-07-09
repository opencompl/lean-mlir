module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i57, %arg1: i57, %arg2: i57) -> i57 {
    %0 = llvm.and %arg2, %arg0  : i57
    %1 = llvm.and %arg2, %arg1  : i57
    %2 = llvm.xor %0, %1  : i57
    llvm.return %2 : i57
  }
  llvm.func @test2(%arg0: i23, %arg1: i23, %arg2: i23) -> i23 {
    %0 = llvm.and %arg1, %arg0  : i23
    %1 = llvm.or %arg1, %arg0  : i23
    %2 = llvm.xor %0, %1  : i23
    llvm.return %2 : i23
  }
}
