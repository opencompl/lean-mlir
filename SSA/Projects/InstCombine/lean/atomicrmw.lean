import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  atomicrmw
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def atomic_add_zero_before := [llvmfunc|
  llvm.func @atomic_add_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw add %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def atomic_or_zero_before := [llvmfunc|
  llvm.func @atomic_or_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def atomic_sub_zero_before := [llvmfunc|
  llvm.func @atomic_sub_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw sub %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def atomic_and_allones_before := [llvmfunc|
  llvm.func @atomic_and_allones(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw _and %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def atomic_umin_uint_max_before := [llvmfunc|
  llvm.func @atomic_umin_uint_max(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw umin %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def atomic_umax_zero_before := [llvmfunc|
  llvm.func @atomic_umax_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw umax %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def atomic_min_smax_char_before := [llvmfunc|
  llvm.func @atomic_min_smax_char(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.atomicrmw min %arg0, %0 monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

    llvm.return %1 : i8
  }]

def atomic_max_smin_char_before := [llvmfunc|
  llvm.func @atomic_max_smin_char(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.atomicrmw max %arg0, %0 monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

    llvm.return %1 : i8
  }]

def atomic_fsub_zero_before := [llvmfunc|
  llvm.func @atomic_fsub_zero(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fsub %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, f32]

    llvm.return %1 : f32
  }]

def atomic_fadd_zero_before := [llvmfunc|
  llvm.func @atomic_fadd_zero(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, f32]

    llvm.return %1 : f32
  }]

def atomic_fsub_canon_before := [llvmfunc|
  llvm.func @atomic_fsub_canon(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fsub %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, f32]

    llvm.return %1 : f32
  }]

def atomic_fadd_canon_before := [llvmfunc|
  llvm.func @atomic_fadd_canon(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, f32]

    llvm.return %1 : f32
  }]

def atomic_sub_zero_volatile_before := [llvmfunc|
  llvm.func @atomic_sub_zero_volatile(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.atomicrmw volatile sub %arg0, %0 acquire {alignment = 8 : i64} : !llvm.ptr, i64]

    llvm.return %1 : i64
  }]

def atomic_syncscope_before := [llvmfunc|
  llvm.func @atomic_syncscope(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("some_syncscope") acquire {alignment = 2 : i64} : !llvm.ptr, i16]

    llvm.return %1 : i16
  }]

def atomic_seq_cst_before := [llvmfunc|
  llvm.func @atomic_seq_cst(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw add %arg0, %0 seq_cst {alignment = 2 : i64} : !llvm.ptr, i16]

    llvm.return %1 : i16
  }]

def atomic_add_non_zero_before := [llvmfunc|
  llvm.func @atomic_add_non_zero(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.atomicrmw add %arg0, %0 monotonic {alignment = 2 : i64} : !llvm.ptr, i16]

    llvm.return %1 : i16
  }]

def atomic_xor_zero_before := [llvmfunc|
  llvm.func @atomic_xor_zero(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _xor %arg0, %0 monotonic {alignment = 2 : i64} : !llvm.ptr, i16]

    llvm.return %1 : i16
  }]

def atomic_release_before := [llvmfunc|
  llvm.func @atomic_release(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw sub %arg0, %0 release {alignment = 2 : i64} : !llvm.ptr, i16]

    llvm.return %1 : i16
  }]

def atomic_acq_rel_before := [llvmfunc|
  llvm.func @atomic_acq_rel(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _xor %arg0, %0 acq_rel {alignment = 2 : i64} : !llvm.ptr, i16]

    llvm.return %1 : i16
  }]

