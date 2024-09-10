module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 64 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @timeout(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i8) : i8
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb3
    %3 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i16
    %4 = llvm.load %3 {alignment = 2 : i64} : !llvm.ptr -> i16
    %5 = llvm.icmp "eq" %4, %1 : i16
    llvm.cond_br %5, ^bb2, ^bb3(%4 : i16)
  ^bb2:  // pred: ^bb1
    %6 = llvm.load %3 {alignment = 2 : i64} : !llvm.ptr -> i16
    llvm.br ^bb3(%6 : i16)
  ^bb3(%7: i16):  // 2 preds: ^bb1, ^bb2
    %8 = llvm.trunc %7 : i16 to i8
    %9 = llvm.add %8, %2  : i8
    llvm.store %9, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.br ^bb1
  }
}
