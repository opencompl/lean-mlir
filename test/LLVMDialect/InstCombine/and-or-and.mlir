module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.and %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @test2(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg1, %0  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.lshr %arg1, %0  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @or_test2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }
}
