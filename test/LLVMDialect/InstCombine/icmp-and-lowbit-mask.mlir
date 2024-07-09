module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use.i8(i8)
  llvm.func @use.i16(i16)
  llvm.func @src_is_mask_zext(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i16
    %3 = llvm.lshr %1, %arg1  : i8
    %4 = llvm.zext %3 : i8 to i16
    %5 = llvm.and %2, %4  : i16
    %6 = llvm.icmp "eq" %5, %2 : i16
    llvm.return %6 : i1
  }
  llvm.func @src_is_mask_zext_fail_not_mask(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i16
    %3 = llvm.lshr %1, %arg1  : i8
    %4 = llvm.zext %3 : i8 to i16
    %5 = llvm.and %2, %4  : i16
    %6 = llvm.icmp "eq" %5, %2 : i16
    llvm.return %6 : i1
  }
  llvm.func @src_is_mask_sext(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.xor %arg0, %0  : i16
    %5 = llvm.lshr %1, %arg1  : i8
    %6 = llvm.sext %5 : i8 to i16
    %7 = llvm.xor %6, %2  : i16
    %8 = llvm.and %7, %4  : i16
    %9 = llvm.icmp "eq" %8, %3 : i16
    llvm.return %9 : i1
  }
  llvm.func @src_is_mask_sext_fail_multiuse(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.xor %arg0, %0  : i16
    %5 = llvm.lshr %1, %arg1  : i8
    %6 = llvm.sext %5 : i8 to i16
    %7 = llvm.xor %6, %2  : i16
    %8 = llvm.and %7, %4  : i16
    llvm.call @use.i16(%8) : (i16) -> ()
    %9 = llvm.icmp "eq" %8, %3 : i16
    llvm.return %9 : i1
  }
  llvm.func @src_is_mask_and(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.ashr %1, %arg1  : i8
    %5 = llvm.lshr %2, %arg2  : i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.and %3, %6  : i8
    %8 = llvm.icmp "eq" %3, %7 : i8
    llvm.return %8 : i1
  }
  llvm.func @src_is_mask_and_fail_mixed(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.ashr %1, %arg1  : i8
    %5 = llvm.lshr %2, %arg2  : i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.and %3, %6  : i8
    %8 = llvm.icmp "eq" %3, %7 : i8
    llvm.return %8 : i1
  }
  llvm.func @src_is_mask_or(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.lshr %1, %arg1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.and %5, %3  : i8
    %7 = llvm.icmp "eq" %3, %6 : i8
    llvm.return %7 : i1
  }
  llvm.func @src_is_mask_xor(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.xor %arg1, %3  : i8
    %5 = llvm.and %2, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @src_is_mask_xor_fail_notmask(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.xor %arg1, %3  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.and %2, %5  : i8
    %7 = llvm.icmp "ne" %6, %2 : i8
    llvm.return %7 : i1
  }
  llvm.func @src_is_mask_select(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.select %arg2, %5, %2 : i1, i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "ne" %7, %3 : i8
    llvm.return %8 : i1
  }
  llvm.func @src_is_mask_select_fail_wrong_pattern(%arg0: i8, %arg1: i8, %arg2: i1, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.select %arg2, %5, %2 : i1, i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "ne" %7, %arg3 : i8
    llvm.return %8 : i1
  }
  llvm.func @src_is_mask_shl_lshr(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.shl %1, %arg1  : i8
    %5 = llvm.lshr %4, %arg1  : i8
    %6 = llvm.xor %5, %1  : i8
    %7 = llvm.and %3, %6  : i8
    %8 = llvm.icmp "ne" %2, %7 : i8
    llvm.return %8 : i1
  }
  llvm.func @src_is_mask_shl_lshr_fail_not_allones(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.shl %1, %arg1  : i8
    %6 = llvm.lshr %5, %arg1  : i8
    %7 = llvm.xor %6, %2  : i8
    %8 = llvm.and %4, %7  : i8
    %9 = llvm.icmp "ne" %3, %8 : i8
    llvm.return %9 : i1
  }
  llvm.func @src_is_mask_lshr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.select %arg3, %5, %2 : i1, i8
    %7 = llvm.lshr %6, %arg2  : i8
    %8 = llvm.and %7, %3  : i8
    %9 = llvm.icmp "ne" %3, %8 : i8
    llvm.return %9 : i1
  }
  llvm.func @src_is_mask_ashr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.select %arg3, %5, %2 : i1, i8
    %7 = llvm.ashr %6, %arg2  : i8
    %8 = llvm.and %3, %7  : i8
    %9 = llvm.icmp "ult" %8, %3 : i8
    llvm.return %9 : i1
  }
  llvm.func @src_is_mask_p2_m1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.shl %1, %arg1  : i8
    %5 = llvm.add %4, %2  : i8
    %6 = llvm.and %5, %3  : i8
    %7 = llvm.icmp "ult" %6, %3 : i8
    llvm.return %7 : i1
  }
  llvm.func @src_is_mask_umax(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.intr.umax(%5, %2)  : (i8, i8) -> i8
    %7 = llvm.and %3, %6  : i8
    %8 = llvm.icmp "ugt" %3, %7 : i8
    llvm.return %8 : i1
  }
  llvm.func @src_is_mask_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.lshr %2, %arg2  : i8
    %7 = llvm.intr.umin(%5, %6)  : (i8, i8) -> i8
    %8 = llvm.and %7, %3  : i8
    %9 = llvm.icmp "ugt" %3, %8 : i8
    llvm.return %9 : i1
  }
  llvm.func @src_is_mask_umin_fail_mismatch(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-32 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.intr.umin(%5, %2)  : (i8, i8) -> i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "ugt" %3, %7 : i8
    llvm.return %8 : i1
  }
  llvm.func @src_is_mask_smax(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.xor %arg1, %3  : i8
    %5 = llvm.intr.smax(%4, %1)  : (i8, i8) -> i8
    %6 = llvm.and %2, %5  : i8
    %7 = llvm.icmp "uge" %6, %2 : i8
    llvm.return %7 : i1
  }
  llvm.func @src_is_mask_smin(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.intr.smin(%5, %2)  : (i8, i8) -> i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "uge" %7, %3 : i8
    llvm.return %8 : i1
  }
  llvm.func @src_is_mask_bitreverse_not_mask(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.shl %1, %arg1  : i8
    %4 = llvm.intr.bitreverse(%3)  : (i8) -> i8
    %5 = llvm.and %2, %4  : i8
    %6 = llvm.icmp "ule" %2, %5 : i8
    llvm.return %6 : i1
  }
  llvm.func @src_is_notmask_sext(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.xor %arg0, %0  : i16
    %4 = llvm.shl %1, %arg1  : i8
    %5 = llvm.sext %4 : i8 to i16
    %6 = llvm.xor %5, %2  : i16
    %7 = llvm.and %6, %3  : i16
    %8 = llvm.icmp "ule" %3, %7 : i16
    llvm.return %8 : i1
  }
  llvm.func @src_is_notmask_shl(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.shl %1, %arg1  : i8
    %6 = llvm.intr.bitreverse(%5)  : (i8) -> i8
    %7 = llvm.xor %6, %1  : i8
    %8 = llvm.select %arg2, %7, %2 : i1, i8
    %9 = llvm.and %4, %8  : i8
    %10 = llvm.icmp "eq" %9, %3 : i8
    llvm.return %10 : i1
  }
  llvm.func @src_is_notmask_x_xor_neg_x(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.sub %1, %arg1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.select %arg2, %5, %2 : i1, i8
    %7 = llvm.and %3, %6  : i8
    %8 = llvm.icmp "eq" %7, %1 : i8
    llvm.return %8 : i1
  }
  llvm.func @src_is_notmask_x_xor_neg_x_inv(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.sub %1, %arg1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.select %arg2, %5, %2 : i1, i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "eq" %7, %1 : i8
    llvm.return %8 : i1
  }
  llvm.func @src_is_notmask_shl_fail_multiuse_invert(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.shl %1, %arg1  : i8
    %6 = llvm.intr.bitreverse(%5)  : (i8) -> i8
    %7 = llvm.xor %6, %1  : i8
    %8 = llvm.select %arg2, %7, %2 : i1, i8
    llvm.call @use.i8(%8) : (i8) -> ()
    %9 = llvm.and %4, %8  : i8
    %10 = llvm.icmp "eq" %9, %3 : i8
    llvm.return %10 : i1
  }
  llvm.func @src_is_notmask_lshr_shl(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %1, %arg1  : i8
    %4 = llvm.shl %3, %arg1  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.and %5, %2  : i8
    %7 = llvm.icmp "eq" %6, %2 : i8
    llvm.return %7 : i1
  }
  llvm.func @src_is_notmask_lshr_shl_fail_mismatch_shifts(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %1, %arg1  : i8
    %4 = llvm.shl %3, %arg2  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.and %5, %2  : i8
    %7 = llvm.icmp "eq" %6, %2 : i8
    llvm.return %7 : i1
  }
  llvm.func @src_is_notmask_ashr(%arg0: i16, %arg1: i8, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.xor %arg0, %0  : i16
    %4 = llvm.shl %1, %arg1  : i8
    %5 = llvm.sext %4 : i8 to i16
    %6 = llvm.ashr %5, %arg2  : i16
    %7 = llvm.xor %6, %2  : i16
    %8 = llvm.and %3, %7  : i16
    %9 = llvm.icmp "eq" %3, %8 : i16
    llvm.return %9 : i1
  }
  llvm.func @src_is_notmask_neg_p2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.sub %1, %arg1  : i8
    %5 = llvm.and %4, %arg1  : i8
    %6 = llvm.sub %1, %5  : i8
    %7 = llvm.intr.bitreverse(%6)  : (i8) -> i8
    %8 = llvm.xor %7, %2  : i8
    %9 = llvm.and %8, %3  : i8
    %10 = llvm.icmp "eq" %1, %9 : i8
    llvm.return %10 : i1
  }
  llvm.func @src_is_notmask_neg_p2_fail_not_invertable(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.sub %1, %arg1  : i8
    %4 = llvm.and %3, %arg1  : i8
    %5 = llvm.sub %1, %4  : i8
    %6 = llvm.and %5, %2  : i8
    %7 = llvm.icmp "eq" %1, %6 : i8
    llvm.return %7 : i1
  }
  llvm.func @src_is_notmask_xor_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.xor %arg1, %3  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.intr.bitreverse(%5)  : (i8) -> i8
    %7 = llvm.and %2, %6  : i8
    %8 = llvm.icmp "slt" %7, %2 : i8
    llvm.return %8 : i1
  }
  llvm.func @src_is_mask_const_slt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "slt" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @src_is_mask_const_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "sgt" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @src_is_mask_const_sle(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "sle" %3, %2 : i8
    llvm.return %4 : i1
  }
  llvm.func @src_is_mask_const_sge(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "sge" %3, %2 : i8
    llvm.return %4 : i1
  }
  llvm.func @src_x_and_mask_slt(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.icmp "sge" %3, %1 : i8
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %3  : i8
    %6 = llvm.icmp "slt" %5, %arg0 : i8
    llvm.return %6 : i1
  }
  llvm.func @src_x_and_mask_sge(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.icmp "sge" %3, %1 : i8
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %3  : i8
    %6 = llvm.icmp "sge" %5, %arg0 : i8
    llvm.return %6 : i1
  }
  llvm.func @src_x_and_mask_slt_fail_maybe_neg(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "slt" %4, %arg0 : i8
    llvm.return %5 : i1
  }
  llvm.func @src_x_and_mask_sge_fail_maybe_neg(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "sge" %4, %arg0 : i8
    llvm.return %5 : i1
  }
  llvm.func @src_x_and_nmask_eq(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "eq" %3, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @src_x_and_nmask_ne(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "ne" %4, %3 : i8
    llvm.return %5 : i1
  }
  llvm.func @src_x_and_nmask_ult(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "ult" %4, %3 : i8
    llvm.return %5 : i1
  }
  llvm.func @src_x_and_nmask_uge(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "uge" %4, %3 : i8
    llvm.return %5 : i1
  }
  llvm.func @src_x_and_nmask_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.and %arg0, %1  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @src_x_and_nmask_sge(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.and %arg0, %1  : i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @src_x_and_nmask_slt_fail_maybe_z(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "slt" %4, %3 : i8
    llvm.return %5 : i1
  }
  llvm.func @src_x_and_nmask_sge_fail_maybe_z(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "sge" %4, %3 : i8
    llvm.return %5 : i1
  }
  llvm.func @src_x_or_mask_eq(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(123 : i8) : i8
    %3 = llvm.mlir.constant(45 : i8) : i8
    %4 = llvm.mlir.constant(12 : i8) : i8
    %5 = llvm.lshr %0, %arg1  : i8
    %6 = llvm.select %arg4, %5, %1 : i1, i8
    %7 = llvm.xor %arg0, %2  : i8
    %8 = llvm.select %arg3, %7, %3 : i1, i8
    %9 = llvm.xor %arg2, %0  : i8
    %10 = llvm.intr.umin(%9, %8)  : (i8, i8) -> i8
    %11 = llvm.add %10, %4  : i8
    %12 = llvm.or %11, %6  : i8
    %13 = llvm.icmp "eq" %12, %0 : i8
    llvm.return %13 : i1
  }
  llvm.func @src_x_or_mask_ne(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.or %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %0 : i8
    llvm.return %6 : i1
  }
  llvm.func @src_x_or_mask_ne_fail_multiuse(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.or %3, %4  : i8
    llvm.call @use.i8(%5) : (i8) -> ()
    %6 = llvm.icmp "ne" %5, %0 : i8
    llvm.return %6 : i1
  }
}
