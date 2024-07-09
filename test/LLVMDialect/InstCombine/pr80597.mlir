module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @pr80597(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(4294967293 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.mlir.constant(8836839514384105472 : i64) : i64
    %4 = llvm.mlir.constant(-34359738368 : i64) : i64
    %5 = llvm.mlir.constant(8836839522974040064 : i64) : i64
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.select %arg0, %0, %1 : i1, i64
    %8 = llvm.shl %7, %2  : i64
    %9 = llvm.add %8, %3  : i64
    %10 = llvm.icmp "ult" %9, %4 : i64
    llvm.cond_br %10, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %11 = llvm.or %8, %5  : i64
    %12 = llvm.ashr %11, %6  : i64
    llvm.return %12 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i64
  }
}
