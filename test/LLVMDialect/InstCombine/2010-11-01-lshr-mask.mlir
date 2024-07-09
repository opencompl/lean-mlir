module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @main(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(122 : i8) : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.mlir.constant(7 : i8) : i8
    %4 = llvm.mlir.constant(64 : i8) : i8
    %5 = llvm.trunc %arg0 : i32 to i8
    %6 = llvm.or %5, %0  : i8
    %7 = llvm.and %5, %1  : i8
    %8 = llvm.xor %7, %0  : i8
    %9 = llvm.shl %8, %2  : i8
    %10 = llvm.xor %9, %8  : i8
    %11 = llvm.xor %6, %10  : i8
    %12 = llvm.lshr %11, %3  : i8
    %13 = llvm.mul %12, %4  : i8
    %14 = llvm.zext %13 : i8 to i32
    llvm.return %14 : i32
  }
  llvm.func @foo(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(84 : i8) : i8
    %2 = llvm.mlir.constant(-118 : i8) : i8
    %3 = llvm.mlir.constant(33 : i8) : i8
    %4 = llvm.mlir.constant(-88 : i8) : i8
    %5 = llvm.mlir.constant(5 : i8) : i8
    %6 = llvm.shl %arg0, %0  : i8
    %7 = llvm.and %arg1, %1  : i8
    %8 = llvm.and %arg1, %2  : i8
    %9 = llvm.and %arg1, %3  : i8
    %10 = llvm.sub %4, %7  : i8
    %11 = llvm.and %10, %1  : i8
    %12 = llvm.or %9, %11  : i8
    %13 = llvm.xor %6, %8  : i8
    %14 = llvm.or %12, %13  : i8
    %15 = llvm.lshr %13, %0  : i8
    %16 = llvm.shl %15, %5  : i8
    %17 = llvm.xor %16, %14  : i8
    llvm.return %17 : i8
  }
}
