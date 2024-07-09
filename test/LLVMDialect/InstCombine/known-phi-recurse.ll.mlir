module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @single_entry_phi(%arg0: i64, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i64) -> i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %arg1, ^bb2(%2 : i32), ^bb1
  ^bb2(%3: i32):  // pred: ^bb1
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @two_entry_phi_with_constant(%arg0: i64, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i64) -> i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.cond_br %arg1, ^bb2(%2 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @two_entry_phi_non_constant(%arg0: i64, %arg1: i64, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i64) -> i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.cond_br %arg2, ^bb2(%2 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.ctpop(%arg1)  : (i64) -> i64
    %4 = llvm.trunc %3 : i64 to i32
    llvm.br ^bb2(%4 : i32)
  ^bb2(%5: i32):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.and %5, %0  : i32
    llvm.return %6 : i32
  }
  llvm.func @neg_many_branches(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(255 : i32) : i32
    %5 = llvm.intr.ctpop(%arg0)  : (i64) -> i64
    %6 = llvm.trunc %5 : i64 to i32
    llvm.switch %6 : i32, ^bb5(%6 : i32) [
      1: ^bb1,
      2: ^bb2,
      3: ^bb3,
      4: ^bb4
    ]
  ^bb1:  // pred: ^bb0
    %7 = llvm.add %6, %3  : i32
    llvm.br ^bb5(%7 : i32)
  ^bb2:  // pred: ^bb0
    %8 = llvm.add %6, %2  : i32
    llvm.br ^bb5(%8 : i32)
  ^bb3:  // pred: ^bb0
    %9 = llvm.add %6, %1  : i32
    llvm.br ^bb5(%9 : i32)
  ^bb4:  // pred: ^bb0
    %10 = llvm.add %6, %0  : i32
    llvm.br ^bb5(%10 : i32)
  ^bb5(%11: i32):  // 5 preds: ^bb0, ^bb1, ^bb2, ^bb3, ^bb4
    %12 = llvm.and %11, %4  : i32
    llvm.return %12 : i32
  }
}
