module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @log2_ceil_idiom(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @log2_ceil_idiom_trunc(%arg0: i32) -> i5 {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.trunc %2 : i32 to i5
    %4 = llvm.xor %3, %0  : i5
    %5 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i5
    %8 = llvm.add %4, %7  : i5
    llvm.return %8 : i5
  }
  llvm.func @log2_ceil_idiom_zext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i64
    %8 = llvm.add %4, %7  : i64
    llvm.return %8 : i64
  }
  llvm.func @log2_ceil_idiom_power2_test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @log2_ceil_idiom_commuted(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @log2_ceil_idiom_multiuse1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @log2_ceil_idiom_x_may_be_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @log2_ceil_idiom_trunc_too_short(%arg0: i32) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.trunc %2 : i32 to i4
    %4 = llvm.xor %3, %0  : i4
    %5 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i4
    %8 = llvm.add %4, %7  : i4
    llvm.return %8 : i4
  }
  llvm.func @log2_ceil_idiom_mismatched_operands(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @log2_ceil_idiom_wrong_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @log2_ceil_idiom_not_a_power2_test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @log2_ceil_idiom_not_a_power2_test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @log2_ceil_idiom_multiuse2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @log2_ceil_idiom_multiuse3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @log2_ceil_idiom_trunc_multiuse4(%arg0: i32) -> i5 {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.trunc %2 : i32 to i5
    llvm.call @use5(%3) : (i5) -> ()
    %4 = llvm.xor %3, %0  : i5
    %5 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i5
    %8 = llvm.add %4, %7  : i5
    llvm.return %8 : i5
  }
  llvm.func @log2_ceil_idiom_zext_multiuse5(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i64
    %8 = llvm.add %4, %7  : i64
    llvm.return %8 : i64
  }
  llvm.func @use5(i5)
  llvm.func @use32(i32)
  llvm.func @use64(i64)
}
