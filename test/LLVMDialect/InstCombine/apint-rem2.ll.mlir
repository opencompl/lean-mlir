module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i333) -> i333 {
    %0 = llvm.mlir.constant(70368744177664 : i333) : i333
    %1 = llvm.urem %arg0, %0  : i333
    llvm.return %1 : i333
  }
  llvm.func @test2(%arg0: i499) -> i499 {
    %0 = llvm.mlir.constant(4096 : i499) : i499
    %1 = llvm.mlir.constant(111 : i499) : i499
    %2 = llvm.shl %0, %1  : i499
    %3 = llvm.urem %arg0, %2  : i499
    llvm.return %3 : i499
  }
  llvm.func @test3(%arg0: i599, %arg1: i1) -> i599 {
    %0 = llvm.mlir.constant(70368744177664 : i599) : i599
    %1 = llvm.mlir.constant(4096 : i599) : i599
    %2 = llvm.select %arg1, %0, %1 : i1, i599
    %3 = llvm.urem %arg0, %2  : i599
    llvm.return %3 : i599
  }
}
