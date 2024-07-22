module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fast_div_201(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(71 : i16) : i16
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.constant(7 : i8) : i8
    %4 = llvm.zext %arg0 : i8 to i16
    %5 = llvm.mul %4, %0  : i16
    %6 = llvm.lshr %5, %1  : i16
    %7 = llvm.trunc %6 : i16 to i8
    %8 = llvm.sub %arg0, %7  : i8
    %9 = llvm.lshr %8, %2  : i8
    %10 = llvm.add %7, %9  : i8
    %11 = llvm.lshr %10, %3  : i8
    llvm.return %11 : i8
  }
}
