module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @func(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1231558963 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.xor %arg0, %0  : i32
    llvm.br ^bb1(%5 : i32)
  ^bb1(%6: i32):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.select %arg1, %1, %2 : i1, i32
    %8 = llvm.xor %7, %6  : i32
    %9 = llvm.icmp "ne" %8, %3 : i32
    %10 = llvm.zext %9 : i1 to i32
    llvm.cond_br %9, ^bb1(%10 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i64
  }
}
