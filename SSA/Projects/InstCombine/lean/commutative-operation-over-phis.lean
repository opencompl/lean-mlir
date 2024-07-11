import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  commutative-operation-over-phis
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_phi_mul_before := [llvmfunc|
  llvm.func @fold_phi_mul(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.mul %0, %1  : i8
    llvm.return %2 : i8
  }]

def fold_phi_mul_three_before := [llvmfunc|
  llvm.func @fold_phi_mul_three(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb3(%arg2, %arg3 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.cond_br %arg1, ^bb2, ^bb3(%arg3, %arg2 : i8, i8)
  ^bb2:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%arg2, %arg3 : i8, i8)
  ^bb3(%0: i8, %1: i8):  // 3 preds: ^bb0, ^bb1, ^bb2
    %2 = llvm.mul %0, %1  : i8
    llvm.return %2 : i8
  }]

def fold_phi_mul_three_notopt_before := [llvmfunc|
  llvm.func @fold_phi_mul_three_notopt(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb3(%arg2, %arg3 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.cond_br %arg1, ^bb2, ^bb3(%arg3, %arg2 : i8, i8)
  ^bb2:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%arg2, %arg2 : i8, i8)
  ^bb3(%0: i8, %1: i8):  // 3 preds: ^bb0, ^bb1, ^bb2
    %2 = llvm.mul %0, %1  : i8
    llvm.return %2 : i8
  }]

def fold_phi_mul_nsw_nuw_before := [llvmfunc|
  llvm.func @fold_phi_mul_nsw_nuw(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.mul %0, %1 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }]

def fold_phi_mul_fix_vec_before := [llvmfunc|
  llvm.func @fold_phi_mul_fix_vec(%arg0: i1, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : vector<2xi8>, vector<2xi8>)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : vector<2xi8>, vector<2xi8>)
  ^bb2(%0: vector<2xi8>, %1: vector<2xi8>):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.mul %0, %1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def fold_phi_mul_scale_vec_before := [llvmfunc|
  llvm.func @fold_phi_mul_scale_vec(%arg0: i1, %arg1: !llvm.vec<? x 2 x  i8>, %arg2: !llvm.vec<? x 2 x  i8>) -> !llvm.vec<? x 2 x  i8> {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : !llvm.vec<? x 2 x  i8>, !llvm.vec<? x 2 x  i8>)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : !llvm.vec<? x 2 x  i8>, !llvm.vec<? x 2 x  i8>)
  ^bb2(%0: !llvm.vec<? x 2 x  i8>, %1: !llvm.vec<? x 2 x  i8>):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.mul %0, %1  : !llvm.vec<? x 2 x  i8>
    llvm.return %2 : !llvm.vec<? x 2 x  i8>
  }]

def fold_phi_mul_commute_before := [llvmfunc|
  llvm.func @fold_phi_mul_commute(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.mul %0, %1  : i8
    llvm.return %2 : i8
  }]

def fold_phi_mul_notopt_before := [llvmfunc|
  llvm.func @fold_phi_mul_notopt(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg3 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.mul %0, %1  : i8
    llvm.return %2 : i8
  }]

