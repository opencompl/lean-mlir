module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(511 : i16) : i16
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.intr.bswap(%2)  : (i16) -> i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.icmp "eq" %4, %1 : i16
    llvm.return %5 : i1
  }
  llvm.func @test2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.intr.bswap(%2)  : (i16) -> i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.icmp "eq" %4, %1 : i16
    llvm.return %5 : i1
  }
  llvm.func @test3(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(256 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.intr.bswap(%2)  : (i16) -> i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.icmp "eq" %4, %1 : i16
    llvm.return %5 : i1
  }
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.bswap(%2)  : (i32) -> i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.return %5 : i1
  }
}
