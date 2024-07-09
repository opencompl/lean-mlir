module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @ggenorien() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.icmp "eq" %0, %0 : !llvm.ptr
    llvm.cond_br %4, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.cond_br %2, ^bb5(%1 : i32), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4(%1 : i32)
  ^bb4(%5: i32):  // 2 preds: ^bb3, ^bb5
    %6 = llvm.add %5, %3  : i32
    llvm.br ^bb5(%6 : i32)
  ^bb5(%7: i32):  // 2 preds: ^bb2, ^bb4
    llvm.br ^bb4(%7 : i32)
  }
}