def fold_phi_sub_before := [llvmfunc|
  llvm.func @fold_phi_sub(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

def fold_phi_add_before := [llvmfunc|
  llvm.func @fold_phi_add(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.add %0, %1  : i8
    llvm.return %2 : i8
  }]

def fold_phi_and_before := [llvmfunc|
  llvm.func @fold_phi_and(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.and %0, %1  : i8
    llvm.return %2 : i8
  }]

def fold_phi_or_before := [llvmfunc|
  llvm.func @fold_phi_or(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.or %0, %1  : i8
    llvm.return %2 : i8
  }]

def fold_phi_xor_before := [llvmfunc|
  llvm.func @fold_phi_xor(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.xor %0, %1  : i8
    llvm.return %2 : i8
  }]

def fold_phi_fadd_before := [llvmfunc|
  llvm.func @fold_phi_fadd(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.fadd %0, %1  : f32
    llvm.return %2 : f32
  }]

def fold_phi_fadd_nnan_before := [llvmfunc|
  llvm.func @fold_phi_fadd_nnan(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.return %2 : f32
  }]

def fold_phi_fmul_before := [llvmfunc|
  llvm.func @fold_phi_fmul(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.fmul %0, %1  : f32
    llvm.return %2 : f32
  }]

def fold_phi_smax_before := [llvmfunc|
  llvm.func @fold_phi_smax(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i32, i32)
  ^bb2(%0: i32, %1: i32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.smax(%0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

def fold_phi_smin_before := [llvmfunc|
  llvm.func @fold_phi_smin(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i32, i32)
  ^bb2(%0: i32, %1: i32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.smin(%0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

def fold_phi_umax_before := [llvmfunc|
  llvm.func @fold_phi_umax(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i32, i32)
  ^bb2(%0: i32, %1: i32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.umax(%0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

def fold_phi_umin_before := [llvmfunc|
  llvm.func @fold_phi_umin(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i32, i32)
  ^bb2(%0: i32, %1: i32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.umin(%0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

def fold_phi_maxnum_before := [llvmfunc|
  llvm.func @fold_phi_maxnum(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.maxnum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

def fold_phi_pow_before := [llvmfunc|
  llvm.func @fold_phi_pow(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.pow(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

def fold_phi_minnum_before := [llvmfunc|
  llvm.func @fold_phi_minnum(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.minnum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

def fold_phi_maximum_before := [llvmfunc|
  llvm.func @fold_phi_maximum(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

def fold_phi_minimum_before := [llvmfunc|
  llvm.func @fold_phi_minimum(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.minimum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

def fold_phi_mul_combined := [llvmfunc|
  llvm.func @fold_phi_mul(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.mul %arg1, %arg2  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_fold_phi_mul   : fold_phi_mul_before  ⊑  fold_phi_mul_combined := by
  unfold fold_phi_mul_before fold_phi_mul_combined
  simp_alive_peephole
  sorry
def fold_phi_mul_three_combined := [llvmfunc|
  llvm.func @fold_phi_mul_three(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    %0 = llvm.mul %arg2, %arg3  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_fold_phi_mul_three   : fold_phi_mul_three_before  ⊑  fold_phi_mul_three_combined := by
  unfold fold_phi_mul_three_before fold_phi_mul_three_combined
  simp_alive_peephole
  sorry
def fold_phi_mul_three_notopt_combined := [llvmfunc|
  llvm.func @fold_phi_mul_three_notopt(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb3(%arg2, %arg3 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.cond_br %arg1, ^bb2, ^bb3(%arg3, %arg2 : i8, i8)
  ^bb2:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%arg2, %arg2 : i8, i8)
  ^bb3(%0: i8, %1: i8):  // 3 preds: ^bb0, ^bb1, ^bb2
    %2 = llvm.mul %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_fold_phi_mul_three_notopt   : fold_phi_mul_three_notopt_before  ⊑  fold_phi_mul_three_notopt_combined := by
  unfold fold_phi_mul_three_notopt_before fold_phi_mul_three_notopt_combined
  simp_alive_peephole
  sorry
def fold_phi_mul_nsw_nuw_combined := [llvmfunc|
  llvm.func @fold_phi_mul_nsw_nuw(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.mul %arg1, %arg2 overflow<nsw, nuw>  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_fold_phi_mul_nsw_nuw   : fold_phi_mul_nsw_nuw_before  ⊑  fold_phi_mul_nsw_nuw_combined := by
  unfold fold_phi_mul_nsw_nuw_before fold_phi_mul_nsw_nuw_combined
  simp_alive_peephole
  sorry
def fold_phi_mul_fix_vec_combined := [llvmfunc|
  llvm.func @fold_phi_mul_fix_vec(%arg0: i1, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.mul %arg1, %arg2  : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_fold_phi_mul_fix_vec   : fold_phi_mul_fix_vec_before  ⊑  fold_phi_mul_fix_vec_combined := by
  unfold fold_phi_mul_fix_vec_before fold_phi_mul_fix_vec_combined
  simp_alive_peephole
  sorry
def fold_phi_mul_scale_vec_combined := [llvmfunc|
  llvm.func @fold_phi_mul_scale_vec(%arg0: i1, %arg1: !llvm.vec<? x 2 x  i8>, %arg2: !llvm.vec<? x 2 x  i8>) -> !llvm.vec<? x 2 x  i8> {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.mul %arg1, %arg2  : !llvm.vec<? x 2 x  i8>
    llvm.return %0 : !llvm.vec<? x 2 x  i8>
  }]

theorem inst_combine_fold_phi_mul_scale_vec   : fold_phi_mul_scale_vec_before  ⊑  fold_phi_mul_scale_vec_combined := by
  unfold fold_phi_mul_scale_vec_before fold_phi_mul_scale_vec_combined
  simp_alive_peephole
  sorry
def fold_phi_mul_commute_combined := [llvmfunc|
  llvm.func @fold_phi_mul_commute(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.mul %arg1, %arg2  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_fold_phi_mul_commute   : fold_phi_mul_commute_before  ⊑  fold_phi_mul_commute_combined := by
  unfold fold_phi_mul_commute_before fold_phi_mul_commute_combined
  simp_alive_peephole
  sorry
def fold_phi_mul_notopt_combined := [llvmfunc|
  llvm.func @fold_phi_mul_notopt(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg3 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.mul %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_fold_phi_mul_notopt   : fold_phi_mul_notopt_before  ⊑  fold_phi_mul_notopt_combined := by
  unfold fold_phi_mul_notopt_before fold_phi_mul_notopt_combined
  simp_alive_peephole
  sorry
def fold_phi_sub_combined := [llvmfunc|
  llvm.func @fold_phi_sub(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_fold_phi_sub   : fold_phi_sub_before  ⊑  fold_phi_sub_combined := by
  unfold fold_phi_sub_before fold_phi_sub_combined
  simp_alive_peephole
  sorry
def fold_phi_add_combined := [llvmfunc|
  llvm.func @fold_phi_add(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.add %arg1, %arg2  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_fold_phi_add   : fold_phi_add_before  ⊑  fold_phi_add_combined := by
  unfold fold_phi_add_before fold_phi_add_combined
  simp_alive_peephole
  sorry
def fold_phi_and_combined := [llvmfunc|
  llvm.func @fold_phi_and(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.and %arg1, %arg2  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_fold_phi_and   : fold_phi_and_before  ⊑  fold_phi_and_combined := by
  unfold fold_phi_and_before fold_phi_and_combined
  simp_alive_peephole
  sorry
def fold_phi_or_combined := [llvmfunc|
  llvm.func @fold_phi_or(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.or %arg1, %arg2  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_fold_phi_or   : fold_phi_or_before  ⊑  fold_phi_or_combined := by
  unfold fold_phi_or_before fold_phi_or_combined
  simp_alive_peephole
  sorry
def fold_phi_xor_combined := [llvmfunc|
  llvm.func @fold_phi_xor(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.xor %arg1, %arg2  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_fold_phi_xor   : fold_phi_xor_before  ⊑  fold_phi_xor_combined := by
  unfold fold_phi_xor_before fold_phi_xor_combined
  simp_alive_peephole
  sorry
def fold_phi_fadd_combined := [llvmfunc|
  llvm.func @fold_phi_fadd(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.fadd %arg1, %arg2  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fold_phi_fadd   : fold_phi_fadd_before  ⊑  fold_phi_fadd_combined := by
  unfold fold_phi_fadd_before fold_phi_fadd_combined
  simp_alive_peephole
  sorry
def fold_phi_fadd_nnan_combined := [llvmfunc|
  llvm.func @fold_phi_fadd_nnan(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_fold_phi_fadd_nnan   : fold_phi_fadd_nnan_before  ⊑  fold_phi_fadd_nnan_combined := by
  unfold fold_phi_fadd_nnan_before fold_phi_fadd_nnan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f32
  }]

theorem inst_combine_fold_phi_fadd_nnan   : fold_phi_fadd_nnan_before  ⊑  fold_phi_fadd_nnan_combined := by
  unfold fold_phi_fadd_nnan_before fold_phi_fadd_nnan_combined
  simp_alive_peephole
  sorry
def fold_phi_fmul_combined := [llvmfunc|
  llvm.func @fold_phi_fmul(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.fmul %arg1, %arg2  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fold_phi_fmul   : fold_phi_fmul_before  ⊑  fold_phi_fmul_combined := by
  unfold fold_phi_fmul_before fold_phi_fmul_combined
  simp_alive_peephole
  sorry
def fold_phi_smax_combined := [llvmfunc|
  llvm.func @fold_phi_smax(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.intr.smax(%arg1, %arg2)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fold_phi_smax   : fold_phi_smax_before  ⊑  fold_phi_smax_combined := by
  unfold fold_phi_smax_before fold_phi_smax_combined
  simp_alive_peephole
  sorry
def fold_phi_smin_combined := [llvmfunc|
  llvm.func @fold_phi_smin(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.intr.smin(%arg1, %arg2)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fold_phi_smin   : fold_phi_smin_before  ⊑  fold_phi_smin_combined := by
  unfold fold_phi_smin_before fold_phi_smin_combined
  simp_alive_peephole
  sorry
def fold_phi_umax_combined := [llvmfunc|
  llvm.func @fold_phi_umax(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.intr.umax(%arg1, %arg2)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fold_phi_umax   : fold_phi_umax_before  ⊑  fold_phi_umax_combined := by
  unfold fold_phi_umax_before fold_phi_umax_combined
  simp_alive_peephole
  sorry
def fold_phi_umin_combined := [llvmfunc|
  llvm.func @fold_phi_umin(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.intr.umin(%arg1, %arg2)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fold_phi_umin   : fold_phi_umin_before  ⊑  fold_phi_umin_combined := by
  unfold fold_phi_umin_before fold_phi_umin_combined
  simp_alive_peephole
  sorry
def fold_phi_maxnum_combined := [llvmfunc|
  llvm.func @fold_phi_maxnum(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.intr.maxnum(%arg1, %arg2)  : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fold_phi_maxnum   : fold_phi_maxnum_before  ⊑  fold_phi_maxnum_combined := by
  unfold fold_phi_maxnum_before fold_phi_maxnum_combined
  simp_alive_peephole
  sorry
def fold_phi_pow_combined := [llvmfunc|
  llvm.func @fold_phi_pow(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.pow(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fold_phi_pow   : fold_phi_pow_before  ⊑  fold_phi_pow_combined := by
  unfold fold_phi_pow_before fold_phi_pow_combined
  simp_alive_peephole
  sorry
def fold_phi_minnum_combined := [llvmfunc|
  llvm.func @fold_phi_minnum(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.intr.minnum(%arg1, %arg2)  : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fold_phi_minnum   : fold_phi_minnum_before  ⊑  fold_phi_minnum_combined := by
  unfold fold_phi_minnum_before fold_phi_minnum_combined
  simp_alive_peephole
  sorry
def fold_phi_maximum_combined := [llvmfunc|
  llvm.func @fold_phi_maximum(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.intr.maximum(%arg1, %arg2)  : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fold_phi_maximum   : fold_phi_maximum_before  ⊑  fold_phi_maximum_combined := by
  unfold fold_phi_maximum_before fold_phi_maximum_combined
  simp_alive_peephole
  sorry
def fold_phi_minimum_combined := [llvmfunc|
  llvm.func @fold_phi_minimum(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.intr.minimum(%arg1, %arg2)  : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fold_phi_minimum   : fold_phi_minimum_before  ⊑  fold_phi_minimum_combined := by
  unfold fold_phi_minimum_before fold_phi_minimum_combined
  simp_alive_peephole
  sorry
