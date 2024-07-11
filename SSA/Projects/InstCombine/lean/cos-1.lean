import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cos-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def cos_negated_arg_before := [llvmfunc|
  llvm.func @cos_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @cos(%1) : (f64) -> f64
    llvm.return %2 : f64
  }]

def cos_negated_arg_tail_before := [llvmfunc|
  llvm.func @cos_negated_arg_tail(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @cos(%1) : (f64) -> f64
    llvm.return %2 : f64
  }]

def cos_negated_arg_musttail_before := [llvmfunc|
  llvm.func @cos_negated_arg_musttail(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @cos(%1) : (f64) -> f64
    llvm.return %2 : f64
  }]

def cos_unary_negated_arg_before := [llvmfunc|
  llvm.func @cos_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @cos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def cosf_negated_arg_before := [llvmfunc|
  llvm.func @cosf_negated_arg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.call @cosf(%1) : (f32) -> f32
    llvm.return %2 : f32
  }]

def cosf_unary_negated_arg_before := [llvmfunc|
  llvm.func @cosf_unary_negated_arg(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.call @cosf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

def cosf_negated_arg_FMF_before := [llvmfunc|
  llvm.func @cosf_negated_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.call @cosf(%1) {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f32) -> f32]

    llvm.return %2 : f32
  }]

