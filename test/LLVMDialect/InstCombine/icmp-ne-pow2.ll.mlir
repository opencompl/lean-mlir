module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @pow2_32_assume(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.and %arg0, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @not_pow2_32_assume(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.and %arg0, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @pow2_64_assume(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.or %arg0, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @not_pow2_64_assume(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.or %arg0, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @pow2_16_assume(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(16384 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.icmp "eq" %1, %0 : i16
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.and %arg0, %0  : i16
    llvm.return %3 : i16
  }
  llvm.func @not_pow2_16_assume(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.icmp "ne" %1, %0 : i16
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.and %arg0, %0  : i16
    llvm.return %3 : i16
  }
  llvm.func @pow2_8_assume(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.or %arg0, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_pow2_8_assume(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.or %arg0, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @pow2_32_br(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.or %arg0, %0  : i32
    llvm.return %4 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }
  llvm.func @not_pow2_32_br(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.or %arg0, %0  : i32
    llvm.return %4 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }
  llvm.func @pow2_64_br(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.and %arg0, %0  : i64
    llvm.return %4 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i64
  }
  llvm.func @not_pow2_64_br(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.and %arg0, %0  : i64
    llvm.return %4 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i64
  }
  llvm.func @pow2_16_br(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(16384 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.icmp "eq" %2, %0 : i16
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.or %arg0, %0  : i16
    llvm.return %4 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }
  llvm.func @not_pow2_16_br(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.icmp "ne" %2, %0 : i16
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.or %arg0, %0  : i16
    llvm.return %4 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }
  llvm.func @pow2_8_br(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.and %arg0, %0  : i8
    llvm.return %4 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i8
  }
  llvm.func @not_pow2_8_br(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.and %arg0, %0  : i8
    llvm.return %4 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i8
  }
  llvm.func @pow2_32_nonconst_assume(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.and %arg0, %arg1  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    "llvm.intr.assume"(%5) : (i1) -> ()
    %6 = llvm.and %arg0, %arg1  : i32
    llvm.return %6 : i32
  }
  llvm.func @pow2_32_gtnonconst_assume(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.icmp "ugt" %arg1, %arg0 : i32
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.and %arg0, %arg1  : i32
    llvm.return %4 : i32
  }
  llvm.func @not_pow2_32_nonconst_assume(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.and %arg0, %arg1  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    "llvm.intr.assume"(%5) : (i1) -> ()
    %6 = llvm.and %arg0, %arg1  : i32
    llvm.return %6 : i32
  }
  llvm.func @pow2_or_zero_32_nonconst_assume(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %3 = llvm.icmp "ule" %2, %0 : i32
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.and %arg0, %arg1  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    "llvm.intr.assume"(%5) : (i1) -> ()
    %6 = llvm.and %arg0, %arg1  : i32
    llvm.return %6 : i32
  }
  llvm.func @pow2_32_nonconst_assume_br(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.and %arg0, %arg1  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.and %arg0, %arg1  : i32
    llvm.return %6 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }
  llvm.func @not_pow2_32_nonconst_assume_br(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.and %arg0, %arg1  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.and %arg0, %arg1  : i32
    llvm.return %6 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }
  llvm.func @pow2_or_zero_32_nonconst_assume_br(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %3 = llvm.icmp "ule" %2, %0 : i32
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.and %arg0, %arg1  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.and %arg0, %arg1  : i32
    llvm.return %6 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }
  llvm.func @pow2_32_nonconst_br1_br(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.cond_br %3, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %4 = llvm.and %arg0, %arg1  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.cond_br %5, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %6 = llvm.and %arg0, %arg1  : i32
    llvm.return %6 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }
  llvm.func @not_pow2_32_nonconst_br1_br(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.cond_br %3, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %4 = llvm.and %arg0, %arg1  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.cond_br %5, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %6 = llvm.and %arg0, %arg1  : i32
    llvm.return %6 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }
  llvm.func @maybe_pow2_32_noncont(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.icmp "ugt" %arg1, %0 : i32
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    "llvm.intr.assume"(%6) : (i1) -> ()
    llvm.cond_br %2, ^bb2, ^bb4
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %7 = llvm.and %arg0, %arg1  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    llvm.cond_br %8, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %9 = llvm.and %arg0, %arg1  : i32
    llvm.return %9 : i32
  ^bb4:  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : i32
  }
}
