module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @sel_false_val_is_a_masked_shl_of_true_val1(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw, nuw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }
  llvm.func @sel_false_val_is_a_masked_shl_of_true_val2(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw, nuw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %4, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }
  llvm.func @sel_false_val_is_a_masked_lshr_of_true_val1(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(60 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }
  llvm.func @sel_false_val_is_a_masked_lshr_of_true_val2(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(60 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %4, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }
  llvm.func @sel_false_val_is_a_masked_ashr_of_true_val1(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-2147483588 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.ashr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }
  llvm.func @sel_false_val_is_a_masked_ashr_of_true_val2(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-2147483588 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.ashr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %4, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }
}
