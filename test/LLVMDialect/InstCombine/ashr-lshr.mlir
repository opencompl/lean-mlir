module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @ashr_lshr_exact_ashr_only(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_no_exact(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_exact_both(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_exact_lshr_only(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_splat_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @ashr_lshr_splat_vec2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @ashr_lshr_splat_vec3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @ashr_lshr_splat_vec4(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @ashr_lshr_nonsplat_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @ashr_lshr_nonsplat_vec2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 4]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @ashr_lshr_nonsplat_vec3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @ashr_lshr_nonsplat_vec4(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8, 7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @ashr_lshr_cst(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.ashr %arg0, %1  : i32
    %5 = llvm.select %2, %4, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @ashr_lshr_cst2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.ashr %arg0, %1  : i32
    %5 = llvm.select %2, %3, %4 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @ashr_lshr_inv(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %3, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_inv2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %3, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_inv_splat_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %3, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @ashr_lshr_inv_nonsplat_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %3, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @ashr_lshr_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "sgt" %arg0, %6 : vector<2xi32>
    %8 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %9 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %10 = llvm.select %7, %8, %9 : vector<2xi1>, vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }
  llvm.func @ashr_lshr_vec_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "slt" %arg0, %6 : vector<2xi32>
    %8 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %9 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %10 = llvm.select %7, %9, %8 : vector<2xi1>, vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }
  llvm.func @ashr_lshr_wrong_cst(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_wrong_cst2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %3, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_wrong_cond(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_shift_wrong_pred(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sle" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_shift_wrong_pred2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg2, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_wrong_operands(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %3, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_no_ashr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.xor %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_shift_amt_mismatch(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg2  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_shift_base_mismatch(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg2, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_no_lshr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_vec_wrong_pred(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sle" %arg0, %1 : vector<2xi32>
    %3 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %5 = llvm.select %2, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @ashr_lshr_inv_vec_wrong_pred(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sge" %arg0, %1 : vector<2xi32>
    %3 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %5 = llvm.select %2, %4, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @lshr_sub_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @lshr_sub_wrong_amount(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @lshr_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @lshr_sub_nsw_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @lshr_sub_nsw_splat(%arg0: vector<3xi42>, %arg1: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.constant(41 : i42) : i42
    %1 = llvm.mlir.constant(dense<41> : vector<3xi42>) : vector<3xi42>
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<3xi42>
    %3 = llvm.lshr %2, %1  : vector<3xi42>
    llvm.return %3 : vector<3xi42>
  }
  llvm.func @lshr_sub_nsw_splat_poison(%arg0: vector<3xi42>, %arg1: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.constant(41 : i42) : i42
    %1 = llvm.mlir.poison : i42
    %2 = llvm.mlir.undef : vector<3xi42>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi42>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi42>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi42>
    %9 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<3xi42>
    %10 = llvm.lshr %9, %8  : vector<3xi42>
    llvm.return %10 : vector<3xi42>
  }
  llvm.func @ashr_sub_nsw(%arg0: i17, %arg1: i17) -> i17 {
    %0 = llvm.mlir.constant(16 : i17) : i17
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i17
    %2 = llvm.ashr %1, %0  : i17
    llvm.return %2 : i17
  }
  llvm.func @ashr_sub_wrong_amount(%arg0: i17, %arg1: i17) -> i17 {
    %0 = llvm.mlir.constant(15 : i17) : i17
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i17
    %2 = llvm.ashr %1, %0  : i17
    llvm.return %2 : i17
  }
  llvm.func @ashr_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @ashr_sub_nsw_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @ashr_sub_nsw_splat(%arg0: vector<3xi43>, %arg1: vector<3xi43>) -> vector<3xi43> {
    %0 = llvm.mlir.constant(42 : i43) : i43
    %1 = llvm.mlir.constant(dense<42> : vector<3xi43>) : vector<3xi43>
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<3xi43>
    %3 = llvm.ashr %2, %1  : vector<3xi43>
    llvm.return %3 : vector<3xi43>
  }
  llvm.func @ashr_sub_nsw_splat_poison(%arg0: vector<3xi43>, %arg1: vector<3xi43>) -> vector<3xi43> {
    %0 = llvm.mlir.constant(42 : i43) : i43
    %1 = llvm.mlir.poison : i43
    %2 = llvm.mlir.undef : vector<3xi43>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi43>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi43>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi43>
    %9 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<3xi43>
    %10 = llvm.ashr %9, %8  : vector<3xi43>
    llvm.return %10 : vector<3xi43>
  }
  llvm.func @ashr_known_pos_exact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.ashr %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @ashr_known_pos_exact_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mul %arg0, %arg0 overflow<nsw>  : vector<2xi8>
    %1 = llvm.ashr %0, %arg1  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
  llvm.func @lshr_mul_times_3_div_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_mul_times_3_div_2_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_mul_times_3_div_2_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @mul_times_3_div_2_multiuse_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i32
  }
  llvm.func @lshr_mul_times_3_div_2_exact_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_mul_times_5_div_4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_mul_times_5_div_4_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_mul_times_5_div_4_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @mul_times_5_div_4_multiuse_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i32
  }
  llvm.func @lshr_mul_times_5_div_4_exact_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_mul_times_3_div_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_mul_times_3_div_2_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_mul_times_3_div_2_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_mul_times_3_div_2_no_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @mul_times_3_div_2_multiuse_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i32
  }
  llvm.func @ashr_mul_times_3_div_2_exact_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_mul_times_5_div_4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_mul_times_5_div_4_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_mul_times_5_div_4_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @mul_times_5_div_4_multiuse_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i32
  }
  llvm.func @ashr_mul_times_5_div_4_exact_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @use(i32)
}
