module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @eq_smax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @eq_smax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @eq_smax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "eq" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @eq_smax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "eq" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @sle_smax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sle" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @sle_smax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "sle" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @sle_smax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "sge" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @sle_smax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "sge" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @ne_smax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ne_smax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ne_smax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @ne_smax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @sgt_smax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sgt" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @sgt_smax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "sgt" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @sgt_smax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @sgt_smax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @use(i1)
  llvm.func @eq_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @eq_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @slt_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @slt_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @sle_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sle" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @sle_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sle" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @sgt_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @sgt_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @sge_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sge" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @sge_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sge" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @test_smax_ugt(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_smax_ugt_neg1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_smax_ugt_neg2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }
}
