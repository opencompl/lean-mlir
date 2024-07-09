module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @wyhash64_x(0 : i64) {addr_space = 0 : i32, alignment = 8 : i64} : i64
  llvm.func @_Z8wyhash64v() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @wyhash64_x : !llvm.ptr
    %2 = llvm.mlir.constant(6971258582664805397 : i64) : i64
    %3 = llvm.mlir.constant(11795372955171141389 : i128) : i128
    %4 = llvm.mlir.constant(64 : i128) : i128
    %5 = llvm.mlir.constant(1946526487930394057 : i128) : i128
    %6 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> i64
    %7 = llvm.add %6, %2  : i64
    llvm.store %7, %1 {alignment = 8 : i64} : i64, !llvm.ptr
    %8 = llvm.zext %7 : i64 to i128
    %9 = llvm.mul %8, %3  : i128
    %10 = llvm.lshr %9, %4  : i128
    %11 = llvm.xor %10, %9  : i128
    %12 = llvm.trunc %11 : i128 to i64
    %13 = llvm.zext %12 : i64 to i128
    %14 = llvm.mul %13, %5  : i128
    %15 = llvm.lshr %14, %4  : i128
    %16 = llvm.xor %15, %14  : i128
    %17 = llvm.trunc %16 : i128 to i64
    llvm.return %17 : i64
  }
}
