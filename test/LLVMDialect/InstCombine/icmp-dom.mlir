module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @idom_sign_bit_check_edge_dominates(%arg0: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4
  ^bb2:  // pred: ^bb0
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return
  }
  llvm.func @idom_sign_bit_check_edge_not_dominates(%arg0: i64, %arg1: i1) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4, ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return
  }
  llvm.func @idom_sign_bit_check_edge_dominates_select(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4
  ^bb2:  // pred: ^bb0
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.select %2, %arg0, %0 : i1, i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    llvm.cond_br %4, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return
  }
  llvm.func @idom_zbranch(%arg0: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }
  llvm.func @idom_not_zbranch(%arg0: i32, %arg1: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %1, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "ne" %3, %arg1 : i32
    llvm.cond_br %4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }
  llvm.func @trueblock_cmp_eq(%arg0: i32, %arg1: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.cond_br %3, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }
  llvm.func @trueblock_cmp_is_false(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i1
  }
  llvm.func @trueblock_cmp_is_false_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i32
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i1
  }
  llvm.func @trueblock_cmp_is_true(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i1
  }
  llvm.func @trueblock_cmp_is_true_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.icmp "ne" %arg1, %arg0 : i32
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i1
  }
  llvm.func @falseblock_cmp_is_false(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.return %1 : i1
  }
  llvm.func @falseblock_cmp_is_false_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    %1 = llvm.icmp "eq" %arg1, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @falseblock_cmp_is_true(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    %1 = llvm.icmp "uge" %arg0, %arg1 : i32
    llvm.return %1 : i1
  }
  llvm.func @falseblock_cmp_is_true_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    %1 = llvm.icmp "sge" %arg1, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @PR48900(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg0, %0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.icmp "ult" %4, %2 : i32
    %7 = llvm.select %6, %4, %2 : i1, i32
    llvm.return %7 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }
  llvm.func @PR48900_alt(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(-126 : i8) : i8
    %4 = llvm.icmp "sgt" %arg0, %0 : i8
    %5 = llvm.select %4, %arg0, %0 : i1, i8
    %6 = llvm.icmp "ugt" %5, %1 : i8
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %7 = llvm.icmp "slt" %5, %3 : i8
    %8 = llvm.select %7, %5, %3 : i1, i8
    llvm.return %8 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i8
  }
  llvm.func @and_mask1_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.return %7 : i1
  }
  llvm.func @and_mask1_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    llvm.return %7 : i1
  }
  llvm.func @and_mask2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.return %7 : i1
  }
  llvm.func @and_mask3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.return %7 : i1
  }
  llvm.func @and_mask4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.return %7 : i1
  }
}
