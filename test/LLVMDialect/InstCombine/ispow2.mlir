module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @is_pow2or0_negate_op(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @is_pow2or0_negate_op_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0  : vector<2xi32>
    %3 = llvm.and %2, %arg0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %arg0 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @is_pow2or0_decrement_op(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @is_pow2or0_decrement_op_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.and %3, %arg0  : vector<2xi8>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @isnot_pow2or0_negate_op(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.icmp "ne" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @isnot_pow2or0_negate_op_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0  : vector<2xi32>
    %3 = llvm.and %2, %arg0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %arg0 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @isnot_pow2or0_decrement_op(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @isnot_pow2or0_decrement_op_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.and %3, %arg0  : vector<2xi8>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @is_pow2or0_negate_op_commute1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %0, %arg0  : i32
    %3 = llvm.sub %1, %2  : i32
    %4 = llvm.and %2, %3  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }
  llvm.func @isnot_pow2or0_negate_op_commute2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.urem %0, %arg0  : i32
    %3 = llvm.sub %1, %2  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %2, %4 : i32
    llvm.return %5 : i1
  }
  llvm.func @isnot_pow2or0_negate_op_commute3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.urem %0, %arg0  : i32
    %3 = llvm.sub %1, %2  : i32
    %4 = llvm.and %2, %3  : i32
    %5 = llvm.icmp "ne" %2, %4 : i32
    llvm.return %5 : i1
  }
  llvm.func @use(i32)
  llvm.func @is_pow2or0_negate_op_extra_use1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @is_pow2or0_negate_op_extra_use2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @is_pow2_ctpop(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ult" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @is_pow2_non_zero_ult_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @is_pow2_non_zero_eq_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @is_pow2_non_zero_ugt_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @is_pow2_non_zero_ne_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @is_pow2_ctpop_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @use_i1(i1)
  llvm.func @is_pow2_ctpop_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ult" %2, %0 : i32
    llvm.call @use_i1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @is_pow2_ctpop_extra_uses_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.call @use_i1(%5) : (i1) -> ()
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @is_pow2_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ult" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "ne" %arg0, %2 : vector<2xi8>
    %6 = llvm.and %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @is_pow2_ctpop_wrong_cmp_op1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ult" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @is_pow2_ctpop_wrong_cmp_op1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @is_pow2_ctpop_wrong_cmp_op2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ult" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @is_pow2_ctpop_wrong_cmp_op2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @is_pow2_ctpop_wrong_pred1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @is_pow2_ctpop_wrong_pred1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @is_pow2_ctpop_wrong_pred2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ult" %2, %0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @is_pow2_ctpop_wrong_pred2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    %5 = llvm.icmp "sgt" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @isnot_pow2_ctpop(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @isnot_pow2_ctpop_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @isnot_pow2_ctpop_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    llvm.call @use_i1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @isnot_pow2_ctpop_extra_uses_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.call @use_i1(%5) : (i1) -> ()
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @isnot_pow2_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ugt" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "eq" %arg0, %2 : vector<2xi8>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @isnot_pow2_ctpop_wrong_cmp_op1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @isnot_pow2_ctpop_wrong_cmp_op1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @isnot_pow2_ctpop_wrong_cmp_op2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @isnot_pow2_ctpop_wrong_cmp_op2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.select %4, %1, %3 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @isnot_pow2_ctpop_wrong_pred2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @isnot_pow2_ctpop_wrong_pred2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @is_pow2_negate_op(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %arg0 : i32
    %4 = llvm.icmp "ne" %arg0, %0 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @is_pow2_negate_op_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "eq" %3, %arg0 : i32
    %5 = llvm.icmp "ne" %arg0, %0 : i32
    %6 = llvm.select %5, %4, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @is_pow2_negate_op_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0  : vector<2xi32>
    %3 = llvm.and %2, %arg0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %arg0 : vector<2xi32>
    %5 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    %6 = llvm.and %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @is_pow2_decrement_op(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.icmp "ne" %arg0, %1 : i8
    %6 = llvm.and %4, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @is_pow2_decrement_op_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    %6 = llvm.icmp "ne" %arg0, %1 : i8
    %7 = llvm.select %5, %6, %2 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @is_pow2_decrement_op_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.and %3, %arg0  : vector<2xi8>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi8>
    %6 = llvm.icmp "ne" %arg0, %2 : vector<2xi8>
    %7 = llvm.and %6, %5  : vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @isnot_pow2_negate_op(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.icmp "ne" %2, %arg0 : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @isnot_pow2_negate_op_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %arg0 : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.select %4, %1, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @isnot_pow2_negate_op_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0  : vector<2xi32>
    %3 = llvm.and %2, %arg0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %arg0 : vector<2xi32>
    %5 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %6 = llvm.or %5, %4  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @isnot_pow2_decrement_op(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    %5 = llvm.icmp "eq" %arg0, %1 : i8
    %6 = llvm.or %5, %4  : i1
    llvm.return %6 : i1
  }
  llvm.func @isnot_pow2_decrement_op_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.icmp "ne" %4, %1 : i8
    %6 = llvm.icmp "eq" %arg0, %1 : i8
    %7 = llvm.select %6, %2, %5 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @isnot_pow2_decrement_op_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.and %3, %arg0  : vector<2xi8>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi8>
    %6 = llvm.icmp "eq" %arg0, %2 : vector<2xi8>
    %7 = llvm.or %5, %6  : vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @is_pow2or0_ctpop(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @is_pow2or0_ctpop_swap_cmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @is_pow2or0_ctpop_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @is_pow2or0_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "eq" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "eq" %arg0, %2 : vector<2xi8>
    %6 = llvm.or %5, %4  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @is_pow2or0_ctpop_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.call @use_i1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @is_pow2or0_ctpop_logical_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.call @use_i1(%5) : (i1) -> ()
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @is_pow2or0_ctpop_wrong_cmp_op1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @is_pow2or0_ctpop_wrong_cmp_op1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @is_pow2or0_ctpop_commute_vec_wrong_cmp_op1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "eq" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "eq" %arg0, %2 : vector<2xi8>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @is_pow2or0_ctpop_wrong_pred1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @is_pow2or0_ctpop_wrong_pred2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @is_pow2or0_ctpop_wrong_pred2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @is_pow2or0_ctpop_commute_vec_wrong_pred3(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "eq" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "eq" %arg0, %2 : vector<2xi8>
    %6 = llvm.and %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @isnot_pow2nor0_ctpop(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @isnot_pow2nor0_ctpop_swap_cmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @isnot_pow2nor0_ctpop_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @isnot_pow2nor0_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ne" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "ne" %arg0, %2 : vector<2xi8>
    %6 = llvm.and %5, %4  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @isnot_pow2nor0_ctpop_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.call @use_i1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @isnot_pow2nor0_ctpop_logical_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.call @use_i1(%5) : (i1) -> ()
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @isnot_pow2nor0_ctpop_wrong_cmp_op1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @isnot_pow2nor0_ctpop_wrong_cmp_op1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @isnot_pow2nor0_ctpop_commute_vec_wrong_cmp_op1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0, -1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ne" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "ne" %arg0, %2 : vector<2xi8>
    %6 = llvm.and %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @isnot_pow2nor0_ctpop_wrong_pred1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @isnot_pow2nor0_ctpop_wrong_pred2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @isnot_pow2nor0_ctpop_wrong_pred2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @isnot_pow2nor0_wrong_pred3_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ne" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "ne" %arg0, %2 : vector<2xi8>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @is_pow2_fail_pr63327(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %arg0, %1  : i32
    %3 = llvm.icmp "sge" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @blsmsk_is_p2_or_z(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.icmp "uge" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @blsmsk_isnt_p2_or_z(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @blsmsk_is_p2_or_z_fail(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @blsmsk_isnt_p2_or_z_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.icmp "ule" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @use.i32(i32)
  llvm.func @blsmsk_isnt_p2_or_z_fail_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    llvm.call @use.i32(%2) : (i32) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @blsmsk_isnt_p2_or_z_fail_wrong_add(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg1, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @blsmsk_isnt_p2_or_z_fail_bad_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %arg1, %1  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @blsmsk_is_p2_or_z_fail_bad_cmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.icmp "uge" %2, %arg1 : i32
    llvm.return %3 : i1
  }
  llvm.func @blsmsk_is_p2_or_z_ule_xy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ule" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @blsmsk_is_p2_or_z_ule_yx_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ule" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @blsmsk_is_p2_or_z_uge_yx(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "uge" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @blsmsk_is_p2_or_z_uge_xy_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "uge" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @blsmsk_isnt_p2_or_z_ugt_xy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ugt" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @blsmsk_isnt_p2_or_z_ugt_yx_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ugt" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @blsmsk_isnt_p2_or_z_ult_yx(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @blsmsk_isnt_p2_or_z_ult_xy_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ult" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @is_pow2_nz_known_bits(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @is_pow2_nz_known_bits_fail_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    llvm.call @use.i32(%3) : (i32) -> ()
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @not_pow2_nz_known_bits(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.intr.ctpop(%1)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @not_pow2_nz_known_bits_fail_not_p2_test(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @is_pow2_or_z_known_bits(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @not_pow2_or_z_known_bits(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi32>) -> vector<2xi32>
    %4 = llvm.icmp "ugt" %3, %1 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @not_pow2_or_z_known_bits_fail_wrong_cmp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi32>) -> vector<2xi32>
    %4 = llvm.icmp "ugt" %3, %1 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
}
