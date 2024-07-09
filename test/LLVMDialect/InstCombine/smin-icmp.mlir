module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @eq_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @eq_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @eq_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "eq" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @eq_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "eq" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @sge_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sge" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @sge_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "sge" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @sge_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "sle" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @sge_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "sle" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @ne_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ne_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ne_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @ne_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @slt_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "slt" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @slt_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "slt" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @slt_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "sgt" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @slt_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "sgt" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @sle_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sle" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @sle_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "sle" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @sle_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "sge" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @sle_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "sge" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @sgt_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sgt" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @sgt_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "sgt" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @sgt_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @sgt_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @use(i1)
  llvm.func @eq_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
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
  llvm.func @eq_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
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
  llvm.func @slt_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
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
  llvm.func @slt_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
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
  llvm.func @sle_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sle" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
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
  llvm.func @sle_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sle" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
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
  llvm.func @sgt_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
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
  llvm.func @sgt_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
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
  llvm.func @sge_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sge" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
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
  llvm.func @sge_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sge" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
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
  llvm.func @use_v2i1(vector<2xi1>)
  llvm.func @eq_smin_v2i32(%arg0: vector<2xi32>, %arg1: vector<2xi32>) {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %1 = llvm.icmp "slt" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%1) : (vector<2xi1>) -> ()
    %2 = llvm.icmp "sle" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%2) : (vector<2xi1>) -> ()
    %3 = llvm.icmp "sgt" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "sge" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %5 = llvm.icmp "ult" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "ule" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ugt" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "uge" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "eq" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "ne" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    llvm.return
  }
  llvm.func @eq_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.smin(%0, %arg0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "slt" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%2) : (vector<2xi1>) -> ()
    %3 = llvm.icmp "sle" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "sgt" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %5 = llvm.icmp "sge" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ule" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "ugt" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "uge" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "eq" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    llvm.return
  }
  llvm.func @slt_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smin(%0, %arg0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "sle" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %5 = llvm.icmp "sgt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "sge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "ule" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "uge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    llvm.return
  }
  llvm.func @sle_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<[5, 10]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smin(%0, %arg0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "sle" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %5 = llvm.icmp "sgt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "sge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "ule" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "uge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    llvm.return
  }
  llvm.func @sgt_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smin(%0, %arg0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "sle" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %5 = llvm.icmp "sgt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "sge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "ule" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "uge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    llvm.return
  }
  llvm.func @sge_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<[15, 10]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smin(%0, %arg0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "sle" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %5 = llvm.icmp "sgt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "sge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "ule" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "uge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    llvm.return
  }
  llvm.func @unknown_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<[5, 15]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smin(%0, %arg0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "sle" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %5 = llvm.icmp "sgt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "sge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "ule" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "uge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    llvm.return
  }
  llvm.func @smin_or_bitwise(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @smin_and_bitwise(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @eq_smin_nofold(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }
}
