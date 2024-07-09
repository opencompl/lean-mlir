module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @use.i1(i1)
  llvm.func @icmp_select_const(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "eq" %2, %0 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_select_var(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %arg2, %arg1 : i1, i8
    %3 = llvm.icmp "eq" %2, %arg2 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_select_var_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.udiv %0, %arg2  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.select %3, %2, %arg1 : i1, i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @icmp_select_var_select(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.select %arg2, %arg0, %arg1 : i1, i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg1 : i1, i8
    %4 = llvm.icmp "eq" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @icmp_select_var_both_fold(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.or %arg2, %0  : i8
    %4 = llvm.icmp "eq" %arg0, %1 : i8
    %5 = llvm.select %4, %3, %2 : i1, i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }
  llvm.func @icmp_select_var_extra_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %arg2, %arg1 : i1, i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %arg2 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_select_var_both_fold_extra_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.or %arg2, %0  : i8
    %4 = llvm.icmp "eq" %arg0, %1 : i8
    %5 = llvm.select %4, %3, %2 : i1, i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }
  llvm.func @icmp_select_var_pred_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %arg2, %arg1 : i1, i8
    %3 = llvm.icmp "ne" %2, %arg2 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_select_var_pred_ult(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg2, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.select %3, %arg2, %arg1 : i1, i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.return %5 : i1
  }
  llvm.func @icmp_select_var_pred_uge(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg2, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.select %3, %arg2, %arg1 : i1, i8
    %5 = llvm.icmp "uge" %4, %2 : i8
    llvm.return %5 : i1
  }
  llvm.func @icmp_select_var_pred_uge_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg2, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.select %3, %arg2, %arg1 : i1, i8
    %5 = llvm.icmp "uge" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @icmp_select_implied_cond(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_select_implied_cond_ne(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "ne" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_select_implied_cond_swapped_select(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %arg1, %0 : i1, i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_select_implied_cond_swapped_select_with_inv_cond(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg1, %0 : i1, i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_select_implied_cond_relational(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_select_implied_cond_relational_off_by_one(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.call @use.i1(%2) : (i1) -> ()
    %3 = llvm.select %2, %1, %arg1 : i1, i8
    %4 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @umin_seq_comparison(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.select %2, %0, %1 : i1, i8
    %4 = llvm.icmp "eq" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @select_constants_and_icmp_eq0(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @select_constants_and_icmp_eq0_uses(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.and %3, %4  : i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @select_constants_and_icmp_eq0_vec_splat(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(3 : i9) : i9
    %1 = llvm.mlir.constant(dense<3> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(48 : i9) : i9
    %3 = llvm.mlir.constant(dense<48> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.mlir.constant(0 : i9) : i9
    %5 = llvm.mlir.constant(dense<0> : vector<2xi9>) : vector<2xi9>
    %6 = llvm.select %arg0, %1, %3 : vector<2xi1>, vector<2xi9>
    %7 = llvm.select %arg1, %1, %3 : vector<2xi1>, vector<2xi9>
    %8 = llvm.and %6, %7  : vector<2xi9>
    %9 = llvm.icmp "eq" %8, %5 : vector<2xi9>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @select_constants_and_icmp_eq0_common_bit(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @select_constants_and_icmp_eq0_no_common_op1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(24 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.select %arg0, %0, %1 : i1, i8
    %5 = llvm.select %arg1, %2, %1 : i1, i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.icmp "eq" %6, %3 : i8
    llvm.return %7 : i1
  }
  llvm.func @select_constants_and_icmp_eq0_no_common_op2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.select %arg0, %0, %1 : i1, i8
    %5 = llvm.select %arg1, %0, %2 : i1, i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.icmp "eq" %6, %3 : i8
    llvm.return %7 : i1
  }
  llvm.func @select_constants_and_icmp_eq0_zero_tval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "eq" %4, %0 : i8
    llvm.return %5 : i1
  }
  llvm.func @select_constants_and_icmp_eq0_zero_fval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    llvm.return %5 : i1
  }
  llvm.func @select_constants_and_icmp_eq_tval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "eq" %4, %0 : i8
    llvm.return %5 : i1
  }
  llvm.func @select_constants_and_icmp_eq_fval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    llvm.return %5 : i1
  }
  llvm.func @select_constants_and_icmp_ne0(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @select_constants_and_icmp_ne0_uses(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @select_constants_and_icmp_ne0_all_uses(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.and %3, %4  : i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @select_constants_and_icmp_ne0_vec_splat(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(3 : i9) : i9
    %1 = llvm.mlir.constant(dense<3> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(48 : i9) : i9
    %3 = llvm.mlir.constant(dense<48> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.mlir.constant(0 : i9) : i9
    %5 = llvm.mlir.constant(dense<0> : vector<2xi9>) : vector<2xi9>
    %6 = llvm.select %arg0, %1, %3 : vector<2xi1>, vector<2xi9>
    %7 = llvm.select %arg1, %1, %3 : vector<2xi1>, vector<2xi9>
    %8 = llvm.and %6, %7  : vector<2xi9>
    %9 = llvm.icmp "ne" %8, %5 : vector<2xi9>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @select_constants_and_icmp_ne0_common_bit(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @select_constants_and_icmp_ne0_no_common_op1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(24 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.select %arg0, %0, %1 : i1, i8
    %5 = llvm.select %arg1, %2, %1 : i1, i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.icmp "ne" %6, %3 : i8
    llvm.return %7 : i1
  }
  llvm.func @select_constants_and_icmp_ne0_no_common_op2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.select %arg0, %0, %1 : i1, i8
    %5 = llvm.select %arg1, %0, %2 : i1, i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.icmp "ne" %6, %3 : i8
    llvm.return %7 : i1
  }
  llvm.func @select_constants_and_icmp_ne0_zero_tval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "ne" %4, %0 : i8
    llvm.return %5 : i1
  }
  llvm.func @select_constants_and_icmp_ne0_zero_fval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "ne" %4, %1 : i8
    llvm.return %5 : i1
  }
  llvm.func @select_constants_and_icmp_ne_tval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "ne" %4, %0 : i8
    llvm.return %5 : i1
  }
  llvm.func @select_constants_and_icmp_ne_fval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "ne" %4, %1 : i8
    llvm.return %5 : i1
  }
  llvm.func @icmp_eq_select(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @icmp_slt_select(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, i32
    %2 = llvm.icmp "slt" %0, %1 : i32
    llvm.return %2 : i1
  }
}
