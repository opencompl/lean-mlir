module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func fastcc @func(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i128) : i128
    %2 = llvm.mlir.constant(200000000 : i128) : i128
    %3 = llvm.mlir.constant(10 : i128) : i128
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.icmp "ne" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i128
    %7 = llvm.sdiv %6, %3  : i128
    llvm.br ^bb1(%1 : i128)
  ^bb1(%8: i128):  // 2 preds: ^bb0, ^bb3
    %9 = llvm.icmp "sgt" %8, %7 : i128
    llvm.cond_br %9, ^bb4, ^bb2
  ^bb2:  // pred: ^bb1
    %10 = llvm.mul %8, %3  : i128
    %11 = llvm.sub %6, %1  : i128
    %12 = llvm.icmp "slt" %11, %10 : i128
    llvm.cond_br %12, ^bb4, ^bb3
  ^bb3:  // pred: ^bb2
    %13 = llvm.add %1, %10  : i128
    llvm.br ^bb1(%13 : i128)
  ^bb4:  // 2 preds: ^bb1, ^bb2
    llvm.return %4 : i32
  }
}