def cosf_unary_negated_arg_FMF_before := [llvmfunc|
  llvm.func @cosf_unary_negated_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.call @cosf(%0) {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def cos_unary_fabs_arg_before := [llvmfunc|
  llvm.func @cos_unary_fabs_arg(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.call @cos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def cosf_unary_fabs_arg_before := [llvmfunc|
  llvm.func @cosf_unary_fabs_arg(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.call @cosf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

def cosf_unary_fabs_arg_FMF_before := [llvmfunc|
  llvm.func @cosf_unary_fabs_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.call @cosf(%0) {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def cos_copysign_arg_before := [llvmfunc|
  llvm.func @cos_copysign_arg(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.call @cos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def cosf_unary_copysign_arg_before := [llvmfunc|
  llvm.func @cosf_unary_copysign_arg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.copysign(%arg0, %0)  : (f32, f32) -> f32
    %2 = llvm.call @cosf(%1) : (f32) -> f32
    llvm.return %2 : f32
  }]

def cosf_copysign_arg_FMF_before := [llvmfunc|
  llvm.func @cosf_copysign_arg_FMF(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.call @cosf(%0) {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def sin_negated_arg_before := [llvmfunc|
  llvm.func @sin_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @sin(%1) : (f64) -> f64
    llvm.return %2 : f64
  }]

def sin_unary_negated_arg_before := [llvmfunc|
  llvm.func @sin_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def sin_unary_negated_arg_musttail_before := [llvmfunc|
  llvm.func @sin_unary_negated_arg_musttail(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def sinf_negated_arg_before := [llvmfunc|
  llvm.func @sinf_negated_arg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.call @sinf(%1) : (f32) -> f32
    llvm.return %2 : f32
  }]

def sinf_unary_negated_arg_before := [llvmfunc|
  llvm.func @sinf_unary_negated_arg(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.call @sinf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

def sinf_negated_arg_FMF_before := [llvmfunc|
  llvm.func @sinf_negated_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    %2 = llvm.call @sinf(%1) {fastmathFlags = #llvm.fastmath<nnan, afn>} : (f32) -> f32]

    llvm.return %2 : f32
  }]

def sinf_unary_negated_arg_FMF_before := [llvmfunc|
  llvm.func @sinf_unary_negated_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    %1 = llvm.call @sinf(%0) {fastmathFlags = #llvm.fastmath<nnan, afn>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def sin_negated_arg_extra_use_before := [llvmfunc|
  llvm.func @sin_negated_arg_extra_use(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @sin(%1) : (f64) -> f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

def sin_unary_negated_arg_extra_use_before := [llvmfunc|
  llvm.func @sin_unary_negated_arg_extra_use(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %1 : f64
  }]

def neg_sin_negated_arg_before := [llvmfunc|
  llvm.func @neg_sin_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @sin(%1) : (f64) -> f64
    %3 = llvm.fsub %0, %2  : f64
    llvm.return %3 : f64
  }]

def unary_neg_sin_unary_negated_arg_before := [llvmfunc|
  llvm.func @unary_neg_sin_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    %2 = llvm.fneg %1  : f64
    llvm.return %2 : f64
  }]

def neg_sin_unary_negated_arg_before := [llvmfunc|
  llvm.func @neg_sin_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @sin(%1) : (f64) -> f64
    %3 = llvm.fneg %2  : f64
    llvm.return %3 : f64
  }]

def unary_neg_sin_negated_arg_before := [llvmfunc|
  llvm.func @unary_neg_sin_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fneg %arg0  : f64
    %2 = llvm.call @sin(%1) : (f64) -> f64
    %3 = llvm.fsub %0, %2  : f64
    llvm.return %3 : f64
  }]

def tan_negated_arg_before := [llvmfunc|
  llvm.func @tan_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @tan(%1) : (f64) -> f64
    llvm.return %2 : f64
  }]

def tan_negated_arg_tail_before := [llvmfunc|
  llvm.func @tan_negated_arg_tail(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @tan(%1) : (f64) -> f64
    llvm.return %2 : f64
  }]

def tan_negated_arg_musttail_before := [llvmfunc|
  llvm.func @tan_negated_arg_musttail(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @tan(%1) : (f64) -> f64
    llvm.return %2 : f64
  }]

def tan_unary_negated_arg_before := [llvmfunc|
  llvm.func @tan_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @tan(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def tanl_negated_arg_before := [llvmfunc|
  llvm.func @tanl_negated_arg(%arg0: f128) -> f128 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f128) : f128
    %1 = llvm.fsub %0, %arg0  : f128
    %2 = llvm.call @tanl(%1) : (f128) -> f128
    llvm.return %2 : f128
  }]

def tanl_unary_negated_arg_before := [llvmfunc|
  llvm.func @tanl_unary_negated_arg(%arg0: f128) -> f128 {
    %0 = llvm.fneg %arg0  : f128
    %1 = llvm.call @tanl(%0) : (f128) -> f128
    llvm.return %1 : f128
  }]

def negated_and_shrinkable_libcall_before := [llvmfunc|
  llvm.func @negated_and_shrinkable_libcall(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fsub %0, %1  : f64
    %3 = llvm.call @cos(%2) : (f64) -> f64
    %4 = llvm.fptrunc %3 : f64 to f32
    llvm.return %4 : f32
  }]

def unary_negated_and_shrinkable_libcall_before := [llvmfunc|
  llvm.func @unary_negated_and_shrinkable_libcall(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fneg %0  : f64
    %2 = llvm.call @cos(%1) : (f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def negated_and_shrinkable_intrinsic_before := [llvmfunc|
  llvm.func @negated_and_shrinkable_intrinsic(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fsub %0, %1  : f64
    %3 = llvm.intr.cos(%2)  : (f64) -> f64
    %4 = llvm.fptrunc %3 : f64 to f32
    llvm.return %4 : f32
  }]

def unary_negated_and_shrinkable_intrinsic_before := [llvmfunc|
  llvm.func @unary_negated_and_shrinkable_intrinsic(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fneg %0  : f64
    %2 = llvm.intr.cos(%1)  : (f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def cos_negated_arg_combined := [llvmfunc|
  llvm.func @cos_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.call @cos(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_cos_negated_arg   : cos_negated_arg_before  ⊑  cos_negated_arg_combined := by
  unfold cos_negated_arg_before cos_negated_arg_combined
  simp_alive_peephole
  sorry
def cos_negated_arg_tail_combined := [llvmfunc|
  llvm.func @cos_negated_arg_tail(%arg0: f64) -> f64 {
    %0 = llvm.call @cos(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_cos_negated_arg_tail   : cos_negated_arg_tail_before  ⊑  cos_negated_arg_tail_combined := by
  unfold cos_negated_arg_tail_before cos_negated_arg_tail_combined
  simp_alive_peephole
  sorry
def cos_negated_arg_musttail_combined := [llvmfunc|
  llvm.func @cos_negated_arg_musttail(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @cos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_cos_negated_arg_musttail   : cos_negated_arg_musttail_before  ⊑  cos_negated_arg_musttail_combined := by
  unfold cos_negated_arg_musttail_before cos_negated_arg_musttail_combined
  simp_alive_peephole
  sorry
def cos_unary_negated_arg_combined := [llvmfunc|
  llvm.func @cos_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.call @cos(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_cos_unary_negated_arg   : cos_unary_negated_arg_before  ⊑  cos_unary_negated_arg_combined := by
  unfold cos_unary_negated_arg_before cos_unary_negated_arg_combined
  simp_alive_peephole
  sorry
def cosf_negated_arg_combined := [llvmfunc|
  llvm.func @cosf_negated_arg(%arg0: f32) -> f32 {
    %0 = llvm.call @cosf(%arg0) : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_cosf_negated_arg   : cosf_negated_arg_before  ⊑  cosf_negated_arg_combined := by
  unfold cosf_negated_arg_before cosf_negated_arg_combined
  simp_alive_peephole
  sorry
def cosf_unary_negated_arg_combined := [llvmfunc|
  llvm.func @cosf_unary_negated_arg(%arg0: f32) -> f32 {
    %0 = llvm.call @cosf(%arg0) : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_cosf_unary_negated_arg   : cosf_unary_negated_arg_before  ⊑  cosf_unary_negated_arg_combined := by
  unfold cosf_unary_negated_arg_before cosf_unary_negated_arg_combined
  simp_alive_peephole
  sorry
def cosf_negated_arg_FMF_combined := [llvmfunc|
  llvm.func @cosf_negated_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.call @cosf(%arg0) {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_cosf_negated_arg_FMF   : cosf_negated_arg_FMF_before  ⊑  cosf_negated_arg_FMF_combined := by
  unfold cosf_negated_arg_FMF_before cosf_negated_arg_FMF_combined
  simp_alive_peephole
  sorry
def cosf_unary_negated_arg_FMF_combined := [llvmfunc|
  llvm.func @cosf_unary_negated_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.call @cosf(%arg0) {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_cosf_unary_negated_arg_FMF   : cosf_unary_negated_arg_FMF_before  ⊑  cosf_unary_negated_arg_FMF_combined := by
  unfold cosf_unary_negated_arg_FMF_before cosf_unary_negated_arg_FMF_combined
  simp_alive_peephole
  sorry
def cos_unary_fabs_arg_combined := [llvmfunc|
  llvm.func @cos_unary_fabs_arg(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.call @cos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_cos_unary_fabs_arg   : cos_unary_fabs_arg_before  ⊑  cos_unary_fabs_arg_combined := by
  unfold cos_unary_fabs_arg_before cos_unary_fabs_arg_combined
  simp_alive_peephole
  sorry
def cosf_unary_fabs_arg_combined := [llvmfunc|
  llvm.func @cosf_unary_fabs_arg(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.call @cosf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_cosf_unary_fabs_arg   : cosf_unary_fabs_arg_before  ⊑  cosf_unary_fabs_arg_combined := by
  unfold cosf_unary_fabs_arg_before cosf_unary_fabs_arg_combined
  simp_alive_peephole
  sorry
def cosf_unary_fabs_arg_FMF_combined := [llvmfunc|
  llvm.func @cosf_unary_fabs_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.call @cosf(%0) {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_cosf_unary_fabs_arg_FMF   : cosf_unary_fabs_arg_FMF_before  ⊑  cosf_unary_fabs_arg_FMF_combined := by
  unfold cosf_unary_fabs_arg_FMF_before cosf_unary_fabs_arg_FMF_combined
  simp_alive_peephole
  sorry
def cos_copysign_arg_combined := [llvmfunc|
  llvm.func @cos_copysign_arg(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.call @cos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_cos_copysign_arg   : cos_copysign_arg_before  ⊑  cos_copysign_arg_combined := by
  unfold cos_copysign_arg_before cos_copysign_arg_combined
  simp_alive_peephole
  sorry
def cosf_unary_copysign_arg_combined := [llvmfunc|
  llvm.func @cosf_unary_copysign_arg(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.call @cosf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_cosf_unary_copysign_arg   : cosf_unary_copysign_arg_before  ⊑  cosf_unary_copysign_arg_combined := by
  unfold cosf_unary_copysign_arg_before cosf_unary_copysign_arg_combined
  simp_alive_peephole
  sorry
def cosf_copysign_arg_FMF_combined := [llvmfunc|
  llvm.func @cosf_copysign_arg_FMF(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.call @cosf(%0) {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_cosf_copysign_arg_FMF   : cosf_copysign_arg_FMF_before  ⊑  cosf_copysign_arg_FMF_combined := by
  unfold cosf_copysign_arg_FMF_before cosf_copysign_arg_FMF_combined
  simp_alive_peephole
  sorry
def sin_negated_arg_combined := [llvmfunc|
  llvm.func @sin_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.call @sin(%arg0) : (f64) -> f64
    %1 = llvm.fneg %0  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_sin_negated_arg   : sin_negated_arg_before  ⊑  sin_negated_arg_combined := by
  unfold sin_negated_arg_before sin_negated_arg_combined
  simp_alive_peephole
  sorry
def sin_unary_negated_arg_combined := [llvmfunc|
  llvm.func @sin_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.call @sin(%arg0) : (f64) -> f64
    %1 = llvm.fneg %0  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_sin_unary_negated_arg   : sin_unary_negated_arg_before  ⊑  sin_unary_negated_arg_combined := by
  unfold sin_unary_negated_arg_before sin_unary_negated_arg_combined
  simp_alive_peephole
  sorry
def sin_unary_negated_arg_musttail_combined := [llvmfunc|
  llvm.func @sin_unary_negated_arg_musttail(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_sin_unary_negated_arg_musttail   : sin_unary_negated_arg_musttail_before  ⊑  sin_unary_negated_arg_musttail_combined := by
  unfold sin_unary_negated_arg_musttail_before sin_unary_negated_arg_musttail_combined
  simp_alive_peephole
  sorry
def sinf_negated_arg_combined := [llvmfunc|
  llvm.func @sinf_negated_arg(%arg0: f32) -> f32 {
    %0 = llvm.call @sinf(%arg0) : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_sinf_negated_arg   : sinf_negated_arg_before  ⊑  sinf_negated_arg_combined := by
  unfold sinf_negated_arg_before sinf_negated_arg_combined
  simp_alive_peephole
  sorry
def sinf_unary_negated_arg_combined := [llvmfunc|
  llvm.func @sinf_unary_negated_arg(%arg0: f32) -> f32 {
    %0 = llvm.call @sinf(%arg0) : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_sinf_unary_negated_arg   : sinf_unary_negated_arg_before  ⊑  sinf_unary_negated_arg_combined := by
  unfold sinf_unary_negated_arg_before sinf_unary_negated_arg_combined
  simp_alive_peephole
  sorry
def sinf_negated_arg_FMF_combined := [llvmfunc|
  llvm.func @sinf_negated_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.call @sinf(%arg0) {fastmathFlags = #llvm.fastmath<nnan, afn>} : (f32) -> f32
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, afn>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_sinf_negated_arg_FMF   : sinf_negated_arg_FMF_before  ⊑  sinf_negated_arg_FMF_combined := by
  unfold sinf_negated_arg_FMF_before sinf_negated_arg_FMF_combined
  simp_alive_peephole
  sorry
def sinf_unary_negated_arg_FMF_combined := [llvmfunc|
  llvm.func @sinf_unary_negated_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.call @sinf(%arg0) {fastmathFlags = #llvm.fastmath<nnan, afn>} : (f32) -> f32
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, afn>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_sinf_unary_negated_arg_FMF   : sinf_unary_negated_arg_FMF_before  ⊑  sinf_unary_negated_arg_FMF_combined := by
  unfold sinf_unary_negated_arg_FMF_before sinf_unary_negated_arg_FMF_combined
  simp_alive_peephole
  sorry
def sin_negated_arg_extra_use_combined := [llvmfunc|
  llvm.func @sin_negated_arg_extra_use(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %1 : f64
  }]

theorem inst_combine_sin_negated_arg_extra_use   : sin_negated_arg_extra_use_before  ⊑  sin_negated_arg_extra_use_combined := by
  unfold sin_negated_arg_extra_use_before sin_negated_arg_extra_use_combined
  simp_alive_peephole
  sorry
def sin_unary_negated_arg_extra_use_combined := [llvmfunc|
  llvm.func @sin_unary_negated_arg_extra_use(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %1 : f64
  }]

theorem inst_combine_sin_unary_negated_arg_extra_use   : sin_unary_negated_arg_extra_use_before  ⊑  sin_unary_negated_arg_extra_use_combined := by
  unfold sin_unary_negated_arg_extra_use_before sin_unary_negated_arg_extra_use_combined
  simp_alive_peephole
  sorry
def neg_sin_negated_arg_combined := [llvmfunc|
  llvm.func @neg_sin_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.call @sin(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_neg_sin_negated_arg   : neg_sin_negated_arg_before  ⊑  neg_sin_negated_arg_combined := by
  unfold neg_sin_negated_arg_before neg_sin_negated_arg_combined
  simp_alive_peephole
  sorry
def unary_neg_sin_unary_negated_arg_combined := [llvmfunc|
  llvm.func @unary_neg_sin_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.call @sin(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_unary_neg_sin_unary_negated_arg   : unary_neg_sin_unary_negated_arg_before  ⊑  unary_neg_sin_unary_negated_arg_combined := by
  unfold unary_neg_sin_unary_negated_arg_before unary_neg_sin_unary_negated_arg_combined
  simp_alive_peephole
  sorry
def neg_sin_unary_negated_arg_combined := [llvmfunc|
  llvm.func @neg_sin_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.call @sin(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_neg_sin_unary_negated_arg   : neg_sin_unary_negated_arg_before  ⊑  neg_sin_unary_negated_arg_combined := by
  unfold neg_sin_unary_negated_arg_before neg_sin_unary_negated_arg_combined
  simp_alive_peephole
  sorry
def unary_neg_sin_negated_arg_combined := [llvmfunc|
  llvm.func @unary_neg_sin_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.call @sin(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_unary_neg_sin_negated_arg   : unary_neg_sin_negated_arg_before  ⊑  unary_neg_sin_negated_arg_combined := by
  unfold unary_neg_sin_negated_arg_before unary_neg_sin_negated_arg_combined
  simp_alive_peephole
  sorry
def tan_negated_arg_combined := [llvmfunc|
  llvm.func @tan_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.call @tan(%arg0) : (f64) -> f64
    %1 = llvm.fneg %0  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_tan_negated_arg   : tan_negated_arg_before  ⊑  tan_negated_arg_combined := by
  unfold tan_negated_arg_before tan_negated_arg_combined
  simp_alive_peephole
  sorry
def tan_negated_arg_tail_combined := [llvmfunc|
  llvm.func @tan_negated_arg_tail(%arg0: f64) -> f64 {
    %0 = llvm.call @tan(%arg0) : (f64) -> f64
    %1 = llvm.fneg %0  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_tan_negated_arg_tail   : tan_negated_arg_tail_before  ⊑  tan_negated_arg_tail_combined := by
  unfold tan_negated_arg_tail_before tan_negated_arg_tail_combined
  simp_alive_peephole
  sorry
def tan_negated_arg_musttail_combined := [llvmfunc|
  llvm.func @tan_negated_arg_musttail(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @tan(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_tan_negated_arg_musttail   : tan_negated_arg_musttail_before  ⊑  tan_negated_arg_musttail_combined := by
  unfold tan_negated_arg_musttail_before tan_negated_arg_musttail_combined
  simp_alive_peephole
  sorry
def tan_unary_negated_arg_combined := [llvmfunc|
  llvm.func @tan_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.call @tan(%arg0) : (f64) -> f64
    %1 = llvm.fneg %0  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_tan_unary_negated_arg   : tan_unary_negated_arg_before  ⊑  tan_unary_negated_arg_combined := by
  unfold tan_unary_negated_arg_before tan_unary_negated_arg_combined
  simp_alive_peephole
  sorry
def tanl_negated_arg_combined := [llvmfunc|
  llvm.func @tanl_negated_arg(%arg0: f128) -> f128 {
    %0 = llvm.call @tanl(%arg0) : (f128) -> f128
    %1 = llvm.fneg %0  : f128
    llvm.return %1 : f128
  }]

theorem inst_combine_tanl_negated_arg   : tanl_negated_arg_before  ⊑  tanl_negated_arg_combined := by
  unfold tanl_negated_arg_before tanl_negated_arg_combined
  simp_alive_peephole
  sorry
def tanl_unary_negated_arg_combined := [llvmfunc|
  llvm.func @tanl_unary_negated_arg(%arg0: f128) -> f128 {
    %0 = llvm.call @tanl(%arg0) : (f128) -> f128
    %1 = llvm.fneg %0  : f128
    llvm.return %1 : f128
  }]

theorem inst_combine_tanl_unary_negated_arg   : tanl_unary_negated_arg_before  ⊑  tanl_unary_negated_arg_combined := by
  unfold tanl_unary_negated_arg_before tanl_unary_negated_arg_combined
  simp_alive_peephole
  sorry
def negated_and_shrinkable_libcall_combined := [llvmfunc|
  llvm.func @negated_and_shrinkable_libcall(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @cos(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_negated_and_shrinkable_libcall   : negated_and_shrinkable_libcall_before  ⊑  negated_and_shrinkable_libcall_combined := by
  unfold negated_and_shrinkable_libcall_before negated_and_shrinkable_libcall_combined
  simp_alive_peephole
  sorry
def unary_negated_and_shrinkable_libcall_combined := [llvmfunc|
  llvm.func @unary_negated_and_shrinkable_libcall(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @cos(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_unary_negated_and_shrinkable_libcall   : unary_negated_and_shrinkable_libcall_before  ⊑  unary_negated_and_shrinkable_libcall_combined := by
  unfold unary_negated_and_shrinkable_libcall_before unary_negated_and_shrinkable_libcall_combined
  simp_alive_peephole
  sorry
def negated_and_shrinkable_intrinsic_combined := [llvmfunc|
  llvm.func @negated_and_shrinkable_intrinsic(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.cos(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_negated_and_shrinkable_intrinsic   : negated_and_shrinkable_intrinsic_before  ⊑  negated_and_shrinkable_intrinsic_combined := by
  unfold negated_and_shrinkable_intrinsic_before negated_and_shrinkable_intrinsic_combined
  simp_alive_peephole
  sorry
def unary_negated_and_shrinkable_intrinsic_combined := [llvmfunc|
  llvm.func @unary_negated_and_shrinkable_intrinsic(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.cos(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_unary_negated_and_shrinkable_intrinsic   : unary_negated_and_shrinkable_intrinsic_before  ⊑  unary_negated_and_shrinkable_intrinsic_combined := by
  unfold unary_negated_and_shrinkable_intrinsic_before unary_negated_and_shrinkable_intrinsic_combined
  simp_alive_peephole
  sorry
