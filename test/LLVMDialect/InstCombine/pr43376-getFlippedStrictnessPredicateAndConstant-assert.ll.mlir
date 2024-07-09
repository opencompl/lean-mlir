module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @d(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(3 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i16) : i16
    %4 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i16
    %5 = llvm.icmp "ne" %4, %0 : i16
    llvm.cond_br %5, ^bb1, ^bb2(%1 : i1)
  ^bb1:  // pred: ^bb0
    %6 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i16
    %7 = llvm.icmp "ult" %6, %0 : i16
    llvm.br ^bb2(%7 : i1)
  ^bb2(%8: i1):  // 2 preds: ^bb0, ^bb1
    %9 = llvm.zext %8 : i1 to i16
    %10 = llvm.mul %9, %2 overflow<nsw>  : i16
    %11 = llvm.xor %10, %3  : i16
    llvm.return %11 : i16
  }
}
