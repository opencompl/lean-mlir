module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @atomic_add_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw add %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @atomic_or_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @atomic_sub_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw sub %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @atomic_and_allones(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw _and %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @atomic_umin_uint_max(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw umin %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @atomic_umax_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw umax %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @atomic_min_smax_char(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.atomicrmw min %arg0, %0 monotonic {alignment = 1 : i64} : !llvm.ptr, i8
    llvm.return %1 : i8
  }
  llvm.func @atomic_max_smin_char(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.atomicrmw max %arg0, %0 monotonic {alignment = 1 : i64} : !llvm.ptr, i8
    llvm.return %1 : i8
  }
  llvm.func @atomic_fsub_zero(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fsub %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, f32
    llvm.return %1 : f32
  }
  llvm.func @atomic_fadd_zero(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, f32
    llvm.return %1 : f32
  }
  llvm.func @atomic_fsub_canon(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fsub %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, f32
    llvm.return %1 : f32
  }
  llvm.func @atomic_fadd_canon(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, f32
    llvm.return %1 : f32
  }
  llvm.func @atomic_sub_zero_volatile(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.atomicrmw volatile sub %arg0, %0 acquire {alignment = 8 : i64} : !llvm.ptr, i64
    llvm.return %1 : i64
  }
  llvm.func @atomic_syncscope(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("some_syncscope") acquire {alignment = 2 : i64} : !llvm.ptr, i16
    llvm.return %1 : i16
  }
  llvm.func @atomic_seq_cst(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw add %arg0, %0 seq_cst {alignment = 2 : i64} : !llvm.ptr, i16
    llvm.return %1 : i16
  }
  llvm.func @atomic_add_non_zero(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.atomicrmw add %arg0, %0 monotonic {alignment = 2 : i64} : !llvm.ptr, i16
    llvm.return %1 : i16
  }
  llvm.func @atomic_xor_zero(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _xor %arg0, %0 monotonic {alignment = 2 : i64} : !llvm.ptr, i16
    llvm.return %1 : i16
  }
  llvm.func @atomic_release(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw sub %arg0, %0 release {alignment = 2 : i64} : !llvm.ptr, i16
    llvm.return %1 : i16
  }
  llvm.func @atomic_acq_rel(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _xor %arg0, %0 acq_rel {alignment = 2 : i64} : !llvm.ptr, i16
    llvm.return %1 : i16
  }
  llvm.func @sat_or_allones(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @sat_and_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _and %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @sat_umin_uint_min(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw umin %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @sat_umax_uint_max(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw umax %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @sat_min_smin_char(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.atomicrmw min %arg0, %0 monotonic {alignment = 1 : i64} : !llvm.ptr, i8
    llvm.return %1 : i8
  }
  llvm.func @sat_max_smax_char(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.atomicrmw max %arg0, %0 monotonic {alignment = 1 : i64} : !llvm.ptr, i8
    llvm.return %1 : i8
  }
  llvm.func @sat_fadd_nan(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw fadd %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, f64
    llvm.return %1 : f64
  }
  llvm.func @sat_fsub_nan(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw fsub %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, f64
    llvm.return %1 : f64
  }
  llvm.func @sat_fsub_nan_unused(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw fsub %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64
    llvm.return
  }
  llvm.func @xchg_unused_monotonic(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @xchg_unused_release(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @xchg_unused_under_aligned(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 release {alignment = 1 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @xchg_unused_over_aligned(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @xchg_unused_seq_cst(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 seq_cst {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @xchg_unused_volatile(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw volatile xchg %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @sat_or_allones_unused(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @undef_operand_unused(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @undef_operand_used(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @sat_fmax_inf(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.atomicrmw fmax %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64
    llvm.return %1 : f64
  }
  llvm.func @no_sat_fmax_inf(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.atomicrmw fmax %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64
    llvm.return %1 : f64
  }
  llvm.func @sat_fmin_inf(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = llvm.atomicrmw fmin %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64
    llvm.return %1 : f64
  }
  llvm.func @no_sat_fmin_inf(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.atomicrmw fmin %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64
    llvm.return %1 : f64
  }
  llvm.func @atomic_add_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw add %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @atomic_or_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @atomic_sub_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw sub %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @atomic_and_allones_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw _and %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @atomic_umin_uint_max_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw umin %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @atomic_umax_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw umax %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @atomic_min_smax_char_preserve_md(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.atomicrmw min %arg0, %0 syncscope("agent") monotonic {alignment = 1 : i64} : !llvm.ptr, i8
    llvm.return %1 : i8
  }
  llvm.func @atomic_max_smin_char_preserve_md(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.atomicrmw max %arg0, %0 syncscope("agent") monotonic {alignment = 1 : i64} : !llvm.ptr, i8
    llvm.return %1 : i8
  }
  llvm.func @atomic_fsub_zero_preserve_md(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fsub %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, f32
    llvm.return %1 : f32
  }
  llvm.func @atomic_fadd_zero_preserve_md(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, f32
    llvm.return %1 : f32
  }
  llvm.func @atomic_fsub_canon_preserve_md(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fsub %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, f32
    llvm.return %1 : f32
  }
  llvm.func @atomic_fadd_canon_preserve_md(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, f32
    llvm.return %1 : f32
  }
  llvm.func @atomic_sub_zero_volatile_preserve_md(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.atomicrmw volatile sub %arg0, %0 acquire {alignment = 8 : i64} : !llvm.ptr, i64
    llvm.return %1 : i64
  }
  llvm.func @atomic_syncscope_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("some_syncscope") acquire {alignment = 2 : i64} : !llvm.ptr, i16
    llvm.return %1 : i16
  }
  llvm.func @atomic_seq_cst_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw add %arg0, %0 seq_cst {alignment = 2 : i64} : !llvm.ptr, i16
    llvm.return %1 : i16
  }
  llvm.func @atomic_add_non_zero_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.atomicrmw add %arg0, %0 syncscope("agent") monotonic {alignment = 2 : i64} : !llvm.ptr, i16
    llvm.return %1 : i16
  }
  llvm.func @atomic_xor_zero_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _xor %arg0, %0 syncscope("agent") monotonic {alignment = 2 : i64} : !llvm.ptr, i16
    llvm.return %1 : i16
  }
  llvm.func @atomic_release_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw sub %arg0, %0 release {alignment = 2 : i64} : !llvm.ptr, i16
    llvm.return %1 : i16
  }
  llvm.func @atomic_acq_rel_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _xor %arg0, %0 acq_rel {alignment = 2 : i64} : !llvm.ptr, i16
    llvm.return %1 : i16
  }
  llvm.func @sat_or_allones_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @sat_and_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _and %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @sat_umin_uint_min_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw umin %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @sat_umax_uint_max_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw umax %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @sat_min_smin_char_preserve_md(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.atomicrmw min %arg0, %0 syncscope("agent") monotonic {alignment = 1 : i64} : !llvm.ptr, i8
    llvm.return %1 : i8
  }
  llvm.func @sat_max_smax_char_preserve_md(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.atomicrmw max %arg0, %0 syncscope("agent") monotonic {alignment = 1 : i64} : !llvm.ptr, i8
    llvm.return %1 : i8
  }
  llvm.func @sat_fadd_nan_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw fadd %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, f64
    llvm.return %1 : f64
  }
  llvm.func @sat_fsub_nan_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw fsub %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, f64
    llvm.return %1 : f64
  }
  llvm.func @sat_fsub_nan_unused_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw fsub %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64
    llvm.return
  }
  llvm.func @xchg_unused_monotonic_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @xchg_unused_release_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") release {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @xchg_unused_under_aligned_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") release {alignment = 1 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @xchg_unused_over_aligned_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") release {alignment = 8 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @xchg_unused_seq_cst_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") seq_cst {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @xchg_unused_volatile_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw volatile xchg %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @sat_or_allones_unused_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @undef_operand_unused_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return
  }
  llvm.func @undef_operand_used_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.return %1 : i32
  }
  llvm.func @sat_fmax_inf_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.atomicrmw fmax %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64
    llvm.return %1 : f64
  }
  llvm.func @no_sat_fmax_inf_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.atomicrmw fmax %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64
    llvm.return %1 : f64
  }
  llvm.func @sat_fmin_inf_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = llvm.atomicrmw fmin %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64
    llvm.return %1 : f64
  }
  llvm.func @no_sat_fmin_inf_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.atomicrmw fmin %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64
    llvm.return %1 : f64
  }
}
