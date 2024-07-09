module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i23) -> i23 {
    %0 = llvm.mlir.constant(-1 : i23) : i23
    %1 = llvm.xor %0, %arg0  : i23
    %2 = llvm.or %arg0, %1  : i23
    llvm.return %2 : i23
  }
  llvm.func @test2(%arg0: i39, %arg1: i39) -> i39 {
    %0 = llvm.mlir.constant(274877906943 : i39) : i39
    %1 = llvm.mlir.constant(-1 : i39) : i39
    %2 = llvm.mlir.constant(-274877906944 : i39) : i39
    %3 = llvm.xor %0, %1  : i39
    %4 = llvm.and %arg1, %2  : i39
    %5 = llvm.add %arg0, %4  : i39
    %6 = llvm.and %5, %3  : i39
    %7 = llvm.and %arg0, %0  : i39
    %8 = llvm.or %6, %7  : i39
    llvm.return %8 : i39
  }
  llvm.func @test4(%arg0: i1023) -> i1023 {
    %0 = llvm.mlir.constant(-1 : i1023) : i1023
    %1 = llvm.xor %0, %arg0  : i1023
    %2 = llvm.or %arg0, %1  : i1023
    llvm.return %2 : i1023
  }
  llvm.func @test5(%arg0: i399, %arg1: i399) -> i399 {
    %0 = llvm.mlir.constant(274877906943 : i399) : i399
    %1 = llvm.mlir.constant(-1 : i399) : i399
    %2 = llvm.mlir.constant(18446742974197923840 : i399) : i399
    %3 = llvm.xor %0, %1  : i399
    %4 = llvm.and %arg1, %2  : i399
    %5 = llvm.add %arg0, %4  : i399
    %6 = llvm.and %5, %3  : i399
    %7 = llvm.and %arg0, %0  : i399
    %8 = llvm.or %6, %7  : i399
    llvm.return %8 : i399
  }
}
