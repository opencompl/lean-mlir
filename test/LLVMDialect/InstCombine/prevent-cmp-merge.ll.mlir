module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.icmp "eq" %2, %arg1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @test1_logical(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.icmp "eq" %3, %arg1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @test2(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "eq" %2, %1 : i32
    %5 = llvm.xor %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @test3(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "eq" %2, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @test3_logical(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.icmp "eq" %3, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }
}
