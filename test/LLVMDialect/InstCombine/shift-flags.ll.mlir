module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @shl_add_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_add_nuw_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_add_nuw_and_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_add_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_add_nsw_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @lshr_add_exact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.lshr %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @lshr_add_exact_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.lshr %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @ashr_add_exact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-14 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.ashr %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @ashr_add_exact_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-14 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.ashr %2, %3  : i8
    llvm.return %4 : i8
  }
}
