module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @or_implies_sle(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "sle" %1, %arg1 : i8
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "sle" %arg0, %arg1 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }
  llvm.func @or_implies_sle_fail(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-34 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "sle" %1, %arg1 : i8
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "sle" %arg0, %arg1 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }
  llvm.func @or_distjoint_implies_ule(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.icmp "ule" %3, %arg1 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "ule" %2, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }
  llvm.func @or_distjoint_implies_ule_fail(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(28 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.icmp "ule" %3, %arg1 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "ule" %2, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }
  llvm.func @or_prove_distjoin_implies_ule(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-16 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(10 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.or %3, %2  : i8
    %6 = llvm.icmp "ule" %5, %arg1 : i8
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %7 = llvm.icmp "ule" %4, %arg1 : i8
    llvm.return %7 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }
  llvm.func @src_or_distjoint_implies_sle(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.icmp "sle" %3, %arg1 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "sle" %2, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }
  llvm.func @src_or_distjoint_implies_sle_fail(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.icmp "sle" %arg1, %3 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "sle" %2, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }
  llvm.func @src_addnsw_implies_sle(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.add %arg0, %1 overflow<nsw>  : i8
    %4 = llvm.icmp "sle" %3, %arg1 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "sle" %2, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }
  llvm.func @src_addnsw_implies_sle_fail(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(24 : i8) : i8
    %1 = llvm.mlir.constant(23 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.add %arg0, %1 overflow<nsw>  : i8
    %4 = llvm.icmp "sle" %3, %arg1 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "sle" %2, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }
  llvm.func @src_and_implies_ult(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg2 : i8
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg2, %arg0  : i8
    %2 = llvm.icmp "ult" %1, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }
  llvm.func @src_and_implies_ult_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg2 : i8
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg0, %arg2  : i8
    %2 = llvm.icmp "ult" %1, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }
  llvm.func @src_and_implies_slt_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i8
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg0, %arg1  : i8
    %2 = llvm.icmp "slt" %1, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }
  llvm.func @src_or_implies_ule(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.or %arg1, %arg0  : i8
    %1 = llvm.icmp "uge" %arg2, %0 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "ule" %arg0, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }
  llvm.func @src_or_implies_false_ugt_todo(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "ugt" %0, %arg2 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %arg3 : i1
  ^bb2:  // pred: ^bb0
    %2 = llvm.icmp "ugt" %arg0, %arg2 : i8
    llvm.return %2 : i1
  }
  llvm.func @src_udiv_implies_ult(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg1 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }
  llvm.func @src_udiv_implies_ult2(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %arg2 : i1
  ^bb2:  // pred: ^bb0
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg1 : i8
    llvm.return %3 : i1
  }
  llvm.func @src_smin_implies_sle(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg2 : i8
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "sle" %1, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }
  llvm.func @src_umin_implies_ule(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg2 : i8
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "ule" %1, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }
  llvm.func @src_umax_implies_ule(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.icmp "ule" %0, %arg2 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "ule" %arg0, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }
  llvm.func @src_smax_implies_sle(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.icmp "sle" %0, %arg2 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "sle" %arg0, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }
}
