module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @sdiv_by_zero_indirect_is_poison(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    %2 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%2 : i1)
  ^bb3(%3: i1):  // 2 preds: ^bb1, ^bb2
    %4 = llvm.sdiv %arg1, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @udiv_by_zero_indirect_is_poison(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    %2 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%2 : i1)
  ^bb3(%3: i1):  // 2 preds: ^bb1, ^bb2
    %4 = llvm.udiv %arg1, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @srem_by_zero_indirect_is_poison(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    %2 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%2 : i1)
  ^bb3(%3: i1):  // 2 preds: ^bb1, ^bb2
    %4 = llvm.srem %arg1, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @urem_by_zero_indirect_is_poison(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    %2 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%2 : i1)
  ^bb3(%3: i1):  // 2 preds: ^bb1, ^bb2
    %4 = llvm.urem %arg1, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @sdiv_i1_is_op0(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1  : i1
    llvm.return %0 : i1
  }
  llvm.func @udiv_i1_is_op0(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg1  : i1
    llvm.return %0 : i1
  }
  llvm.func @srem_i1_is_zero(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.srem %arg0, %arg1  : i1
    llvm.return %0 : i1
  }
  llvm.func @urem_i1_is_zero(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.urem %arg0, %arg1  : i1
    llvm.return %0 : i1
  }
  llvm.func @pt62607() -> i1 {
    %0 = llvm.mlir.constant(109 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.trunc %0 : i8 to i1
    llvm.br ^bb1(%1 : i1)
  ^bb1(%4: i1):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.add %4, %2  : i1
    "llvm.intr.assume"(%5) : (i1) -> ()
    %6 = llvm.udiv %3, %4  : i1
    llvm.cond_br %6, ^bb1(%5 : i1), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %1 : i1
  }
}
