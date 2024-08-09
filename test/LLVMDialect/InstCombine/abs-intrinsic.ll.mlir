module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @test_abs_abs_a_mul_b_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i8) -> i8
    %1 = llvm.mul %0, %arg1  : i8
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @test_abs_a_mul_abs_b_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.urem %0, %arg0  : i8
    %2 = "llvm.intr.abs"(%arg1) <{is_int_min_poison = true}> : (i8) -> i8
    %3 = llvm.mul %1, %2  : i8
    %4 = "llvm.intr.abs"(%3) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @test_abs_abs_a_mul_b_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32
    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_abs_abs_a_mul_b_i32_abs_false_true(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_abs_abs_a_mul_b_i32_abs_true_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32
    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_abs_abs_a_mul_b_i32_abs_false_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_nsw_with_true(%arg0: i8, %arg1: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    %1 = llvm.mul %0, %arg1 overflow<nsw>  : i8
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @test_nsw_with_false(%arg0: i8, %arg1: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    %1 = llvm.mul %0, %arg1 overflow<nsw>  : i8
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @test_abs_abs_a_mul_b_more_one_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32
    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %2 : i32
  }
  llvm.func @test_abs_abs_a_mul_b_vector_i8(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (vector<2xi8>) -> vector<2xi8>
    %1 = llvm.mul %0, %arg1  : vector<2xi8>
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (vector<2xi8>) -> vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @abs_trailing_zeros(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (i32) -> i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @abs_trailing_zeros_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[-4, -8, -16, -32]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.and %arg0, %0  : vector<4xi32>
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (vector<4xi32>) -> vector<4xi32>
    %4 = llvm.and %3, %1  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @abs_trailing_zeros_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (i32) -> i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @abs_trailing_zeros_negative_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-2> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-4> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.and %arg0, %0  : vector<4xi32>
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (vector<4xi32>) -> vector<4xi32>
    %4 = llvm.and %3, %1  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @abs_signbits(%arg0: i30) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i30 to i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32
    %3 = llvm.add %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @abs_signbits_vec(%arg0: vector<4xi30>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sext %arg0 : vector<4xi30> to vector<4xi32>
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (vector<4xi32>) -> vector<4xi32>
    %3 = llvm.add %2, %0  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @abs_of_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @abs_of_neg_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %1, %arg0 overflow<nsw>  : vector<4xi32>
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (vector<4xi32>) -> vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @abs_of_select_neg_true_val(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.select %arg0, %1, %arg1 : i1, i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @abs_of_select_neg_false_val(%arg0: vector<4xi1>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %1, %arg1  : vector<4xi32>
    %3 = llvm.select %arg0, %arg1, %2 : vector<4xi1>, vector<4xi32>
    %4 = "llvm.intr.abs"(%3) <{is_int_min_poison = false}> : (vector<4xi32>) -> vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @abs_dom_cond_nopoison(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  ^bb2:  // pred: ^bb0
    %3 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @abs_dom_cond_poison(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.return %2 : i32
  ^bb2:  // pred: ^bb0
    %3 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @zext_abs(%arg0: i31) -> i32 {
    %0 = llvm.zext %arg0 : i31 to i32
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @lshr_abs(%arg0: vector<3xi82>) -> vector<3xi82> {
    %0 = llvm.mlir.constant(1 : i82) : i82
    %1 = llvm.mlir.constant(dense<1> : vector<3xi82>) : vector<3xi82>
    %2 = llvm.lshr %arg0, %1  : vector<3xi82>
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (vector<3xi82>) -> vector<3xi82>
    llvm.return %3 : vector<3xi82>
  }
  llvm.func @and_abs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483644 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @select_abs(%arg0: vector<3xi1>) -> vector<3xi82> {
    %0 = llvm.mlir.constant(0 : i82) : i82
    %1 = llvm.mlir.constant(dense<0> : vector<3xi82>) : vector<3xi82>
    %2 = llvm.mlir.constant(1 : i82) : i82
    %3 = llvm.mlir.constant(42 : i82) : i82
    %4 = llvm.mlir.constant(2147483647 : i82) : i82
    %5 = llvm.mlir.constant(dense<[2147483647, 42, 1]> : vector<3xi82>) : vector<3xi82>
    %6 = llvm.select %arg0, %1, %5 : vector<3xi1>, vector<3xi82>
    %7 = "llvm.intr.abs"(%6) <{is_int_min_poison = false}> : (vector<3xi82>) -> vector<3xi82>
    llvm.return %7 : vector<3xi82>
  }
  llvm.func @assume_abs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @abs_assume_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @abs_known_neg(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @abs_eq_int_min_poison(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @abs_ne_int_min_poison(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @abs_eq_int_min_nopoison(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @abs_ne_int_min_nopoison(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @abs_sext(%arg0: i8) -> i32 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @abs_nsw_sext(%arg0: vector<3xi7>) -> vector<3xi82> {
    %0 = llvm.sext %arg0 : vector<3xi7> to vector<3xi82>
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (vector<3xi82>) -> vector<3xi82>
    llvm.return %1 : vector<3xi82>
  }
  llvm.func @abs_sext_extra_use(%arg0: i8, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.sext %arg0 : i8 to i32
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @trunc_abs_sext(%arg0: i8) -> i8 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (i32) -> i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.return %2 : i8
  }
  llvm.func @trunc_abs_sext_vec(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.sext %arg0 : vector<4xi8> to vector<4xi32>
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (vector<4xi32>) -> vector<4xi32>
    %2 = llvm.trunc %1 : vector<4xi32> to vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @demand_low_bit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @demand_low_bit_int_min_is_poison(%arg0: vector<3xi82>) -> vector<3xi82> {
    %0 = llvm.mlir.constant(81 : i82) : i82
    %1 = llvm.mlir.constant(dense<81> : vector<3xi82>) : vector<3xi82>
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (vector<3xi82>) -> vector<3xi82>
    %3 = llvm.shl %2, %1  : vector<3xi82>
    llvm.return %3 : vector<3xi82>
  }
  llvm.func @demand_low_bits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @srem_by_2_int_min_is_poison(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @srem_by_2(%arg0: vector<3xi82>, %arg1: !llvm.ptr) -> vector<3xi82> {
    %0 = llvm.mlir.constant(2 : i82) : i82
    %1 = llvm.mlir.constant(dense<2> : vector<3xi82>) : vector<3xi82>
    %2 = llvm.srem %arg0, %1  : vector<3xi82>
    llvm.store %2, %arg1 {alignment = 32 : i64} : vector<3xi82>, !llvm.ptr
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (vector<3xi82>) -> vector<3xi82>
    llvm.return %3 : vector<3xi82>
  }
  llvm.func @srem_by_3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @sub_abs_gt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @sub_abs_sgeT(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @sub_abs_sgeT_swap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg1, %arg0 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @sub_abs_sgeT_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @sub_abs_lt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @sub_abs_sle(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @sub_abs_sleF(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i8)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (i8) -> i8
    llvm.br ^bb2(%3 : i8)
  ^bb2(%4: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i8
  }
  llvm.func @sub_abs_sleT(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i8)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.br ^bb2(%3 : i8)
  ^bb2(%4: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i8
  }
  llvm.func @sub_abs_lt_min_not_poison(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @sub_abs_wrong_pred(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @sub_abs_no_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
}
