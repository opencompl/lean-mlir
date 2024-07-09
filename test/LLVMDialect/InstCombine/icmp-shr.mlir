module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<3>, dense<64> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<2>, dense<32> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<1>, dense<16> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @lshr_eq_msb_low_last_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_eq_msb_low_last_zero_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.lshr %0, %arg0  : vector<2xi8>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @ashr_eq_msb_low_second_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_ne_msb_low_last_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_ne_msb_low_second_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_eq_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.ashr %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @ashr_ne_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.ashr %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @lshr_eq_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @lshr_ne_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @exact_ashr_eq_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.ashr %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @exact_ashr_ne_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.ashr %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @exact_lshr_eq_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @exact_lshr_ne_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @exact_lshr_eq_opposite_msb(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_eq_opposite_msb(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @exact_lshr_ne_opposite_msb(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_ne_opposite_msb(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @exact_ashr_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @exact_ashr_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @exact_lshr_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @exact_lshr_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_ashr_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_ashr_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_lshr_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_lshr_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @exact_lshr_eq_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @exact_lshr_ne_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_lshr_eq_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_lshr_ne_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @exact_ashr_eq_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @exact_ashr_ne_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_ashr_eq_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_ashr_ne_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @exact_lshr_eq_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @exact_lshr_ne_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_lshr_eq_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_lshr_ne_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @exact_ashr_eq_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-31 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @exact_ashr_ne_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-31 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_ashr_eq_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-31 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_ashr_ne_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-31 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_lshr_eq_noexactlog(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(90 : i8) : i8
    %1 = llvm.mlir.constant(30 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_lshr_ne_noexactlog(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(90 : i8) : i8
    %1 = llvm.mlir.constant(30 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_ashr_eq_noexactlog(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-90 : i8) : i8
    %1 = llvm.mlir.constant(-30 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nonexact_ashr_ne_noexactlog(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-90 : i8) : i8
    %1 = llvm.mlir.constant(-30 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @PR20945(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-9 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @PR21222(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-93 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @PR24873(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-4611686018427387904 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.ashr %0, %arg0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @foo(i32)
  llvm.func @exact_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(1024 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.call @foo(%2) : (i32) -> ()
    llvm.return %3 : i1
  }
  llvm.func @ashr_exact_eq_0(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.ashr %arg0, %arg1  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ashr_exact_ne_0_uses(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.ashr %arg0, %arg1  : i32
    llvm.call @foo(%1) : (i32) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ashr_exact_eq_0_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @lshr_exact_ne_0(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @lshr_exact_eq_0_uses(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i32
    llvm.call @foo(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @lshr_exact_ne_0_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @ashr_ugt_0(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_0_multiuse(%arg0: i4, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.store %2, %arg1 {alignment = 1 : i64} : i4, !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_1(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @ashr_ugt_2(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_3(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_4(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_5(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_6(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_7(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_8(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_9(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_0(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_1(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "ult" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @ashr_ult_2(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_2_multiuse(%arg0: i4, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.store %2, %arg1 {alignment = 1 : i64} : i4, !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_3(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_4(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_5(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_6(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_7(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_8(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_9(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshr_eq_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_ne_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_eq_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_ne_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_exact_eq_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_exact_ne_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_exact_eq_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_exact_ne_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_pow2_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_pow2_ugt_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_pow2_ugt_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %0, %arg0  : vector<2xi8>
    %3 = llvm.icmp "ugt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @lshr_not_pow2_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_pow2_ugt1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_pow2_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-96 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_pow2_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_pow2_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_pow2_ult_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_pow2_ult_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %0, %arg0  : vector<2xi8>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @lshr_not_pow2_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_pow2_ult_equal_constants(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @lshr_pow2_ult_smin(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @ashr_pow2_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-96 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_pow2_slt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_neg_sgt_minus_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_neg_sgt_minus_1_vector(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-17> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %0, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @lshr_neg_sgt_minus_1_extra_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_neg_sgt_minus_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_neg_slt_minus_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_neg_slt_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_neg_slt_zero_vector(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-17> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.lshr %0, %arg0  : vector<2xi8>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @lshr_neg_slt_zero_extra_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @"lshr_neg_slt_non-zero"(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshr_neg_sgt_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @exactly_one_set_signbit(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @exactly_one_set_signbit_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @same_signbit(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %arg1, %1 : vector<2xi8>
    %4 = llvm.zext %3 : vector<2xi1> to vector<2xi8>
    %5 = llvm.icmp "ne" %2, %4 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @same_signbit_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.icmp "ne" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @same_signbit_use3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.icmp "ne" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @same_signbit_poison_elts(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(-1 : i8) : i8
    %8 = llvm.mlir.undef : vector<2xi8>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi8>
    %13 = llvm.lshr %arg0, %6  : vector<2xi8>
    %14 = llvm.icmp "sgt" %arg1, %12 : vector<2xi8>
    %15 = llvm.zext %14 : vector<2xi1> to vector<2xi8>
    %16 = llvm.icmp "ne" %13, %15 : vector<2xi8>
    llvm.return %16 : vector<2xi1>
  }
  llvm.func @same_signbit_wrong_type(%arg0: i8, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i32
    %4 = llvm.zext %3 : i1 to i8
    %5 = llvm.icmp "ne" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @exactly_one_set_signbit_wrong_shamt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @exactly_one_set_signbit_wrong_shr(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @exactly_one_set_signbit_wrong_pred(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    %5 = llvm.icmp "sgt" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @exactly_one_set_signbit_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.sext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @exactly_one_set_signbit_use1_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.sext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @same_signbit_signed(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %arg1, %1 : vector<2xi8>
    %4 = llvm.sext %3 : vector<2xi1> to vector<2xi8>
    %5 = llvm.icmp "ne" %2, %4 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @same_signbit_use2_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.sext %3 : i1 to i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.icmp "ne" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @same_signbit_use3_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.sext %3 : i1 to i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.icmp "ne" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @same_signbit_poison_elts_signed(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(-1 : i8) : i8
    %8 = llvm.mlir.undef : vector<2xi8>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi8>
    %13 = llvm.ashr %arg0, %6  : vector<2xi8>
    %14 = llvm.icmp "sgt" %arg1, %12 : vector<2xi8>
    %15 = llvm.sext %14 : vector<2xi1> to vector<2xi8>
    %16 = llvm.icmp "ne" %13, %15 : vector<2xi8>
    llvm.return %16 : vector<2xi1>
  }
  llvm.func @same_signbit_wrong_type_signed(%arg0: i8, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i32
    %4 = llvm.sext %3 : i1 to i8
    %5 = llvm.icmp "ne" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @exactly_one_set_signbit_wrong_shamt_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.sext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @slt_zero_ult_i1(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "ult" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @slt_zero_ult_i1_fail1(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "ult" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @slt_zero_ult_i1_fail2(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.icmp "ult" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @slt_zero_slt_i1_fail(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "slt" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @slt_zero_eq_i1_signed(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sext %arg1 : i1 to i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @slt_zero_eq_i1_fail_signed(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sext %arg1 : i1 to i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }
}
