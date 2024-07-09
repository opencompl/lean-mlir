module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @is_rem2_neg_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @is_rem2_pos_v2i8(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "sgt" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @is_rem32_pos_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @is_rem4_neg_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.srem %arg0, %0  : i16
    %3 = llvm.icmp "slt" %2, %1 : i16
    llvm.return %3 : i1
  }
  llvm.func @use(i32)
  llvm.func @is_rem32_neg_i32_extra_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @is_rem8_nonneg_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.srem %arg0, %0  : i16
    %3 = llvm.icmp "sgt" %2, %1 : i16
    llvm.return %3 : i1
  }
  llvm.func @is_rem3_neg_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @is_rem16_something_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_div(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i16
    llvm.cond_br %4, ^bb1, ^bb2(%1 : i1)
  ^bb1:  // pred: ^bb0
    %5 = llvm.sdiv %arg1, %2  : i16
    %6 = llvm.icmp "ne" %5, %0 : i16
    llvm.br ^bb2(%6 : i1)
  ^bb2(%7: i1):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.zext %7 : i1 to i32
    %9 = llvm.add %8, %3 overflow<nsw>  : i32
    llvm.return %9 : i32
  }
  llvm.func @icmp_div2(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i16
    llvm.cond_br %3, ^bb1, ^bb2(%1 : i1)
  ^bb1:  // pred: ^bb0
    %4 = llvm.sdiv %arg1, %0  : i16
    %5 = llvm.icmp "ne" %4, %0 : i16
    llvm.br ^bb2(%5 : i1)
  ^bb2(%6: i1):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.zext %6 : i1 to i32
    %8 = llvm.add %7, %2 overflow<nsw>  : i32
    llvm.return %8 : i32
  }
  llvm.func @icmp_div3(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i16
    llvm.cond_br %4, ^bb1, ^bb2(%1 : i1)
  ^bb1:  // pred: ^bb0
    %5 = llvm.sdiv %arg1, %2  : i16
    %6 = llvm.icmp "ne" %5, %0 : i16
    llvm.br ^bb2(%6 : i1)
  ^bb2(%7: i1):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.zext %7 : i1 to i32
    %9 = llvm.add %8, %3 overflow<nsw>  : i32
    llvm.return %9 : i32
  }
  llvm.func @udiv_eq_umax(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @udiv_ne_umax(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.udiv %arg0, %arg1  : vector<2xi5>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi5>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @udiv_eq_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @udiv_ne_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @udiv_eq_not_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @udiv_slt_umax(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @udiv_eq_umax_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.udiv %arg0, %arg1  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @sdiv_eq_smin(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sdiv_ne_smin(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-16 : i5) : i5
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.sdiv %arg0, %arg1  : vector<2xi5>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi5>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @sdiv_eq_small(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sdiv_ne_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sdiv_eq_not_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sdiv_ult_smin(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sdiv_eq_smin_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.sdiv %arg0, %arg1  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @sdiv_x_by_const_cmp_x(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @udiv_x_by_const_cmp_x(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.udiv %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @udiv_x_by_const_cmp_x_non_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[123, -123]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.udiv %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "slt" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @sdiv_x_by_const_cmp_x_non_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "eq" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @lshr_x_by_const_cmp_x(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @lshr_by_const_cmp_sle_value(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    %2 = llvm.icmp "sle" %1, %arg0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }
  llvm.func @lshr_by_const_cmp_sle_value_non_splat(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[3, 3, 3, 5]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    %2 = llvm.icmp "sle" %1, %arg0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }
  llvm.func @ashr_by_const_cmp_sge_value_non_splat(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.ashr %arg0, %0  : vector<4xi32>
    %2 = llvm.icmp "sge" %1, %arg0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }
  llvm.func @lshr_by_const_cmp_sge_value(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.icmp "sge" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ashr_x_by_const_cmp_sge_x(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    %2 = llvm.icmp "sge" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @udiv_x_by_const_cmp_eq_value_neg(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.udiv %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "eq" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @sdiv_x_by_const_cmp_eq_value_neg(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "eq" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @lshr_x_by_const_cmp_slt_value_neg(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "slt" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @sdiv_x_by_const_cmp_ult_value_neg(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg0 : i32
    llvm.return %2 : i1
  }
  llvm.func @sdiv_x_by_const_cmp_sgt_value_neg(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %2 = llvm.icmp "sgt" %1, %arg0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }
  llvm.func @ashr_x_by_const_cmp_sle_value_neg(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    %2 = llvm.icmp "sle" %1, %arg0 : i32
    llvm.return %2 : i1
  }
}
