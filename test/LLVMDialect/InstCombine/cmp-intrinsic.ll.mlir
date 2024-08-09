module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use6(i6)
  llvm.func @use8(i8)
  llvm.func @bswap_eq_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %2 = llvm.icmp "eq" %1, %0 : i16
    llvm.return %2 : i1
  }
  llvm.func @bswap_ne_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @bswap_eq_v2i64(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.intr.bswap(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi64>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @ctlz_eq_bitwidth_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ctlz_eq_zero_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ctlz_ne_zero_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @ctlz_eq_bw_minus_1_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ctlz_ne_bw_minus_1_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @ctlz_eq_other_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ctlz_ne_other_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @ctlz_eq_other_i32_multiuse(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ctlz_ne_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @ctlz_ugt_zero_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ctlz_ugt_one_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ctlz_ugt_other_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ctlz_ugt_other_multiuse_i32(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ctlz_ugt_bw_minus_one_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ctlz_ult_one_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @ctlz_ult_other_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @ctlz_ult_other_multiuse_v2i32(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    llvm.store %1, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @ctlz_ult_bw_minus_one_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @ctlz_ult_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @cttz_ne_bitwidth_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(33 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33
    %2 = llvm.icmp "ne" %1, %0 : i33
    llvm.return %2 : i1
  }
  llvm.func @cttz_eq_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @cttz_eq_zero_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(0 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33
    %2 = llvm.icmp "eq" %1, %0 : i33
    llvm.return %2 : i1
  }
  llvm.func @cttz_ne_zero_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @cttz_eq_bw_minus_1_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(32 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33
    %2 = llvm.icmp "eq" %1, %0 : i33
    llvm.return %2 : i1
  }
  llvm.func @cttz_ne_bw_minus_1_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @cttz_eq_other_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(4 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33
    %2 = llvm.icmp "eq" %1, %0 : i33
    llvm.return %2 : i1
  }
  llvm.func @cttz_ne_other_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @cttz_eq_other_i33_multiuse(%arg0: i33, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(4 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33
    llvm.store %1, %arg1 {alignment = 4 : i64} : i33, !llvm.ptr
    %2 = llvm.icmp "eq" %1, %0 : i33
    llvm.return %2 : i1
  }
  llvm.func @cttz_ugt_zero_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(0 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33
    %2 = llvm.icmp "ugt" %1, %0 : i33
    llvm.return %2 : i1
  }
  llvm.func @cttz_ugt_one_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(1 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33
    %2 = llvm.icmp "ugt" %1, %0 : i33
    llvm.return %2 : i1
  }
  llvm.func @cttz_ugt_other_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(16 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33
    %2 = llvm.icmp "ugt" %1, %0 : i33
    llvm.return %2 : i1
  }
  llvm.func @cttz_ugt_other_multiuse_i33(%arg0: i33, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(16 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33
    llvm.store %1, %arg1 {alignment = 4 : i64} : i33, !llvm.ptr
    %2 = llvm.icmp "ugt" %1, %0 : i33
    llvm.return %2 : i1
  }
  llvm.func @cttz_ugt_bw_minus_one_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(32 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33
    %2 = llvm.icmp "ugt" %1, %0 : i33
    llvm.return %2 : i1
  }
  llvm.func @cttz_ult_one_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @cttz_ult_other_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @cttz_ult_other_multiuse_v2i32(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    llvm.store %1, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @cttz_ult_bw_minus_one_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @cttz_ult_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @ctpop_eq_zero_i11(%arg0: i11) -> i1 {
    %0 = llvm.mlir.constant(0 : i11) : i11
    %1 = llvm.intr.ctpop(%arg0)  : (i11) -> i11
    %2 = llvm.icmp "eq" %1, %0 : i11
    llvm.return %2 : i1
  }
  llvm.func @ctpop_ne_zero_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @ctpop_eq_bitwidth_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @ctpop_ne_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @ctpop_ugt_bitwidth_minus_one_i8(%arg0: i8, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    llvm.store %1, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    %2 = llvm.icmp "ugt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @ctpop_ult_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @trunc_cttz_eq_other_i33_i15(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(4 : i15) : i15
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33
    %2 = llvm.trunc %1 : i33 to i15
    %3 = llvm.icmp "eq" %2, %0 : i15
    llvm.return %3 : i1
  }
  llvm.func @trunc_cttz_ugt_other_i33_i15(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(3 : i15) : i15
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33
    %2 = llvm.trunc %1 : i33 to i15
    %3 = llvm.icmp "ugt" %2, %0 : i15
    llvm.return %3 : i1
  }
  llvm.func @trunc_cttz_ult_other_i33_i6(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(7 : i6) : i6
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i33) -> i33
    %2 = llvm.trunc %1 : i33 to i6
    %3 = llvm.icmp "ult" %2, %0 : i6
    llvm.return %3 : i1
  }
  llvm.func @trunc_cttz_ult_other_i33_i5(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(7 : i5) : i5
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i33) -> i33
    %2 = llvm.trunc %1 : i33 to i5
    %3 = llvm.icmp "ult" %2, %0 : i5
    llvm.return %3 : i1
  }
  llvm.func @trunc_cttz_true_ult_other_i32_i5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i5) : i5
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %2 = llvm.trunc %1 : i32 to i5
    %3 = llvm.icmp "ult" %2, %0 : i5
    llvm.return %3 : i1
  }
  llvm.func @trunc_cttz_false_ult_other_i32_i5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i5) : i5
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.trunc %1 : i32 to i5
    %3 = llvm.icmp "ult" %2, %0 : i5
    llvm.return %3 : i1
  }
  llvm.func @trunc_cttz_false_ult_other_i32_i6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i6) : i6
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.trunc %1 : i32 to i6
    %3 = llvm.icmp "ult" %2, %0 : i6
    llvm.return %3 : i1
  }
  llvm.func @trunc_cttz_false_ult_other_i32_i6_extra_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i6) : i6
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.trunc %1 : i32 to i6
    llvm.call @use6(%2) : (i6) -> ()
    %3 = llvm.icmp "ult" %2, %0 : i6
    llvm.return %3 : i1
  }
  llvm.func @trunc_ctlz_ugt_zero_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i15) : i15
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.trunc %1 : i32 to i15
    %3 = llvm.icmp "ugt" %2, %0 : i15
    llvm.return %3 : i1
  }
  llvm.func @trunc_ctlz_ugt_one_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i15) : i15
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.trunc %1 : i32 to i15
    %3 = llvm.icmp "ugt" %2, %0 : i15
    llvm.return %3 : i1
  }
  llvm.func @trunc_ctlz_ugt_other_i33_i6(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(4 : i6) : i6
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i33) -> i33
    %2 = llvm.trunc %1 : i33 to i6
    %3 = llvm.icmp "ugt" %2, %0 : i6
    llvm.return %3 : i1
  }
  llvm.func @trunc_ctlz_ugt_other_i33_i5(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i33) -> i33
    %2 = llvm.trunc %1 : i33 to i5
    %3 = llvm.icmp "ugt" %2, %0 : i5
    llvm.return %3 : i1
  }
  llvm.func @trunc_ctlz_true_ugt_other_i32_i5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %2 = llvm.trunc %1 : i32 to i5
    %3 = llvm.icmp "ugt" %2, %0 : i5
    llvm.return %3 : i1
  }
  llvm.func @trunc_ctlz_false_ugt_other_i32_i5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.trunc %1 : i32 to i5
    %3 = llvm.icmp "ugt" %2, %0 : i5
    llvm.return %3 : i1
  }
  llvm.func @trunc_ctlz_false_ugt_other_i32_i6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i6) : i6
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.trunc %1 : i32 to i6
    %3 = llvm.icmp "ugt" %2, %0 : i6
    llvm.return %3 : i1
  }
  llvm.func @trunc_ctlz_false_ugt_other_i32_i6_extra_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i6) : i6
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %2 = llvm.trunc %1 : i32 to i6
    llvm.call @use6(%2) : (i6) -> ()
    %3 = llvm.icmp "ugt" %2, %0 : i6
    llvm.return %3 : i1
  }
  llvm.func @trunc_ctpop_eq_zero_i11(%arg0: i11) -> i1 {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.intr.ctpop(%arg0)  : (i11) -> i11
    %2 = llvm.trunc %1 : i11 to i5
    %3 = llvm.icmp "eq" %2, %0 : i5
    llvm.return %3 : i1
  }
  llvm.func @trunc_ctpop_eq_bitwidth_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(8 : i5) : i5
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.trunc %1 : i8 to i5
    %3 = llvm.icmp "eq" %2, %0 : i5
    llvm.return %3 : i1
  }
  llvm.func @trunc_negative_destbits_not_enough(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33
    %2 = llvm.trunc %1 : i33 to i4
    %3 = llvm.icmp "ult" %2, %0 : i4
    llvm.return %3 : i1
  }
  llvm.func @bitreverse_ne_22(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(22 : i8) : i8
    %1 = llvm.intr.bitreverse(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @bitreverse_ult_22_fail_not_equality_pred(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(22 : i8) : i8
    %1 = llvm.intr.bitreverse(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @bitreverse_vec_eq_2_2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.bitreverse(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @bitreverse_vec_eq_1_2_todo_no_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.bitreverse(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @umax_eq_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @umax_eq_1_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @umax_sle_zero_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "sle" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @umax_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @umax_ne_zero_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @uadd_sat_ne_zero_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @ssub_sat_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @ssub_sat_ne_fail_nonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @ssub_sat_eq_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @ssub_sat_sle_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "sle" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @ssub_sat_sge_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "sge" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @ssub_sat_slt_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @ssub_sat_slt_neg1_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @ssub_sat_sgt_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @ssub_sat_sgt_one_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }
}
