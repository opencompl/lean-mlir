module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg2, %arg0  : i32
    %1 = llvm.and %arg2, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg1, %arg0  : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @PR38781(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.lshr %arg1, %0  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.and %5, %3  : i32
    llvm.return %6 : i32
  }
  llvm.func @PR75692_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @PR75692_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @PR75692_3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
}
