module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @urem_assume(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }
  llvm.func @urem_assume_without_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }
  llvm.func @urem_assume_eq(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %arg1 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }
  llvm.func @urem_assume_ne(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %arg1 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }
  llvm.func @urem_assume_with_unexpected_const(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }
  llvm.func @urem_without_assume(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.urem %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }
  llvm.func @urem_with_dominating_condition(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg0, %1  : i8
    %4 = llvm.urem %3, %arg1  : i8
    llvm.return %4 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i8
  }
  llvm.func @urem_with_dominating_condition_false(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.urem %3, %arg1  : i8
    llvm.return %4 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i8
  }
  llvm.func @urem_with_opposite_condition(%arg0: i8, %arg1: i8) -> (i8 {llvm.noundef}) {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.urem %3, %arg1  : i8
    llvm.return %4 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i8
  }
}
