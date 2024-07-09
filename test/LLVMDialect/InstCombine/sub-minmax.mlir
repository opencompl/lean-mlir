module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @max_na_b_minux_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.sub %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @na_minus_max_na_b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @sub_umin(%arg0: i5, %arg1: i5) -> i5 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i5, i5) -> i5
    %1 = llvm.sub %arg0, %0  : i5
    llvm.return %1 : i5
  }
  llvm.func @sub_umin_commute_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.sub %arg1, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
  llvm.func @sub_umin_uses(%arg0: i5, %arg1: i5, %arg2: !llvm.ptr) -> i5 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i5, i5) -> i5
    llvm.store %0, %arg2 {alignment = 1 : i64} : i5, !llvm.ptr
    %1 = llvm.sub %arg0, %0  : i5
    llvm.return %1 : i5
  }
  llvm.func @sub_umin_no_common_op(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i5, i5) -> i5
    %1 = llvm.sub %arg2, %0  : i5
    llvm.return %1 : i5
  }
  llvm.func @max_b_na_minus_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.sub %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @na_minus_max_b_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @max_na_bi_minux_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @na_minus_max_na_bi(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @max_bi_na_minus_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    %5 = llvm.sub %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @na_minus_max_bi_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    %5 = llvm.sub %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @max_na_bi_minux_na_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %4, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @na_minus_max_na_bi_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %2, %4  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @max_bi_na_minus_na_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %4, %1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @na_minus_max_bi_na_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %1, %4  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @max_na_bi_minux_na_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %4, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @na_minus_max_na_bi_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %2, %4  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @max_bi_na_minus_na_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %4, %1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @na_minus_max_bi_na_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %1, %4  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @umin_not_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "ult" %1, %2 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    %5 = llvm.sub %1, %4  : i8
    %6 = llvm.sub %2, %4  : i8
    llvm.call @use8(%5) : (i8) -> ()
    llvm.call @use8(%6) : (i8) -> ()
    llvm.return %4 : i8
  }
  llvm.func @umin_not_sub_rev(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "ult" %1, %2 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    %5 = llvm.sub %4, %1  : i8
    %6 = llvm.sub %4, %2  : i8
    llvm.call @use8(%5) : (i8) -> ()
    llvm.call @use8(%6) : (i8) -> ()
    llvm.return %4 : i8
  }
  llvm.func @umin3_not_all_ops_extra_uses_invert_subs(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "ult" %1, %3 : i8
    %5 = llvm.select %4, %1, %3 : i1, i8
    %6 = llvm.icmp "ult" %5, %2 : i8
    %7 = llvm.select %6, %5, %2 : i1, i8
    %8 = llvm.sub %1, %7  : i8
    %9 = llvm.sub %2, %7  : i8
    %10 = llvm.sub %3, %7  : i8
    llvm.call @use8(%7) : (i8) -> ()
    llvm.call @use8(%8) : (i8) -> ()
    llvm.call @use8(%9) : (i8) -> ()
    llvm.call @use8(%10) : (i8) -> ()
    llvm.return
  }
  llvm.func @umin_not_sub_intrinsic_commute0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @umax_not_sub_intrinsic_commute1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @smin_not_sub_intrinsic_commute2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @smax_not_sub_intrinsic_commute3(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @umin_not_sub_intrinsic_uses(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @umax_sub_op0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umax(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }
  llvm.func @umax_sub_op0_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.sub %0, %arg1  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
  llvm.func @umax_sub_op0_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }
  llvm.func @umax_sub_op1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @umax_sub_op1_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.umax(%arg1, %arg0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.sub %arg1, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
  llvm.func @umax_sub_op1_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @umin_sub_op1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @umin_sub_op1_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @umin_sub_op0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }
  llvm.func @umin_sub_op0_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }
  llvm.func @umin_sub_op1_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @umin_sub_op0_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }
  llvm.func @diff_add_smin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @diff_add_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @diff_add_umin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @diff_add_umax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umax(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @diff_add_smin_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    llvm.return %2 : i8
  }
  llvm.func @diff_add_use_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    llvm.return %2 : i8
  }
  llvm.func @diff_add_use_umin_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    llvm.call @use8(%1) : (i8) -> ()
    llvm.return %2 : i8
  }
  llvm.func @sub_add_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg1, %arg2)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_add_umin_commute_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg2, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_add_umin_commute_add(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg1, %arg0  : i8
    %1 = llvm.intr.umin(%arg1, %arg2)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_add_umin_commute_add_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg1, %arg0  : i8
    %1 = llvm.intr.umin(%arg2, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_add_umin_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.add %arg0, %arg1  : vector<2xi8>
    %1 = llvm.intr.umin(%arg1, %arg2)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = llvm.sub %0, %1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @sub_add_umin_mismatch(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg3, %arg2)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_add_umin_use_a(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg1, %arg2)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    llvm.return %2 : i8
  }
  llvm.func @sub_add_umin_use_m(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg1, %arg2)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    llvm.return %2 : i8
  }
  llvm.func @sub_smax0_sub_nsw(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %8 = llvm.intr.smax(%7, %6)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %9 = llvm.sub %arg0, %8  : vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }
  llvm.func @sub_smax0_sub_nsw_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @sub_smax0_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @sub_smax0_sub_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }
  llvm.func @sub_smin0_sub_nsw_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.intr.smin(%1, %0)  : (i8, i8) -> i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @sub_smin0_sub_nsw(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %3 = llvm.intr.smin(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %4 = llvm.sub %arg0, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @sub_smin0_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.intr.smin(%1, %0)  : (i8, i8) -> i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @sub_smin0_sub_nsw_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    %2 = llvm.intr.smin(%1, %0)  : (i8, i8) -> i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @sub_max_min_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %1, %0 overflow<nsw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_max_min_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %1, %0 overflow<nuw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_max_min_nsw_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.smin(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %1, %0 overflow<nsw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_max_min_nuw_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.smin(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %1, %0 overflow<nuw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_max_min_vec_nsw(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.intr.smax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = llvm.sub %1, %0 overflow<nsw>  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @sub_max_min_vec_nuw(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.intr.smax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = llvm.sub %1, %0 overflow<nuw>  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @sub_max_min_vec_nsw_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.smin(%arg1, %arg0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.intr.smax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = llvm.sub %1, %0 overflow<nsw>  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @sub_max_min_vec_nuw_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.smin(%arg1, %arg0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.intr.smax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = llvm.sub %1, %0 overflow<nuw>  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @sub_max_min_multi_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %1, %0 overflow<nsw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_max_min_vec_multi_use(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.addressof @use8v2 : !llvm.ptr
    %1 = llvm.intr.smin(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.call %0(%1) : !llvm.ptr, (vector<2xi8>) -> ()
    %2 = llvm.intr.smax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.call %0(%2) : !llvm.ptr, (vector<2xi8>) -> ()
    %3 = llvm.sub %2, %1 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @use8(i8)
  llvm.func @use32(i32)
  llvm.func @use8v2(i8)
}
