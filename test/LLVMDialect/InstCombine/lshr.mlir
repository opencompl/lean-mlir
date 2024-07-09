module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @usevec(vector<3xi14>)
  llvm.func @lshr_ctlz_zero_is_not_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @lshr_cttz_zero_is_not_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @lshr_ctpop(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @lshr_ctlz_zero_is_not_undef_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @lshr_cttz_zero_is_not_undef_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @lshr_ctpop_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @lshr_ctlz_zero_is_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @lshr_cttz_zero_is_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @lshr_ctlz_zero_is_undef_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @lshr_ctlz_zero_is_undef_vec(%arg0: vector<2xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[3, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (vector<2xi8>) -> vector<2xi8>
    %3 = llvm.lshr %2, %0  : vector<2xi8>
    %4 = llvm.extractelement %3[%1 : i32] : vector<2xi8>
    llvm.return %4 : i8
  }
  llvm.func @lshr_cttz_zero_is_undef_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @lshr_cttz_zero_is_undef_vec(%arg0: vector<2xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[3, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (vector<2xi8>) -> vector<2xi8>
    %3 = llvm.lshr %2, %0  : vector<2xi8>
    %4 = llvm.extractelement %3[%1 : i32] : vector<2xi8>
    llvm.return %4 : i8
  }
  llvm.func @lshr_exact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.lshr %3, %0  : i8
    llvm.return %4 : i8
  }
  llvm.func @lshr_exact_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %1  : vector<2xi8>
    %4 = llvm.lshr %3, %0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @lshr_exact_splat_vec_nuw(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : vector<2xi8>
    %3 = llvm.add %2, %1 overflow<nuw>  : vector<2xi8>
    %4 = llvm.lshr %3, %0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @shl_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.add %1, %arg1  : i8
    %3 = llvm.lshr %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @shl_add_commute_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mul %arg1, %arg1  : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.add %1, %2  : vector<2xi8>
    %4 = llvm.lshr %3, %0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @shl_add_use1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_add_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.add %1, %arg1  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @bool_zext(%arg0: i1) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.sext %arg0 : i1 to i16
    %2 = llvm.lshr %1, %0  : i16
    llvm.return %2 : i16
  }
  llvm.func @bool_zext_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @bool_zext_splat(%arg0: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi8>
    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @smear_sign_and_widen(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @smear_sign_and_widen_should_not_change_type(%arg0: i4) -> i16 {
    %0 = llvm.mlir.constant(12 : i16) : i16
    %1 = llvm.sext %arg0 : i4 to i16
    %2 = llvm.lshr %1, %0  : i16
    llvm.return %2 : i16
  }
  llvm.func @smear_sign_and_widen_splat(%arg0: vector<2xi6>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sext %arg0 : vector<2xi6> to vector<2xi8>
    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @fake_sext(%arg0: i3) -> i18 {
    %0 = llvm.mlir.constant(17 : i18) : i18
    %1 = llvm.sext %arg0 : i3 to i18
    %2 = llvm.lshr %1, %0  : i18
    llvm.return %2 : i18
  }
  llvm.func @fake_sext_but_should_not_change_type(%arg0: i3) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sext %arg0 : i3 to i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @fake_sext_splat(%arg0: vector<2xi3>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sext %arg0 : vector<2xi3> to vector<2xi8>
    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @narrow_lshr_constant(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @mul_splat_fold(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @mul_splat_fold_vec(%arg0: vector<3xi14>) -> vector<3xi14> {
    %0 = llvm.mlir.constant(129 : i14) : i14
    %1 = llvm.mlir.constant(dense<129> : vector<3xi14>) : vector<3xi14>
    %2 = llvm.mlir.constant(7 : i14) : i14
    %3 = llvm.mlir.constant(dense<7> : vector<3xi14>) : vector<3xi14>
    %4 = llvm.mul %arg0, %1 overflow<nuw>  : vector<3xi14>
    llvm.call @usevec(%4) : (vector<3xi14>) -> ()
    %5 = llvm.lshr %4, %3  : vector<3xi14>
    llvm.return %5 : vector<3xi14>
  }
  llvm.func @shl_add_lshr_flag_preservation(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_add_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_add_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.mul %arg2, %arg2  : i32
    %2 = llvm.add %1, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_add_lshr_no_nuw(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_sub_lshr_not_exact(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %0, %arg2 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_sub_lshr_no_nuw(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.sub %0, %arg2 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_sub_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %0, %arg2 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_sub_lshr_reverse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_sub_lshr_reverse_no_nsw(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_sub_lshr_reverse_nsw_on_op1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_sub_lshr_reverse_no_exact(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_sub_lshr_reverse_multiuse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_sub_lshr_reverse_multiuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_sub_lshr_reverse_no_nuw(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_sub_lshr_reverse_no_nsw_2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.sub %arg2, %0  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_or_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.or %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_or_disjoint_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.or %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_or_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.or %arg2, %0  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_or_disjoint_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.or %arg2, %0  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_xor_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.xor %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_xor_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_and_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_and_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_lshr_and_exact(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_add_lshr_neg(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg2  : i32
    llvm.return %2 : i32
  }
  llvm.func @mul_splat_fold_wrong_mul_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65538 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_add_lshr_multiuse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2 overflow<nsw, nuw>  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg2  : i32
    llvm.return %2 : i32
  }
  llvm.func @mul_splat_fold_wrong_lshr_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @mul_splat_fold_no_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @mul_splat_fold_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @mul_splat_fold_too_narrow(%arg0: i2) -> i2 {
    %0 = llvm.mlir.constant(-2 : i2) : i2
    %1 = llvm.mlir.constant(1 : i2) : i2
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i2
    %3 = llvm.lshr %2, %1  : i2
    llvm.return %3 : i2
  }
  llvm.func @negative_and_odd(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @negative_and_odd_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(2 : i7) : i7
    %1 = llvm.mlir.constant(dense<2> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(6 : i7) : i7
    %3 = llvm.mlir.constant(dense<6> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.srem %arg0, %1  : vector<2xi7>
    %5 = llvm.lshr %4, %3  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }
  llvm.func @negative_and_odd_uses(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @srem3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @srem2_lshr30(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @trunc_sandwich(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(28 : i32) : i32
    %1 = llvm.mlir.constant(2 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }
  llvm.func @trunc_sandwich_splat_vec(%arg0: vector<2xi32>) -> vector<2xi12> {
    %0 = llvm.mlir.constant(dense<22> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(8 : i12) : i12
    %2 = llvm.mlir.constant(dense<8> : vector<2xi12>) : vector<2xi12>
    %3 = llvm.lshr %arg0, %0  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi12>
    %5 = llvm.lshr %4, %2  : vector<2xi12>
    llvm.return %5 : vector<2xi12>
  }
  llvm.func @trunc_sandwich_min_shift1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }
  llvm.func @trunc_sandwich_small_shift1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(19 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }
  llvm.func @trunc_sandwich_max_sum_shift(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(11 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }
  llvm.func @trunc_sandwich_max_sum_shift2(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }
  llvm.func @trunc_sandwich_big_sum_shift1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(11 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }
  llvm.func @trunc_sandwich_big_sum_shift2(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }
  llvm.func @trunc_sandwich_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(28 : i32) : i32
    %1 = llvm.mlir.constant(2 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }
  llvm.func @trunc_sandwich_splat_vec_use1(%arg0: vector<3xi14>) -> vector<3xi9> {
    %0 = llvm.mlir.constant(6 : i14) : i14
    %1 = llvm.mlir.constant(dense<6> : vector<3xi14>) : vector<3xi14>
    %2 = llvm.mlir.constant(5 : i9) : i9
    %3 = llvm.mlir.constant(dense<5> : vector<3xi9>) : vector<3xi9>
    %4 = llvm.lshr %arg0, %1  : vector<3xi14>
    llvm.call @usevec(%4) : (vector<3xi14>) -> ()
    %5 = llvm.trunc %4 : vector<3xi14> to vector<3xi9>
    %6 = llvm.lshr %5, %3  : vector<3xi9>
    llvm.return %6 : vector<3xi9>
  }
  llvm.func @trunc_sandwich_min_shift1_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }
  llvm.func @trunc_sandwich_small_shift1_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(19 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }
  llvm.func @trunc_sandwich_max_sum_shift_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(11 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }
  llvm.func @trunc_sandwich_max_sum_shift2_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }
  llvm.func @trunc_sandwich_big_sum_shift1_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(11 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }
  llvm.func @trunc_sandwich_big_sum_shift2_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }
  llvm.func @lshr_sext_i1_to_i16(%arg0: i1) -> i16 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.sext %arg0 : i1 to i16
    %2 = llvm.lshr %1, %0  : i16
    llvm.return %2 : i16
  }
  llvm.func @lshr_sext_i1_to_i128(%arg0: i1) -> i128 {
    %0 = llvm.mlir.constant(42 : i128) : i128
    %1 = llvm.sext %arg0 : i1 to i128
    %2 = llvm.lshr %1, %0  : i128
    llvm.return %2 : i128
  }
  llvm.func @lshr_sext_i1_to_i32_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @lshr_sext_i1_to_i14_splat_vec_use1(%arg0: vector<3xi1>) -> vector<3xi14> {
    %0 = llvm.mlir.constant(4 : i14) : i14
    %1 = llvm.mlir.constant(dense<4> : vector<3xi14>) : vector<3xi14>
    %2 = llvm.sext %arg0 : vector<3xi1> to vector<3xi14>
    llvm.call @usevec(%2) : (vector<3xi14>) -> ()
    %3 = llvm.lshr %2, %1  : vector<3xi14>
    llvm.return %3 : vector<3xi14>
  }
  llvm.func @icmp_ule(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "ule" %0, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @icmp_ult(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "ult" %0, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @icmp_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "eq" %0, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @icmp_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "ne" %0, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @icmp_ugt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "ugt" %0, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @icmp_uge(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "uge" %0, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @icmp_sle(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "sle" %0, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @icmp_slt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "slt" %0, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @icmp_sgt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "sgt" %0, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @icmp_sge(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "sge" %0, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @narrow_bswap(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @narrow_bswap_extra_wide(%arg0: i16) -> i128 {
    %0 = llvm.mlir.constant(112 : i128) : i128
    %1 = llvm.zext %arg0 : i16 to i128
    %2 = llvm.intr.bswap(%1)  : (i128) -> i128
    %3 = llvm.lshr %2, %0  : i128
    llvm.return %3 : i128
  }
  llvm.func @narrow_bswap_undershift(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @narrow_bswap_splat(%arg0: vector<2xi16>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<48> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.zext %arg0 : vector<2xi16> to vector<2xi64>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi64>) -> vector<2xi64>
    %3 = llvm.lshr %2, %0  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @narrow_bswap_splat_poison_elt(%arg0: vector<2xi16>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(48 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.zext %arg0 : vector<2xi16> to vector<2xi64>
    %8 = llvm.intr.bswap(%7)  : (vector<2xi64>) -> vector<2xi64>
    %9 = llvm.lshr %8, %6  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @narrow_bswap_overshift(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<48> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi64>) -> vector<2xi64>
    %3 = llvm.lshr %2, %0  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @narrow_bswap_overshift2(%arg0: i96) -> i128 {
    %0 = llvm.mlir.constant(61 : i128) : i128
    %1 = llvm.zext %arg0 : i96 to i128
    %2 = llvm.intr.bswap(%1)  : (i128) -> i128
    %3 = llvm.lshr %2, %0  : i128
    llvm.return %3 : i128
  }
  llvm.func @not_narrow_bswap(%arg0: i24) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.zext %arg0 : i24 to i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @not_signbit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_signbit_vec(%arg0: vector<2xi6>) -> vector<2xi6> {
    %0 = llvm.mlir.poison : i6
    %1 = llvm.mlir.constant(-1 : i6) : i6
    %2 = llvm.mlir.undef : vector<2xi6>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi6>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi6>
    %7 = llvm.mlir.constant(5 : i6) : i6
    %8 = llvm.mlir.undef : vector<2xi6>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi6>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi6>
    %13 = llvm.xor %arg0, %6  : vector<2xi6>
    %14 = llvm.lshr %13, %12  : vector<2xi6>
    llvm.return %14 : vector<2xi6>
  }
  llvm.func @not_signbit_alt_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_not_signbit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_signbit_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @not_signbit_zext(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.mlir.constant(15 : i16) : i16
    %2 = llvm.xor %arg0, %0  : i16
    %3 = llvm.lshr %2, %1  : i16
    %4 = llvm.zext %3 : i16 to i32
    llvm.return %4 : i32
  }
  llvm.func @not_signbit_trunc(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.mlir.constant(15 : i16) : i16
    %2 = llvm.xor %arg0, %0  : i16
    %3 = llvm.lshr %2, %1  : i16
    %4 = llvm.trunc %3 : i16 to i8
    llvm.return %4 : i8
  }
  llvm.func @bool_add_lshr(%arg0: i1, %arg1: i1) -> i2 {
    %0 = llvm.mlir.constant(1 : i2) : i2
    %1 = llvm.zext %arg0 : i1 to i2
    %2 = llvm.zext %arg1 : i1 to i2
    %3 = llvm.add %1, %2  : i2
    %4 = llvm.lshr %3, %0  : i2
    llvm.return %4 : i2
  }
  llvm.func @not_bool_add_lshr(%arg0: i2, %arg1: i2) -> i4 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.zext %arg0 : i2 to i4
    %2 = llvm.zext %arg1 : i2 to i4
    %3 = llvm.add %1, %2  : i4
    %4 = llvm.lshr %3, %0  : i4
    llvm.return %4 : i4
  }
  llvm.func @bool_add_ashr(%arg0: i1, %arg1: i1) -> i2 {
    %0 = llvm.mlir.constant(1 : i2) : i2
    %1 = llvm.zext %arg0 : i1 to i2
    %2 = llvm.zext %arg1 : i1 to i2
    %3 = llvm.add %1, %2  : i2
    %4 = llvm.ashr %3, %0  : i2
    llvm.return %4 : i2
  }
  llvm.func @bool_add_lshr_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi8>
    %2 = llvm.zext %arg1 : vector<2xi1> to vector<2xi8>
    %3 = llvm.add %1, %2  : vector<2xi8>
    %4 = llvm.lshr %3, %0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @bool_add_lshr_uses(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.lshr %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @bool_add_lshr_uses2(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %1, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.lshr %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @bool_add_lshr_uses3(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %1, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.lshr %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @bool_add_lshr_vec_wrong_shift_amt(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi8>
    %2 = llvm.zext %arg1 : vector<2xi1> to vector<2xi8>
    %3 = llvm.add %1, %2  : vector<2xi8>
    %4 = llvm.lshr %3, %0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
}
