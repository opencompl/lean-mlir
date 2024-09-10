module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i33, %arg1: i33) -> i1 {
    %0 = llvm.mlir.constant(65280 : i33) : i33
    %1 = llvm.and %arg0, %0  : i33
    %2 = llvm.and %arg1, %0  : i33
    %3 = llvm.icmp "ne" %1, %2 : i33
    llvm.return %3 : i1
  }
  llvm.func @test2(%arg0: i999, %arg1: i999) -> i1 {
    %0 = llvm.mlir.constant(65280 : i999) : i999
    %1 = llvm.and %arg0, %0  : i999
    %2 = llvm.and %arg1, %0  : i999
    %3 = llvm.icmp "ne" %1, %2 : i999
    llvm.return %3 : i1
  }
}
