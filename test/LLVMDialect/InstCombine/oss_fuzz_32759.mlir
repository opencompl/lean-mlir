module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @oss_fuzz_32759(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %4 = llvm.zext %arg0 : i1 to i32
    %5 = llvm.shl %4, %1  : i32
    %6 = llvm.ashr %5, %1  : i32
    %7 = llvm.srem %6, %2  : i32
    %8 = llvm.xor %7, %6  : i32
    llvm.br ^bb2(%8 : i32)
  ^bb2(%9: i32):  // 2 preds: ^bb0, ^bb1
    %10 = llvm.icmp "eq" %9, %3 : i32
    llvm.return %10 : i1
  }
}