def sat_or_allones_before := [llvmfunc|
  llvm.func @sat_or_allones(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def sat_and_zero_before := [llvmfunc|
  llvm.func @sat_and_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _and %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def sat_umin_uint_min_before := [llvmfunc|
  llvm.func @sat_umin_uint_min(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw umin %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def sat_umax_uint_max_before := [llvmfunc|
  llvm.func @sat_umax_uint_max(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw umax %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def sat_min_smin_char_before := [llvmfunc|
  llvm.func @sat_min_smin_char(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.atomicrmw min %arg0, %0 monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

    llvm.return %1 : i8
  }]

def sat_max_smax_char_before := [llvmfunc|
  llvm.func @sat_max_smax_char(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.atomicrmw max %arg0, %0 monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

    llvm.return %1 : i8
  }]

def sat_fadd_nan_before := [llvmfunc|
  llvm.func @sat_fadd_nan(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw fadd %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, f64]

    llvm.return %1 : f64
  }]

def sat_fsub_nan_before := [llvmfunc|
  llvm.func @sat_fsub_nan(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw fsub %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, f64]

    llvm.return %1 : f64
  }]

def sat_fsub_nan_unused_before := [llvmfunc|
  llvm.func @sat_fsub_nan_unused(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw fsub %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

    llvm.return
  }]

def xchg_unused_monotonic_before := [llvmfunc|
  llvm.func @xchg_unused_monotonic(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def xchg_unused_release_before := [llvmfunc|
  llvm.func @xchg_unused_release(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def xchg_unused_under_aligned_before := [llvmfunc|
  llvm.func @xchg_unused_under_aligned(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 release {alignment = 1 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def xchg_unused_over_aligned_before := [llvmfunc|
  llvm.func @xchg_unused_over_aligned(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def xchg_unused_seq_cst_before := [llvmfunc|
  llvm.func @xchg_unused_seq_cst(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 seq_cst {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def xchg_unused_volatile_before := [llvmfunc|
  llvm.func @xchg_unused_volatile(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw volatile xchg %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def sat_or_allones_unused_before := [llvmfunc|
  llvm.func @sat_or_allones_unused(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def undef_operand_unused_before := [llvmfunc|
  llvm.func @undef_operand_unused(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def undef_operand_used_before := [llvmfunc|
  llvm.func @undef_operand_used(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def sat_fmax_inf_before := [llvmfunc|
  llvm.func @sat_fmax_inf(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.atomicrmw fmax %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

    llvm.return %1 : f64
  }]

def no_sat_fmax_inf_before := [llvmfunc|
  llvm.func @no_sat_fmax_inf(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.atomicrmw fmax %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

    llvm.return %1 : f64
  }]

def sat_fmin_inf_before := [llvmfunc|
  llvm.func @sat_fmin_inf(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = llvm.atomicrmw fmin %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

    llvm.return %1 : f64
  }]

def no_sat_fmin_inf_before := [llvmfunc|
  llvm.func @no_sat_fmin_inf(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.atomicrmw fmin %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

    llvm.return %1 : f64
  }]

def atomic_add_zero_preserve_md_before := [llvmfunc|
  llvm.func @atomic_add_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw add %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def atomic_or_zero_preserve_md_before := [llvmfunc|
  llvm.func @atomic_or_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def atomic_sub_zero_preserve_md_before := [llvmfunc|
  llvm.func @atomic_sub_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw sub %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def atomic_and_allones_preserve_md_before := [llvmfunc|
  llvm.func @atomic_and_allones_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw _and %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def atomic_umin_uint_max_preserve_md_before := [llvmfunc|
  llvm.func @atomic_umin_uint_max_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw umin %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def atomic_umax_zero_preserve_md_before := [llvmfunc|
  llvm.func @atomic_umax_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw umax %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def atomic_min_smax_char_preserve_md_before := [llvmfunc|
  llvm.func @atomic_min_smax_char_preserve_md(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.atomicrmw min %arg0, %0 syncscope("agent") monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

    llvm.return %1 : i8
  }]

def atomic_max_smin_char_preserve_md_before := [llvmfunc|
  llvm.func @atomic_max_smin_char_preserve_md(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.atomicrmw max %arg0, %0 syncscope("agent") monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

    llvm.return %1 : i8
  }]

def atomic_fsub_zero_preserve_md_before := [llvmfunc|
  llvm.func @atomic_fsub_zero_preserve_md(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fsub %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, f32]

    llvm.return %1 : f32
  }]

def atomic_fadd_zero_preserve_md_before := [llvmfunc|
  llvm.func @atomic_fadd_zero_preserve_md(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, f32]

    llvm.return %1 : f32
  }]

def atomic_fsub_canon_preserve_md_before := [llvmfunc|
  llvm.func @atomic_fsub_canon_preserve_md(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fsub %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, f32]

    llvm.return %1 : f32
  }]

def atomic_fadd_canon_preserve_md_before := [llvmfunc|
  llvm.func @atomic_fadd_canon_preserve_md(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, f32]

    llvm.return %1 : f32
  }]

def atomic_sub_zero_volatile_preserve_md_before := [llvmfunc|
  llvm.func @atomic_sub_zero_volatile_preserve_md(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.atomicrmw volatile sub %arg0, %0 acquire {alignment = 8 : i64} : !llvm.ptr, i64]

    llvm.return %1 : i64
  }]

def atomic_syncscope_preserve_md_before := [llvmfunc|
  llvm.func @atomic_syncscope_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("some_syncscope") acquire {alignment = 2 : i64} : !llvm.ptr, i16]

    llvm.return %1 : i16
  }]

def atomic_seq_cst_preserve_md_before := [llvmfunc|
  llvm.func @atomic_seq_cst_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw add %arg0, %0 seq_cst {alignment = 2 : i64} : !llvm.ptr, i16]

    llvm.return %1 : i16
  }]

def atomic_add_non_zero_preserve_md_before := [llvmfunc|
  llvm.func @atomic_add_non_zero_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.atomicrmw add %arg0, %0 syncscope("agent") monotonic {alignment = 2 : i64} : !llvm.ptr, i16]

    llvm.return %1 : i16
  }]

def atomic_xor_zero_preserve_md_before := [llvmfunc|
  llvm.func @atomic_xor_zero_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _xor %arg0, %0 syncscope("agent") monotonic {alignment = 2 : i64} : !llvm.ptr, i16]

    llvm.return %1 : i16
  }]

def atomic_release_preserve_md_before := [llvmfunc|
  llvm.func @atomic_release_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw sub %arg0, %0 release {alignment = 2 : i64} : !llvm.ptr, i16]

    llvm.return %1 : i16
  }]

def atomic_acq_rel_preserve_md_before := [llvmfunc|
  llvm.func @atomic_acq_rel_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _xor %arg0, %0 acq_rel {alignment = 2 : i64} : !llvm.ptr, i16]

    llvm.return %1 : i16
  }]

def sat_or_allones_preserve_md_before := [llvmfunc|
  llvm.func @sat_or_allones_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def sat_and_zero_preserve_md_before := [llvmfunc|
  llvm.func @sat_and_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _and %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def sat_umin_uint_min_preserve_md_before := [llvmfunc|
  llvm.func @sat_umin_uint_min_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw umin %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def sat_umax_uint_max_preserve_md_before := [llvmfunc|
  llvm.func @sat_umax_uint_max_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw umax %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def sat_min_smin_char_preserve_md_before := [llvmfunc|
  llvm.func @sat_min_smin_char_preserve_md(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.atomicrmw min %arg0, %0 syncscope("agent") monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

    llvm.return %1 : i8
  }]

def sat_max_smax_char_preserve_md_before := [llvmfunc|
  llvm.func @sat_max_smax_char_preserve_md(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.atomicrmw max %arg0, %0 syncscope("agent") monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

    llvm.return %1 : i8
  }]

def sat_fadd_nan_preserve_md_before := [llvmfunc|
  llvm.func @sat_fadd_nan_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw fadd %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, f64]

    llvm.return %1 : f64
  }]

def sat_fsub_nan_preserve_md_before := [llvmfunc|
  llvm.func @sat_fsub_nan_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw fsub %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, f64]

    llvm.return %1 : f64
  }]

def sat_fsub_nan_unused_preserve_md_before := [llvmfunc|
  llvm.func @sat_fsub_nan_unused_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw fsub %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

    llvm.return
  }]

def xchg_unused_monotonic_preserve_md_before := [llvmfunc|
  llvm.func @xchg_unused_monotonic_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def xchg_unused_release_preserve_md_before := [llvmfunc|
  llvm.func @xchg_unused_release_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") release {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def xchg_unused_under_aligned_preserve_md_before := [llvmfunc|
  llvm.func @xchg_unused_under_aligned_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") release {alignment = 1 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def xchg_unused_over_aligned_preserve_md_before := [llvmfunc|
  llvm.func @xchg_unused_over_aligned_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") release {alignment = 8 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def xchg_unused_seq_cst_preserve_md_before := [llvmfunc|
  llvm.func @xchg_unused_seq_cst_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") seq_cst {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def xchg_unused_volatile_preserve_md_before := [llvmfunc|
  llvm.func @xchg_unused_volatile_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw volatile xchg %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def sat_or_allones_unused_preserve_md_before := [llvmfunc|
  llvm.func @sat_or_allones_unused_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def undef_operand_unused_preserve_md_before := [llvmfunc|
  llvm.func @undef_operand_unused_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return
  }]

def undef_operand_used_preserve_md_before := [llvmfunc|
  llvm.func @undef_operand_used_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.return %1 : i32
  }]

def sat_fmax_inf_preserve_md_before := [llvmfunc|
  llvm.func @sat_fmax_inf_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.atomicrmw fmax %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

    llvm.return %1 : f64
  }]

def no_sat_fmax_inf_preserve_md_before := [llvmfunc|
  llvm.func @no_sat_fmax_inf_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.atomicrmw fmax %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

    llvm.return %1 : f64
  }]

def sat_fmin_inf_preserve_md_before := [llvmfunc|
  llvm.func @sat_fmin_inf_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = llvm.atomicrmw fmin %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

    llvm.return %1 : f64
  }]

def no_sat_fmin_inf_preserve_md_before := [llvmfunc|
  llvm.func @no_sat_fmin_inf_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.atomicrmw fmin %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

    llvm.return %1 : f64
  }]

def atomic_add_zero_combined := [llvmfunc|
  llvm.func @atomic_add_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_atomic_add_zero   : atomic_add_zero_before  ⊑  atomic_add_zero_combined := by
  unfold atomic_add_zero_before atomic_add_zero_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_atomic_add_zero   : atomic_add_zero_before  ⊑  atomic_add_zero_combined := by
  unfold atomic_add_zero_before atomic_add_zero_combined
  simp_alive_peephole
  sorry
def atomic_or_zero_combined := [llvmfunc|
  llvm.func @atomic_or_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_atomic_or_zero   : atomic_or_zero_before  ⊑  atomic_or_zero_combined := by
  unfold atomic_or_zero_before atomic_or_zero_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_atomic_or_zero   : atomic_or_zero_before  ⊑  atomic_or_zero_combined := by
  unfold atomic_or_zero_before atomic_or_zero_combined
  simp_alive_peephole
  sorry
def atomic_sub_zero_combined := [llvmfunc|
  llvm.func @atomic_sub_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_atomic_sub_zero   : atomic_sub_zero_before  ⊑  atomic_sub_zero_combined := by
  unfold atomic_sub_zero_before atomic_sub_zero_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_atomic_sub_zero   : atomic_sub_zero_before  ⊑  atomic_sub_zero_combined := by
  unfold atomic_sub_zero_before atomic_sub_zero_combined
  simp_alive_peephole
  sorry
def atomic_and_allones_combined := [llvmfunc|
  llvm.func @atomic_and_allones(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_atomic_and_allones   : atomic_and_allones_before  ⊑  atomic_and_allones_combined := by
  unfold atomic_and_allones_before atomic_and_allones_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_atomic_and_allones   : atomic_and_allones_before  ⊑  atomic_and_allones_combined := by
  unfold atomic_and_allones_before atomic_and_allones_combined
  simp_alive_peephole
  sorry
def atomic_umin_uint_max_combined := [llvmfunc|
  llvm.func @atomic_umin_uint_max(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_atomic_umin_uint_max   : atomic_umin_uint_max_before  ⊑  atomic_umin_uint_max_combined := by
  unfold atomic_umin_uint_max_before atomic_umin_uint_max_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_atomic_umin_uint_max   : atomic_umin_uint_max_before  ⊑  atomic_umin_uint_max_combined := by
  unfold atomic_umin_uint_max_before atomic_umin_uint_max_combined
  simp_alive_peephole
  sorry
def atomic_umax_zero_combined := [llvmfunc|
  llvm.func @atomic_umax_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_atomic_umax_zero   : atomic_umax_zero_before  ⊑  atomic_umax_zero_combined := by
  unfold atomic_umax_zero_before atomic_umax_zero_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_atomic_umax_zero   : atomic_umax_zero_before  ⊑  atomic_umax_zero_combined := by
  unfold atomic_umax_zero_before atomic_umax_zero_combined
  simp_alive_peephole
  sorry
def atomic_min_smax_char_combined := [llvmfunc|
  llvm.func @atomic_min_smax_char(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

theorem inst_combine_atomic_min_smax_char   : atomic_min_smax_char_before  ⊑  atomic_min_smax_char_combined := by
  unfold atomic_min_smax_char_before atomic_min_smax_char_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_atomic_min_smax_char   : atomic_min_smax_char_before  ⊑  atomic_min_smax_char_combined := by
  unfold atomic_min_smax_char_before atomic_min_smax_char_combined
  simp_alive_peephole
  sorry
def atomic_max_smin_char_combined := [llvmfunc|
  llvm.func @atomic_max_smin_char(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

theorem inst_combine_atomic_max_smin_char   : atomic_max_smin_char_before  ⊑  atomic_max_smin_char_combined := by
  unfold atomic_max_smin_char_before atomic_max_smin_char_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_atomic_max_smin_char   : atomic_max_smin_char_before  ⊑  atomic_max_smin_char_combined := by
  unfold atomic_max_smin_char_before atomic_max_smin_char_combined
  simp_alive_peephole
  sorry
def atomic_fsub_zero_combined := [llvmfunc|
  llvm.func @atomic_fsub_zero(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, f32]

theorem inst_combine_atomic_fsub_zero   : atomic_fsub_zero_before  ⊑  atomic_fsub_zero_combined := by
  unfold atomic_fsub_zero_before atomic_fsub_zero_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_atomic_fsub_zero   : atomic_fsub_zero_before  ⊑  atomic_fsub_zero_combined := by
  unfold atomic_fsub_zero_before atomic_fsub_zero_combined
  simp_alive_peephole
  sorry
def atomic_fadd_zero_combined := [llvmfunc|
  llvm.func @atomic_fadd_zero(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, f32]

theorem inst_combine_atomic_fadd_zero   : atomic_fadd_zero_before  ⊑  atomic_fadd_zero_combined := by
  unfold atomic_fadd_zero_before atomic_fadd_zero_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_atomic_fadd_zero   : atomic_fadd_zero_before  ⊑  atomic_fadd_zero_combined := by
  unfold atomic_fadd_zero_before atomic_fadd_zero_combined
  simp_alive_peephole
  sorry
def atomic_fsub_canon_combined := [llvmfunc|
  llvm.func @atomic_fsub_canon(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, f32]

theorem inst_combine_atomic_fsub_canon   : atomic_fsub_canon_before  ⊑  atomic_fsub_canon_combined := by
  unfold atomic_fsub_canon_before atomic_fsub_canon_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_atomic_fsub_canon   : atomic_fsub_canon_before  ⊑  atomic_fsub_canon_combined := by
  unfold atomic_fsub_canon_before atomic_fsub_canon_combined
  simp_alive_peephole
  sorry
def atomic_fadd_canon_combined := [llvmfunc|
  llvm.func @atomic_fadd_canon(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, f32]

theorem inst_combine_atomic_fadd_canon   : atomic_fadd_canon_before  ⊑  atomic_fadd_canon_combined := by
  unfold atomic_fadd_canon_before atomic_fadd_canon_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_atomic_fadd_canon   : atomic_fadd_canon_before  ⊑  atomic_fadd_canon_combined := by
  unfold atomic_fadd_canon_before atomic_fadd_canon_combined
  simp_alive_peephole
  sorry
def atomic_sub_zero_volatile_combined := [llvmfunc|
  llvm.func @atomic_sub_zero_volatile(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.atomicrmw volatile sub %arg0, %0 acquire {alignment = 8 : i64} : !llvm.ptr, i64]

theorem inst_combine_atomic_sub_zero_volatile   : atomic_sub_zero_volatile_before  ⊑  atomic_sub_zero_volatile_combined := by
  unfold atomic_sub_zero_volatile_before atomic_sub_zero_volatile_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i64
  }]

theorem inst_combine_atomic_sub_zero_volatile   : atomic_sub_zero_volatile_before  ⊑  atomic_sub_zero_volatile_combined := by
  unfold atomic_sub_zero_volatile_before atomic_sub_zero_volatile_combined
  simp_alive_peephole
  sorry
def atomic_syncscope_combined := [llvmfunc|
  llvm.func @atomic_syncscope(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("some_syncscope") acquire {alignment = 2 : i64} : !llvm.ptr, i16]

theorem inst_combine_atomic_syncscope   : atomic_syncscope_before  ⊑  atomic_syncscope_combined := by
  unfold atomic_syncscope_before atomic_syncscope_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i16
  }]

theorem inst_combine_atomic_syncscope   : atomic_syncscope_before  ⊑  atomic_syncscope_combined := by
  unfold atomic_syncscope_before atomic_syncscope_combined
  simp_alive_peephole
  sorry
def atomic_seq_cst_combined := [llvmfunc|
  llvm.func @atomic_seq_cst(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _or %arg0, %0 seq_cst {alignment = 2 : i64} : !llvm.ptr, i16]

theorem inst_combine_atomic_seq_cst   : atomic_seq_cst_before  ⊑  atomic_seq_cst_combined := by
  unfold atomic_seq_cst_before atomic_seq_cst_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i16
  }]

theorem inst_combine_atomic_seq_cst   : atomic_seq_cst_before  ⊑  atomic_seq_cst_combined := by
  unfold atomic_seq_cst_before atomic_seq_cst_combined
  simp_alive_peephole
  sorry
def atomic_add_non_zero_combined := [llvmfunc|
  llvm.func @atomic_add_non_zero(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.atomicrmw add %arg0, %0 monotonic {alignment = 2 : i64} : !llvm.ptr, i16]

theorem inst_combine_atomic_add_non_zero   : atomic_add_non_zero_before  ⊑  atomic_add_non_zero_combined := by
  unfold atomic_add_non_zero_before atomic_add_non_zero_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i16
  }]

theorem inst_combine_atomic_add_non_zero   : atomic_add_non_zero_before  ⊑  atomic_add_non_zero_combined := by
  unfold atomic_add_non_zero_before atomic_add_non_zero_combined
  simp_alive_peephole
  sorry
def atomic_xor_zero_combined := [llvmfunc|
  llvm.func @atomic_xor_zero(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 2 : i64} : !llvm.ptr, i16]

theorem inst_combine_atomic_xor_zero   : atomic_xor_zero_before  ⊑  atomic_xor_zero_combined := by
  unfold atomic_xor_zero_before atomic_xor_zero_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i16
  }]

theorem inst_combine_atomic_xor_zero   : atomic_xor_zero_before  ⊑  atomic_xor_zero_combined := by
  unfold atomic_xor_zero_before atomic_xor_zero_combined
  simp_alive_peephole
  sorry
def atomic_release_combined := [llvmfunc|
  llvm.func @atomic_release(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _or %arg0, %0 release {alignment = 2 : i64} : !llvm.ptr, i16]

theorem inst_combine_atomic_release   : atomic_release_before  ⊑  atomic_release_combined := by
  unfold atomic_release_before atomic_release_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i16
  }]

theorem inst_combine_atomic_release   : atomic_release_before  ⊑  atomic_release_combined := by
  unfold atomic_release_before atomic_release_combined
  simp_alive_peephole
  sorry
def atomic_acq_rel_combined := [llvmfunc|
  llvm.func @atomic_acq_rel(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _or %arg0, %0 acq_rel {alignment = 2 : i64} : !llvm.ptr, i16]

theorem inst_combine_atomic_acq_rel   : atomic_acq_rel_before  ⊑  atomic_acq_rel_combined := by
  unfold atomic_acq_rel_before atomic_acq_rel_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i16
  }]

theorem inst_combine_atomic_acq_rel   : atomic_acq_rel_before  ⊑  atomic_acq_rel_combined := by
  unfold atomic_acq_rel_before atomic_acq_rel_combined
  simp_alive_peephole
  sorry
def sat_or_allones_combined := [llvmfunc|
  llvm.func @sat_or_allones(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_sat_or_allones   : sat_or_allones_before  ⊑  sat_or_allones_combined := by
  unfold sat_or_allones_before sat_or_allones_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_sat_or_allones   : sat_or_allones_before  ⊑  sat_or_allones_combined := by
  unfold sat_or_allones_before sat_or_allones_combined
  simp_alive_peephole
  sorry
def sat_and_zero_combined := [llvmfunc|
  llvm.func @sat_and_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_sat_and_zero   : sat_and_zero_before  ⊑  sat_and_zero_combined := by
  unfold sat_and_zero_before sat_and_zero_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_sat_and_zero   : sat_and_zero_before  ⊑  sat_and_zero_combined := by
  unfold sat_and_zero_before sat_and_zero_combined
  simp_alive_peephole
  sorry
def sat_umin_uint_min_combined := [llvmfunc|
  llvm.func @sat_umin_uint_min(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_sat_umin_uint_min   : sat_umin_uint_min_before  ⊑  sat_umin_uint_min_combined := by
  unfold sat_umin_uint_min_before sat_umin_uint_min_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_sat_umin_uint_min   : sat_umin_uint_min_before  ⊑  sat_umin_uint_min_combined := by
  unfold sat_umin_uint_min_before sat_umin_uint_min_combined
  simp_alive_peephole
  sorry
def sat_umax_uint_max_combined := [llvmfunc|
  llvm.func @sat_umax_uint_max(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_sat_umax_uint_max   : sat_umax_uint_max_before  ⊑  sat_umax_uint_max_combined := by
  unfold sat_umax_uint_max_before sat_umax_uint_max_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_sat_umax_uint_max   : sat_umax_uint_max_before  ⊑  sat_umax_uint_max_combined := by
  unfold sat_umax_uint_max_before sat_umax_uint_max_combined
  simp_alive_peephole
  sorry
def sat_min_smin_char_combined := [llvmfunc|
  llvm.func @sat_min_smin_char(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.atomicrmw xchg %arg0, %0 monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

theorem inst_combine_sat_min_smin_char   : sat_min_smin_char_before  ⊑  sat_min_smin_char_combined := by
  unfold sat_min_smin_char_before sat_min_smin_char_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_sat_min_smin_char   : sat_min_smin_char_before  ⊑  sat_min_smin_char_combined := by
  unfold sat_min_smin_char_before sat_min_smin_char_combined
  simp_alive_peephole
  sorry
def sat_max_smax_char_combined := [llvmfunc|
  llvm.func @sat_max_smax_char(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.atomicrmw xchg %arg0, %0 monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

theorem inst_combine_sat_max_smax_char   : sat_max_smax_char_before  ⊑  sat_max_smax_char_combined := by
  unfold sat_max_smax_char_before sat_max_smax_char_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_sat_max_smax_char   : sat_max_smax_char_before  ⊑  sat_max_smax_char_combined := by
  unfold sat_max_smax_char_before sat_max_smax_char_combined
  simp_alive_peephole
  sorry
def sat_fadd_nan_combined := [llvmfunc|
  llvm.func @sat_fadd_nan(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw xchg %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, f64]

theorem inst_combine_sat_fadd_nan   : sat_fadd_nan_before  ⊑  sat_fadd_nan_combined := by
  unfold sat_fadd_nan_before sat_fadd_nan_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sat_fadd_nan   : sat_fadd_nan_before  ⊑  sat_fadd_nan_combined := by
  unfold sat_fadd_nan_before sat_fadd_nan_combined
  simp_alive_peephole
  sorry
def sat_fsub_nan_combined := [llvmfunc|
  llvm.func @sat_fsub_nan(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw xchg %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, f64]

theorem inst_combine_sat_fsub_nan   : sat_fsub_nan_before  ⊑  sat_fsub_nan_combined := by
  unfold sat_fsub_nan_before sat_fsub_nan_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sat_fsub_nan   : sat_fsub_nan_before  ⊑  sat_fsub_nan_combined := by
  unfold sat_fsub_nan_before sat_fsub_nan_combined
  simp_alive_peephole
  sorry
def sat_fsub_nan_unused_combined := [llvmfunc|
  llvm.func @sat_fsub_nan_unused(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw xchg %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

theorem inst_combine_sat_fsub_nan_unused   : sat_fsub_nan_unused_before  ⊑  sat_fsub_nan_unused_combined := by
  unfold sat_fsub_nan_unused_before sat_fsub_nan_unused_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_sat_fsub_nan_unused   : sat_fsub_nan_unused_before  ⊑  sat_fsub_nan_unused_combined := by
  unfold sat_fsub_nan_unused_before sat_fsub_nan_unused_combined
  simp_alive_peephole
  sorry
def xchg_unused_monotonic_combined := [llvmfunc|
  llvm.func @xchg_unused_monotonic(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_xchg_unused_monotonic   : xchg_unused_monotonic_before  ⊑  xchg_unused_monotonic_combined := by
  unfold xchg_unused_monotonic_before xchg_unused_monotonic_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_xchg_unused_monotonic   : xchg_unused_monotonic_before  ⊑  xchg_unused_monotonic_combined := by
  unfold xchg_unused_monotonic_before xchg_unused_monotonic_combined
  simp_alive_peephole
  sorry
def xchg_unused_release_combined := [llvmfunc|
  llvm.func @xchg_unused_release(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_xchg_unused_release   : xchg_unused_release_before  ⊑  xchg_unused_release_combined := by
  unfold xchg_unused_release_before xchg_unused_release_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_xchg_unused_release   : xchg_unused_release_before  ⊑  xchg_unused_release_combined := by
  unfold xchg_unused_release_before xchg_unused_release_combined
  simp_alive_peephole
  sorry
def xchg_unused_under_aligned_combined := [llvmfunc|
  llvm.func @xchg_unused_under_aligned(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 release {alignment = 1 : i64} : !llvm.ptr, i32]

theorem inst_combine_xchg_unused_under_aligned   : xchg_unused_under_aligned_before  ⊑  xchg_unused_under_aligned_combined := by
  unfold xchg_unused_under_aligned_before xchg_unused_under_aligned_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_xchg_unused_under_aligned   : xchg_unused_under_aligned_before  ⊑  xchg_unused_under_aligned_combined := by
  unfold xchg_unused_under_aligned_before xchg_unused_under_aligned_combined
  simp_alive_peephole
  sorry
def xchg_unused_over_aligned_combined := [llvmfunc|
  llvm.func @xchg_unused_over_aligned(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, i32]

theorem inst_combine_xchg_unused_over_aligned   : xchg_unused_over_aligned_before  ⊑  xchg_unused_over_aligned_combined := by
  unfold xchg_unused_over_aligned_before xchg_unused_over_aligned_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_xchg_unused_over_aligned   : xchg_unused_over_aligned_before  ⊑  xchg_unused_over_aligned_combined := by
  unfold xchg_unused_over_aligned_before xchg_unused_over_aligned_combined
  simp_alive_peephole
  sorry
def xchg_unused_seq_cst_combined := [llvmfunc|
  llvm.func @xchg_unused_seq_cst(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 seq_cst {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_xchg_unused_seq_cst   : xchg_unused_seq_cst_before  ⊑  xchg_unused_seq_cst_combined := by
  unfold xchg_unused_seq_cst_before xchg_unused_seq_cst_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_xchg_unused_seq_cst   : xchg_unused_seq_cst_before  ⊑  xchg_unused_seq_cst_combined := by
  unfold xchg_unused_seq_cst_before xchg_unused_seq_cst_combined
  simp_alive_peephole
  sorry
def xchg_unused_volatile_combined := [llvmfunc|
  llvm.func @xchg_unused_volatile(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw volatile xchg %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_xchg_unused_volatile   : xchg_unused_volatile_before  ⊑  xchg_unused_volatile_combined := by
  unfold xchg_unused_volatile_before xchg_unused_volatile_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_xchg_unused_volatile   : xchg_unused_volatile_before  ⊑  xchg_unused_volatile_combined := by
  unfold xchg_unused_volatile_before xchg_unused_volatile_combined
  simp_alive_peephole
  sorry
def sat_or_allones_unused_combined := [llvmfunc|
  llvm.func @sat_or_allones_unused(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_sat_or_allones_unused   : sat_or_allones_unused_before  ⊑  sat_or_allones_unused_combined := by
  unfold sat_or_allones_unused_before sat_or_allones_unused_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_sat_or_allones_unused   : sat_or_allones_unused_before  ⊑  sat_or_allones_unused_combined := by
  unfold sat_or_allones_unused_before sat_or_allones_unused_combined
  simp_alive_peephole
  sorry
def undef_operand_unused_combined := [llvmfunc|
  llvm.func @undef_operand_unused(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_undef_operand_unused   : undef_operand_unused_before  ⊑  undef_operand_unused_combined := by
  unfold undef_operand_unused_before undef_operand_unused_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_undef_operand_unused   : undef_operand_unused_before  ⊑  undef_operand_unused_combined := by
  unfold undef_operand_unused_before undef_operand_unused_combined
  simp_alive_peephole
  sorry
def undef_operand_used_combined := [llvmfunc|
  llvm.func @undef_operand_used(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.atomicrmw _or %arg0, %0 monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_undef_operand_used   : undef_operand_used_before  ⊑  undef_operand_used_combined := by
  unfold undef_operand_used_before undef_operand_used_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_undef_operand_used   : undef_operand_used_before  ⊑  undef_operand_used_combined := by
  unfold undef_operand_used_before undef_operand_used_combined
  simp_alive_peephole
  sorry
def sat_fmax_inf_combined := [llvmfunc|
  llvm.func @sat_fmax_inf(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.atomicrmw xchg %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

theorem inst_combine_sat_fmax_inf   : sat_fmax_inf_before  ⊑  sat_fmax_inf_combined := by
  unfold sat_fmax_inf_before sat_fmax_inf_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sat_fmax_inf   : sat_fmax_inf_before  ⊑  sat_fmax_inf_combined := by
  unfold sat_fmax_inf_before sat_fmax_inf_combined
  simp_alive_peephole
  sorry
def no_sat_fmax_inf_combined := [llvmfunc|
  llvm.func @no_sat_fmax_inf(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.atomicrmw fmax %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

theorem inst_combine_no_sat_fmax_inf   : no_sat_fmax_inf_before  ⊑  no_sat_fmax_inf_combined := by
  unfold no_sat_fmax_inf_before no_sat_fmax_inf_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_no_sat_fmax_inf   : no_sat_fmax_inf_before  ⊑  no_sat_fmax_inf_combined := by
  unfold no_sat_fmax_inf_before no_sat_fmax_inf_combined
  simp_alive_peephole
  sorry
def sat_fmin_inf_combined := [llvmfunc|
  llvm.func @sat_fmin_inf(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = llvm.atomicrmw xchg %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

theorem inst_combine_sat_fmin_inf   : sat_fmin_inf_before  ⊑  sat_fmin_inf_combined := by
  unfold sat_fmin_inf_before sat_fmin_inf_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sat_fmin_inf   : sat_fmin_inf_before  ⊑  sat_fmin_inf_combined := by
  unfold sat_fmin_inf_before sat_fmin_inf_combined
  simp_alive_peephole
  sorry
def no_sat_fmin_inf_combined := [llvmfunc|
  llvm.func @no_sat_fmin_inf(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.atomicrmw fmin %arg0, %0 monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

theorem inst_combine_no_sat_fmin_inf   : no_sat_fmin_inf_before  ⊑  no_sat_fmin_inf_combined := by
  unfold no_sat_fmin_inf_before no_sat_fmin_inf_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_no_sat_fmin_inf   : no_sat_fmin_inf_before  ⊑  no_sat_fmin_inf_combined := by
  unfold no_sat_fmin_inf_before no_sat_fmin_inf_combined
  simp_alive_peephole
  sorry
def atomic_add_zero_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_add_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_atomic_add_zero_preserve_md   : atomic_add_zero_preserve_md_before  ⊑  atomic_add_zero_preserve_md_combined := by
  unfold atomic_add_zero_preserve_md_before atomic_add_zero_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_atomic_add_zero_preserve_md   : atomic_add_zero_preserve_md_before  ⊑  atomic_add_zero_preserve_md_combined := by
  unfold atomic_add_zero_preserve_md_before atomic_add_zero_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_or_zero_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_or_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_atomic_or_zero_preserve_md   : atomic_or_zero_preserve_md_before  ⊑  atomic_or_zero_preserve_md_combined := by
  unfold atomic_or_zero_preserve_md_before atomic_or_zero_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_atomic_or_zero_preserve_md   : atomic_or_zero_preserve_md_before  ⊑  atomic_or_zero_preserve_md_combined := by
  unfold atomic_or_zero_preserve_md_before atomic_or_zero_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_sub_zero_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_sub_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_atomic_sub_zero_preserve_md   : atomic_sub_zero_preserve_md_before  ⊑  atomic_sub_zero_preserve_md_combined := by
  unfold atomic_sub_zero_preserve_md_before atomic_sub_zero_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_atomic_sub_zero_preserve_md   : atomic_sub_zero_preserve_md_before  ⊑  atomic_sub_zero_preserve_md_combined := by
  unfold atomic_sub_zero_preserve_md_before atomic_sub_zero_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_and_allones_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_and_allones_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_atomic_and_allones_preserve_md   : atomic_and_allones_preserve_md_before  ⊑  atomic_and_allones_preserve_md_combined := by
  unfold atomic_and_allones_preserve_md_before atomic_and_allones_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_atomic_and_allones_preserve_md   : atomic_and_allones_preserve_md_before  ⊑  atomic_and_allones_preserve_md_combined := by
  unfold atomic_and_allones_preserve_md_before atomic_and_allones_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_umin_uint_max_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_umin_uint_max_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_atomic_umin_uint_max_preserve_md   : atomic_umin_uint_max_preserve_md_before  ⊑  atomic_umin_uint_max_preserve_md_combined := by
  unfold atomic_umin_uint_max_preserve_md_before atomic_umin_uint_max_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_atomic_umin_uint_max_preserve_md   : atomic_umin_uint_max_preserve_md_before  ⊑  atomic_umin_uint_max_preserve_md_combined := by
  unfold atomic_umin_uint_max_preserve_md_before atomic_umin_uint_max_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_umax_zero_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_umax_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_atomic_umax_zero_preserve_md   : atomic_umax_zero_preserve_md_before  ⊑  atomic_umax_zero_preserve_md_combined := by
  unfold atomic_umax_zero_preserve_md_before atomic_umax_zero_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_atomic_umax_zero_preserve_md   : atomic_umax_zero_preserve_md_before  ⊑  atomic_umax_zero_preserve_md_combined := by
  unfold atomic_umax_zero_preserve_md_before atomic_umax_zero_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_min_smax_char_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_min_smax_char_preserve_md(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

theorem inst_combine_atomic_min_smax_char_preserve_md   : atomic_min_smax_char_preserve_md_before  ⊑  atomic_min_smax_char_preserve_md_combined := by
  unfold atomic_min_smax_char_preserve_md_before atomic_min_smax_char_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_atomic_min_smax_char_preserve_md   : atomic_min_smax_char_preserve_md_before  ⊑  atomic_min_smax_char_preserve_md_combined := by
  unfold atomic_min_smax_char_preserve_md_before atomic_min_smax_char_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_max_smin_char_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_max_smin_char_preserve_md(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

theorem inst_combine_atomic_max_smin_char_preserve_md   : atomic_max_smin_char_preserve_md_before  ⊑  atomic_max_smin_char_preserve_md_combined := by
  unfold atomic_max_smin_char_preserve_md_before atomic_max_smin_char_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_atomic_max_smin_char_preserve_md   : atomic_max_smin_char_preserve_md_before  ⊑  atomic_max_smin_char_preserve_md_combined := by
  unfold atomic_max_smin_char_preserve_md_before atomic_max_smin_char_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_fsub_zero_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_fsub_zero_preserve_md(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, f32]

theorem inst_combine_atomic_fsub_zero_preserve_md   : atomic_fsub_zero_preserve_md_before  ⊑  atomic_fsub_zero_preserve_md_combined := by
  unfold atomic_fsub_zero_preserve_md_before atomic_fsub_zero_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_atomic_fsub_zero_preserve_md   : atomic_fsub_zero_preserve_md_before  ⊑  atomic_fsub_zero_preserve_md_combined := by
  unfold atomic_fsub_zero_preserve_md_before atomic_fsub_zero_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_fadd_zero_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_fadd_zero_preserve_md(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, f32]

theorem inst_combine_atomic_fadd_zero_preserve_md   : atomic_fadd_zero_preserve_md_before  ⊑  atomic_fadd_zero_preserve_md_combined := by
  unfold atomic_fadd_zero_preserve_md_before atomic_fadd_zero_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_atomic_fadd_zero_preserve_md   : atomic_fadd_zero_preserve_md_before  ⊑  atomic_fadd_zero_preserve_md_combined := by
  unfold atomic_fadd_zero_preserve_md_before atomic_fadd_zero_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_fsub_canon_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_fsub_canon_preserve_md(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, f32]

theorem inst_combine_atomic_fsub_canon_preserve_md   : atomic_fsub_canon_preserve_md_before  ⊑  atomic_fsub_canon_preserve_md_combined := by
  unfold atomic_fsub_canon_preserve_md_before atomic_fsub_canon_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_atomic_fsub_canon_preserve_md   : atomic_fsub_canon_preserve_md_before  ⊑  atomic_fsub_canon_preserve_md_combined := by
  unfold atomic_fsub_canon_preserve_md_before atomic_fsub_canon_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_fadd_canon_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_fadd_canon_preserve_md(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.atomicrmw fadd %arg0, %0 release {alignment = 4 : i64} : !llvm.ptr, f32]

theorem inst_combine_atomic_fadd_canon_preserve_md   : atomic_fadd_canon_preserve_md_before  ⊑  atomic_fadd_canon_preserve_md_combined := by
  unfold atomic_fadd_canon_preserve_md_before atomic_fadd_canon_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_atomic_fadd_canon_preserve_md   : atomic_fadd_canon_preserve_md_before  ⊑  atomic_fadd_canon_preserve_md_combined := by
  unfold atomic_fadd_canon_preserve_md_before atomic_fadd_canon_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_sub_zero_volatile_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_sub_zero_volatile_preserve_md(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.atomicrmw volatile sub %arg0, %0 acquire {alignment = 8 : i64} : !llvm.ptr, i64]

theorem inst_combine_atomic_sub_zero_volatile_preserve_md   : atomic_sub_zero_volatile_preserve_md_before  ⊑  atomic_sub_zero_volatile_preserve_md_combined := by
  unfold atomic_sub_zero_volatile_preserve_md_before atomic_sub_zero_volatile_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i64
  }]

theorem inst_combine_atomic_sub_zero_volatile_preserve_md   : atomic_sub_zero_volatile_preserve_md_before  ⊑  atomic_sub_zero_volatile_preserve_md_combined := by
  unfold atomic_sub_zero_volatile_preserve_md_before atomic_sub_zero_volatile_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_syncscope_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_syncscope_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("some_syncscope") acquire {alignment = 2 : i64} : !llvm.ptr, i16]

theorem inst_combine_atomic_syncscope_preserve_md   : atomic_syncscope_preserve_md_before  ⊑  atomic_syncscope_preserve_md_combined := by
  unfold atomic_syncscope_preserve_md_before atomic_syncscope_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i16
  }]

theorem inst_combine_atomic_syncscope_preserve_md   : atomic_syncscope_preserve_md_before  ⊑  atomic_syncscope_preserve_md_combined := by
  unfold atomic_syncscope_preserve_md_before atomic_syncscope_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_seq_cst_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_seq_cst_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _or %arg0, %0 seq_cst {alignment = 2 : i64} : !llvm.ptr, i16]

theorem inst_combine_atomic_seq_cst_preserve_md   : atomic_seq_cst_preserve_md_before  ⊑  atomic_seq_cst_preserve_md_combined := by
  unfold atomic_seq_cst_preserve_md_before atomic_seq_cst_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i16
  }]

theorem inst_combine_atomic_seq_cst_preserve_md   : atomic_seq_cst_preserve_md_before  ⊑  atomic_seq_cst_preserve_md_combined := by
  unfold atomic_seq_cst_preserve_md_before atomic_seq_cst_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_add_non_zero_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_add_non_zero_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.atomicrmw add %arg0, %0 syncscope("agent") monotonic {alignment = 2 : i64} : !llvm.ptr, i16]

theorem inst_combine_atomic_add_non_zero_preserve_md   : atomic_add_non_zero_preserve_md_before  ⊑  atomic_add_non_zero_preserve_md_combined := by
  unfold atomic_add_non_zero_preserve_md_before atomic_add_non_zero_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i16
  }]

theorem inst_combine_atomic_add_non_zero_preserve_md   : atomic_add_non_zero_preserve_md_before  ⊑  atomic_add_non_zero_preserve_md_combined := by
  unfold atomic_add_non_zero_preserve_md_before atomic_add_non_zero_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_xor_zero_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_xor_zero_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 2 : i64} : !llvm.ptr, i16]

theorem inst_combine_atomic_xor_zero_preserve_md   : atomic_xor_zero_preserve_md_before  ⊑  atomic_xor_zero_preserve_md_combined := by
  unfold atomic_xor_zero_preserve_md_before atomic_xor_zero_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i16
  }]

theorem inst_combine_atomic_xor_zero_preserve_md   : atomic_xor_zero_preserve_md_before  ⊑  atomic_xor_zero_preserve_md_combined := by
  unfold atomic_xor_zero_preserve_md_before atomic_xor_zero_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_release_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_release_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _or %arg0, %0 release {alignment = 2 : i64} : !llvm.ptr, i16]

theorem inst_combine_atomic_release_preserve_md   : atomic_release_preserve_md_before  ⊑  atomic_release_preserve_md_combined := by
  unfold atomic_release_preserve_md_before atomic_release_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i16
  }]

theorem inst_combine_atomic_release_preserve_md   : atomic_release_preserve_md_before  ⊑  atomic_release_preserve_md_combined := by
  unfold atomic_release_preserve_md_before atomic_release_preserve_md_combined
  simp_alive_peephole
  sorry
def atomic_acq_rel_preserve_md_combined := [llvmfunc|
  llvm.func @atomic_acq_rel_preserve_md(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.atomicrmw _or %arg0, %0 acq_rel {alignment = 2 : i64} : !llvm.ptr, i16]

theorem inst_combine_atomic_acq_rel_preserve_md   : atomic_acq_rel_preserve_md_before  ⊑  atomic_acq_rel_preserve_md_combined := by
  unfold atomic_acq_rel_preserve_md_before atomic_acq_rel_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i16
  }]

theorem inst_combine_atomic_acq_rel_preserve_md   : atomic_acq_rel_preserve_md_before  ⊑  atomic_acq_rel_preserve_md_combined := by
  unfold atomic_acq_rel_preserve_md_before atomic_acq_rel_preserve_md_combined
  simp_alive_peephole
  sorry
def sat_or_allones_preserve_md_combined := [llvmfunc|
  llvm.func @sat_or_allones_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_sat_or_allones_preserve_md   : sat_or_allones_preserve_md_before  ⊑  sat_or_allones_preserve_md_combined := by
  unfold sat_or_allones_preserve_md_before sat_or_allones_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_sat_or_allones_preserve_md   : sat_or_allones_preserve_md_before  ⊑  sat_or_allones_preserve_md_combined := by
  unfold sat_or_allones_preserve_md_before sat_or_allones_preserve_md_combined
  simp_alive_peephole
  sorry
def sat_and_zero_preserve_md_combined := [llvmfunc|
  llvm.func @sat_and_zero_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_sat_and_zero_preserve_md   : sat_and_zero_preserve_md_before  ⊑  sat_and_zero_preserve_md_combined := by
  unfold sat_and_zero_preserve_md_before sat_and_zero_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_sat_and_zero_preserve_md   : sat_and_zero_preserve_md_before  ⊑  sat_and_zero_preserve_md_combined := by
  unfold sat_and_zero_preserve_md_before sat_and_zero_preserve_md_combined
  simp_alive_peephole
  sorry
def sat_umin_uint_min_preserve_md_combined := [llvmfunc|
  llvm.func @sat_umin_uint_min_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_sat_umin_uint_min_preserve_md   : sat_umin_uint_min_preserve_md_before  ⊑  sat_umin_uint_min_preserve_md_combined := by
  unfold sat_umin_uint_min_preserve_md_before sat_umin_uint_min_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_sat_umin_uint_min_preserve_md   : sat_umin_uint_min_preserve_md_before  ⊑  sat_umin_uint_min_preserve_md_combined := by
  unfold sat_umin_uint_min_preserve_md_before sat_umin_uint_min_preserve_md_combined
  simp_alive_peephole
  sorry
def sat_umax_uint_max_preserve_md_combined := [llvmfunc|
  llvm.func @sat_umax_uint_max_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_sat_umax_uint_max_preserve_md   : sat_umax_uint_max_preserve_md_before  ⊑  sat_umax_uint_max_preserve_md_combined := by
  unfold sat_umax_uint_max_preserve_md_before sat_umax_uint_max_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_sat_umax_uint_max_preserve_md   : sat_umax_uint_max_preserve_md_before  ⊑  sat_umax_uint_max_preserve_md_combined := by
  unfold sat_umax_uint_max_preserve_md_before sat_umax_uint_max_preserve_md_combined
  simp_alive_peephole
  sorry
def sat_min_smin_char_preserve_md_combined := [llvmfunc|
  llvm.func @sat_min_smin_char_preserve_md(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

theorem inst_combine_sat_min_smin_char_preserve_md   : sat_min_smin_char_preserve_md_before  ⊑  sat_min_smin_char_preserve_md_combined := by
  unfold sat_min_smin_char_preserve_md_before sat_min_smin_char_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_sat_min_smin_char_preserve_md   : sat_min_smin_char_preserve_md_before  ⊑  sat_min_smin_char_preserve_md_combined := by
  unfold sat_min_smin_char_preserve_md_before sat_min_smin_char_preserve_md_combined
  simp_alive_peephole
  sorry
def sat_max_smax_char_preserve_md_combined := [llvmfunc|
  llvm.func @sat_max_smax_char_preserve_md(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") monotonic {alignment = 1 : i64} : !llvm.ptr, i8]

theorem inst_combine_sat_max_smax_char_preserve_md   : sat_max_smax_char_preserve_md_before  ⊑  sat_max_smax_char_preserve_md_combined := by
  unfold sat_max_smax_char_preserve_md_before sat_max_smax_char_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_sat_max_smax_char_preserve_md   : sat_max_smax_char_preserve_md_before  ⊑  sat_max_smax_char_preserve_md_combined := by
  unfold sat_max_smax_char_preserve_md_before sat_max_smax_char_preserve_md_combined
  simp_alive_peephole
  sorry
def sat_fadd_nan_preserve_md_combined := [llvmfunc|
  llvm.func @sat_fadd_nan_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw xchg %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, f64]

theorem inst_combine_sat_fadd_nan_preserve_md   : sat_fadd_nan_preserve_md_before  ⊑  sat_fadd_nan_preserve_md_combined := by
  unfold sat_fadd_nan_preserve_md_before sat_fadd_nan_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sat_fadd_nan_preserve_md   : sat_fadd_nan_preserve_md_before  ⊑  sat_fadd_nan_preserve_md_combined := by
  unfold sat_fadd_nan_preserve_md_before sat_fadd_nan_preserve_md_combined
  simp_alive_peephole
  sorry
def sat_fsub_nan_preserve_md_combined := [llvmfunc|
  llvm.func @sat_fsub_nan_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw xchg %arg0, %0 release {alignment = 8 : i64} : !llvm.ptr, f64]

theorem inst_combine_sat_fsub_nan_preserve_md   : sat_fsub_nan_preserve_md_before  ⊑  sat_fsub_nan_preserve_md_combined := by
  unfold sat_fsub_nan_preserve_md_before sat_fsub_nan_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sat_fsub_nan_preserve_md   : sat_fsub_nan_preserve_md_before  ⊑  sat_fsub_nan_preserve_md_combined := by
  unfold sat_fsub_nan_preserve_md_before sat_fsub_nan_preserve_md_combined
  simp_alive_peephole
  sorry
def sat_fsub_nan_unused_preserve_md_combined := [llvmfunc|
  llvm.func @sat_fsub_nan_unused_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0x7FF00000FFFFFFFF : f64) : f64
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

theorem inst_combine_sat_fsub_nan_unused_preserve_md   : sat_fsub_nan_unused_preserve_md_before  ⊑  sat_fsub_nan_unused_preserve_md_combined := by
  unfold sat_fsub_nan_unused_preserve_md_before sat_fsub_nan_unused_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_sat_fsub_nan_unused_preserve_md   : sat_fsub_nan_unused_preserve_md_before  ⊑  sat_fsub_nan_unused_preserve_md_combined := by
  unfold sat_fsub_nan_unused_preserve_md_before sat_fsub_nan_unused_preserve_md_combined
  simp_alive_peephole
  sorry
def xchg_unused_monotonic_preserve_md_combined := [llvmfunc|
  llvm.func @xchg_unused_monotonic_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_xchg_unused_monotonic_preserve_md   : xchg_unused_monotonic_preserve_md_before  ⊑  xchg_unused_monotonic_preserve_md_combined := by
  unfold xchg_unused_monotonic_preserve_md_before xchg_unused_monotonic_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_xchg_unused_monotonic_preserve_md   : xchg_unused_monotonic_preserve_md_before  ⊑  xchg_unused_monotonic_preserve_md_combined := by
  unfold xchg_unused_monotonic_preserve_md_before xchg_unused_monotonic_preserve_md_combined
  simp_alive_peephole
  sorry
def xchg_unused_release_preserve_md_combined := [llvmfunc|
  llvm.func @xchg_unused_release_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") release {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_xchg_unused_release_preserve_md   : xchg_unused_release_preserve_md_before  ⊑  xchg_unused_release_preserve_md_combined := by
  unfold xchg_unused_release_preserve_md_before xchg_unused_release_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_xchg_unused_release_preserve_md   : xchg_unused_release_preserve_md_before  ⊑  xchg_unused_release_preserve_md_combined := by
  unfold xchg_unused_release_preserve_md_before xchg_unused_release_preserve_md_combined
  simp_alive_peephole
  sorry
def xchg_unused_under_aligned_preserve_md_combined := [llvmfunc|
  llvm.func @xchg_unused_under_aligned_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") release {alignment = 1 : i64} : !llvm.ptr, i32]

theorem inst_combine_xchg_unused_under_aligned_preserve_md   : xchg_unused_under_aligned_preserve_md_before  ⊑  xchg_unused_under_aligned_preserve_md_combined := by
  unfold xchg_unused_under_aligned_preserve_md_before xchg_unused_under_aligned_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_xchg_unused_under_aligned_preserve_md   : xchg_unused_under_aligned_preserve_md_before  ⊑  xchg_unused_under_aligned_preserve_md_combined := by
  unfold xchg_unused_under_aligned_preserve_md_before xchg_unused_under_aligned_preserve_md_combined
  simp_alive_peephole
  sorry
def xchg_unused_over_aligned_preserve_md_combined := [llvmfunc|
  llvm.func @xchg_unused_over_aligned_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") release {alignment = 8 : i64} : !llvm.ptr, i32]

theorem inst_combine_xchg_unused_over_aligned_preserve_md   : xchg_unused_over_aligned_preserve_md_before  ⊑  xchg_unused_over_aligned_preserve_md_combined := by
  unfold xchg_unused_over_aligned_preserve_md_before xchg_unused_over_aligned_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_xchg_unused_over_aligned_preserve_md   : xchg_unused_over_aligned_preserve_md_before  ⊑  xchg_unused_over_aligned_preserve_md_combined := by
  unfold xchg_unused_over_aligned_preserve_md_before xchg_unused_over_aligned_preserve_md_combined
  simp_alive_peephole
  sorry
def xchg_unused_seq_cst_preserve_md_combined := [llvmfunc|
  llvm.func @xchg_unused_seq_cst_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") seq_cst {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_xchg_unused_seq_cst_preserve_md   : xchg_unused_seq_cst_preserve_md_before  ⊑  xchg_unused_seq_cst_preserve_md_combined := by
  unfold xchg_unused_seq_cst_preserve_md_before xchg_unused_seq_cst_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_xchg_unused_seq_cst_preserve_md   : xchg_unused_seq_cst_preserve_md_before  ⊑  xchg_unused_seq_cst_preserve_md_combined := by
  unfold xchg_unused_seq_cst_preserve_md_before xchg_unused_seq_cst_preserve_md_combined
  simp_alive_peephole
  sorry
def xchg_unused_volatile_preserve_md_combined := [llvmfunc|
  llvm.func @xchg_unused_volatile_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.atomicrmw volatile xchg %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_xchg_unused_volatile_preserve_md   : xchg_unused_volatile_preserve_md_before  ⊑  xchg_unused_volatile_preserve_md_combined := by
  unfold xchg_unused_volatile_preserve_md_before xchg_unused_volatile_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_xchg_unused_volatile_preserve_md   : xchg_unused_volatile_preserve_md_before  ⊑  xchg_unused_volatile_preserve_md_combined := by
  unfold xchg_unused_volatile_preserve_md_before xchg_unused_volatile_preserve_md_combined
  simp_alive_peephole
  sorry
def sat_or_allones_unused_preserve_md_combined := [llvmfunc|
  llvm.func @sat_or_allones_unused_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_sat_or_allones_unused_preserve_md   : sat_or_allones_unused_preserve_md_before  ⊑  sat_or_allones_unused_preserve_md_combined := by
  unfold sat_or_allones_unused_preserve_md_before sat_or_allones_unused_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_sat_or_allones_unused_preserve_md   : sat_or_allones_unused_preserve_md_before  ⊑  sat_or_allones_unused_preserve_md_combined := by
  unfold sat_or_allones_unused_preserve_md_before sat_or_allones_unused_preserve_md_combined
  simp_alive_peephole
  sorry
def undef_operand_unused_preserve_md_combined := [llvmfunc|
  llvm.func @undef_operand_unused_preserve_md(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_undef_operand_unused_preserve_md   : undef_operand_unused_preserve_md_before  ⊑  undef_operand_unused_preserve_md_combined := by
  unfold undef_operand_unused_preserve_md_before undef_operand_unused_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_undef_operand_unused_preserve_md   : undef_operand_unused_preserve_md_before  ⊑  undef_operand_unused_preserve_md_combined := by
  unfold undef_operand_unused_preserve_md_before undef_operand_unused_preserve_md_combined
  simp_alive_peephole
  sorry
def undef_operand_used_preserve_md_combined := [llvmfunc|
  llvm.func @undef_operand_used_preserve_md(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.atomicrmw _or %arg0, %0 syncscope("agent") monotonic {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_undef_operand_used_preserve_md   : undef_operand_used_preserve_md_before  ⊑  undef_operand_used_preserve_md_combined := by
  unfold undef_operand_used_preserve_md_before undef_operand_used_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_undef_operand_used_preserve_md   : undef_operand_used_preserve_md_before  ⊑  undef_operand_used_preserve_md_combined := by
  unfold undef_operand_used_preserve_md_before undef_operand_used_preserve_md_combined
  simp_alive_peephole
  sorry
def sat_fmax_inf_preserve_md_combined := [llvmfunc|
  llvm.func @sat_fmax_inf_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

theorem inst_combine_sat_fmax_inf_preserve_md   : sat_fmax_inf_preserve_md_before  ⊑  sat_fmax_inf_preserve_md_combined := by
  unfold sat_fmax_inf_preserve_md_before sat_fmax_inf_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sat_fmax_inf_preserve_md   : sat_fmax_inf_preserve_md_before  ⊑  sat_fmax_inf_preserve_md_combined := by
  unfold sat_fmax_inf_preserve_md_before sat_fmax_inf_preserve_md_combined
  simp_alive_peephole
  sorry
def no_sat_fmax_inf_preserve_md_combined := [llvmfunc|
  llvm.func @no_sat_fmax_inf_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.atomicrmw fmax %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

theorem inst_combine_no_sat_fmax_inf_preserve_md   : no_sat_fmax_inf_preserve_md_before  ⊑  no_sat_fmax_inf_preserve_md_combined := by
  unfold no_sat_fmax_inf_preserve_md_before no_sat_fmax_inf_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_no_sat_fmax_inf_preserve_md   : no_sat_fmax_inf_preserve_md_before  ⊑  no_sat_fmax_inf_preserve_md_combined := by
  unfold no_sat_fmax_inf_preserve_md_before no_sat_fmax_inf_preserve_md_combined
  simp_alive_peephole
  sorry
def sat_fmin_inf_preserve_md_combined := [llvmfunc|
  llvm.func @sat_fmin_inf_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = llvm.atomicrmw xchg %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

theorem inst_combine_sat_fmin_inf_preserve_md   : sat_fmin_inf_preserve_md_before  ⊑  sat_fmin_inf_preserve_md_combined := by
  unfold sat_fmin_inf_preserve_md_before sat_fmin_inf_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sat_fmin_inf_preserve_md   : sat_fmin_inf_preserve_md_before  ⊑  sat_fmin_inf_preserve_md_combined := by
  unfold sat_fmin_inf_preserve_md_before sat_fmin_inf_preserve_md_combined
  simp_alive_peephole
  sorry
def no_sat_fmin_inf_preserve_md_combined := [llvmfunc|
  llvm.func @no_sat_fmin_inf_preserve_md(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.atomicrmw fmin %arg0, %0 syncscope("agent") monotonic {alignment = 8 : i64} : !llvm.ptr, f64]

theorem inst_combine_no_sat_fmin_inf_preserve_md   : no_sat_fmin_inf_preserve_md_before  ⊑  no_sat_fmin_inf_preserve_md_combined := by
  unfold no_sat_fmin_inf_preserve_md_before no_sat_fmin_inf_preserve_md_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_no_sat_fmin_inf_preserve_md   : no_sat_fmin_inf_preserve_md_before  ⊑  no_sat_fmin_inf_preserve_md_combined := by
  unfold no_sat_fmin_inf_preserve_md_before no_sat_fmin_inf_preserve_md_combined
  simp_alive_peephole
  sorry
