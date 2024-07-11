import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  unreachable-code
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def br_true_before := [llvmfunc|
  llvm.func @br_true(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.or %arg0, %0  : i1
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%2 : i32)
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%1 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %4 : i32
  }]

def br_false_before := [llvmfunc|
  llvm.func @br_false(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i1
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%2 : i32)
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%1 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %4 : i32
  }]

def br_undef_before := [llvmfunc|
  llvm.func @br_undef(%arg0: i1) -> i32 {
    %0 = llvm.mlir.undef : i1
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i1
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%2 : i32)
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%1 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %4 : i32
  }]

def br_true_phi_with_repeated_preds_before := [llvmfunc|
  llvm.func @br_true_phi_with_repeated_preds(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.or %arg0, %0  : i1
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%3 : i32)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %2, ^bb3(%1 : i32), ^bb3(%1 : i32)
  ^bb3(%5: i32):  // 3 preds: ^bb1, ^bb2, ^bb2
    llvm.return %5 : i32
  }]

def br_true_const_phi_direct_edge_before := [llvmfunc|
  llvm.func @br_true_const_phi_direct_edge(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(2 : i32) : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%2 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

def br_true_var_phi_direct_edge_before := [llvmfunc|
  llvm.func @br_true_var_phi_direct_edge(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.or %arg0, %0  : i1
    llvm.cond_br %3, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%2 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def switch_case_before := [llvmfunc|
  llvm.func @switch_case(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.switch %1 : i32, ^bb2 [
      0: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

def switch_default_before := [llvmfunc|
  llvm.func @switch_default(%arg0: i32) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    llvm.switch %1 : i32, ^bb2 [
      0: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

def switch_undef_before := [llvmfunc|
  llvm.func @switch_undef(%arg0: i32) {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.switch %1 : i32, ^bb2 [
      0: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

def non_term_unreachable_before := [llvmfunc|
  llvm.func @non_term_unreachable() {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : !llvm.ptr
    llvm.call @dummy() : () -> ()
    llvm.call @dummy() : () -> ()
    llvm.store %0, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.call @dummy() : () -> ()
    llvm.return
  }]

def non_term_unreachable_phi_before := [llvmfunc|
  llvm.func @non_term_unreachable_phi(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.poison : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    llvm.store %1, %2 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def non_term_unreachable_following_blocks_before := [llvmfunc|
  llvm.func @non_term_unreachable_following_blocks() {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : !llvm.ptr
    llvm.call @dummy() : () -> ()
    llvm.store %0, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.call @dummy() : () -> ()
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb1, ^bb2
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  }]

def br_not_into_loop_before := [llvmfunc|
  llvm.func @br_not_into_loop(%arg0: i1) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %0  : i1
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.call @dummy() : () -> ()
    llvm.br ^bb1
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

def br_into_loop_before := [llvmfunc|
  llvm.func @br_into_loop(%arg0: i1) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %0  : i1
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.call @dummy() : () -> ()
    llvm.br ^bb1
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

def two_br_not_into_loop_before := [llvmfunc|
  llvm.func @two_br_not_into_loop(%arg0: i1) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %0  : i1
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.or %arg0, %0  : i1
    llvm.cond_br %2, ^bb3, ^bb2
  ^bb2:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb3:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

def one_br_into_loop_one_not_before := [llvmfunc|
  llvm.func @one_br_into_loop_one_not(%arg0: i1, %arg1: i1) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %0  : i1
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb2
  ^bb2:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb3:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

def two_br_not_into_loop_with_split_before := [llvmfunc|
  llvm.func @two_br_not_into_loop_with_split(%arg0: i1) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %0  : i1
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.or %arg0, %0  : i1
    llvm.cond_br %2, ^bb5, ^bb3
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb4
  ^bb3:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb2, ^bb3, ^bb4
    llvm.call @dummy() : () -> ()
    llvm.br ^bb4
  ^bb5:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

def irreducible_before := [llvmfunc|
  llvm.func @irreducible() {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.call @dummy() : () -> ()
    llvm.cond_br %1, ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

def really_unreachable_before := [llvmfunc|
  llvm.func @really_unreachable() {
    llvm.return
  }]

def really_unreachable_predecessor_before := [llvmfunc|
  llvm.func @really_unreachable_predecessor() {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

def pr64235_before := [llvmfunc|
  llvm.func @pr64235() -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    "llvm.intr.assume"(%0) : (i1) -> ()
    llvm.br ^bb3
  ^bb2:  // 2 preds: ^bb0, ^bb3
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "llvm.intr.assume"(%0) : (i1) -> ()
    llvm.br ^bb2
  }]

def test_before := [llvmfunc|
  llvm.func @test(%arg0: i1) attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.ptr
    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb5
  ^bb1:  // pred: ^bb0
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.invoke @invoke(%2) to ^bb2 unwind ^bb3 : (!llvm.ptr) -> ()
  ^bb2:  // pred: ^bb1
    llvm.invoke @invoke(%2) to ^bb5 unwind ^bb4 : (!llvm.ptr) -> ()
  ^bb3:  // pred: ^bb1
    %3 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.br ^bb5
  ^bb4:  // pred: ^bb2
    %4 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.br ^bb6
  ^bb5:  // 3 preds: ^bb0, ^bb2, ^bb3
    llvm.return
  ^bb6:  // pred: ^bb4
    llvm.return
  }]

def br_true_combined := [llvmfunc|
  llvm.func @br_true(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return %1 : i32
  }]

theorem inst_combine_br_true   : br_true_before  ⊑  br_true_combined := by
  unfold br_true_before br_true_combined
  simp_alive_peephole
  sorry
def br_false_combined := [llvmfunc|
  llvm.func @br_false(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(2 : i32) : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return %1 : i32
  }]

theorem inst_combine_br_false   : br_false_before  ⊑  br_false_combined := by
  unfold br_false_before br_false_combined
  simp_alive_peephole
  sorry
def br_undef_combined := [llvmfunc|
  llvm.func @br_undef(%arg0: i1) -> i32 {
    %0 = llvm.mlir.undef : i1
    %1 = llvm.mlir.poison : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return %1 : i32
  }]

theorem inst_combine_br_undef   : br_undef_before  ⊑  br_undef_combined := by
  unfold br_undef_before br_undef_combined
  simp_alive_peephole
  sorry
def br_true_phi_with_repeated_preds_combined := [llvmfunc|
  llvm.func @br_true_phi_with_repeated_preds(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.cond_br %1, ^bb3, ^bb3
  ^bb3:  // 3 preds: ^bb1, ^bb2, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_br_true_phi_with_repeated_preds   : br_true_phi_with_repeated_preds_before  ⊑  br_true_phi_with_repeated_preds_combined := by
  unfold br_true_phi_with_repeated_preds_before br_true_phi_with_repeated_preds_combined
  simp_alive_peephole
  sorry
def br_true_const_phi_direct_edge_combined := [llvmfunc|
  llvm.func @br_true_const_phi_direct_edge(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(2 : i32) : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_br_true_const_phi_direct_edge   : br_true_const_phi_direct_edge_before  ⊑  br_true_const_phi_direct_edge_combined := by
  unfold br_true_const_phi_direct_edge_before br_true_const_phi_direct_edge_combined
  simp_alive_peephole
  sorry
def br_true_var_phi_direct_edge_combined := [llvmfunc|
  llvm.func @br_true_var_phi_direct_edge(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(2 : i32) : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_br_true_var_phi_direct_edge   : br_true_var_phi_direct_edge_before  ⊑  br_true_var_phi_direct_edge_combined := by
  unfold br_true_var_phi_direct_edge_before br_true_var_phi_direct_edge_combined
  simp_alive_peephole
  sorry
def switch_case_combined := [llvmfunc|
  llvm.func @switch_case(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.switch %0 : i32, ^bb2 [
      0: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_switch_case   : switch_case_before  ⊑  switch_case_combined := by
  unfold switch_case_before switch_case_combined
  simp_alive_peephole
  sorry
def switch_default_combined := [llvmfunc|
  llvm.func @switch_default(%arg0: i32) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.switch %0 : i32, ^bb2 [
      0: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

theorem inst_combine_switch_default   : switch_default_before  ⊑  switch_default_combined := by
  unfold switch_default_before switch_default_combined
  simp_alive_peephole
  sorry
def switch_undef_combined := [llvmfunc|
  llvm.func @switch_undef(%arg0: i32) {
    %0 = llvm.mlir.undef : i32
    llvm.switch %0 : i32, ^bb2 [
      0: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_switch_undef   : switch_undef_before  ⊑  switch_undef_combined := by
  unfold switch_undef_before switch_undef_combined
  simp_alive_peephole
  sorry
def non_term_unreachable_combined := [llvmfunc|
  llvm.func @non_term_unreachable() {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : !llvm.ptr
    llvm.call @dummy() : () -> ()
    llvm.store %0, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_non_term_unreachable   : non_term_unreachable_before  ⊑  non_term_unreachable_combined := by
  unfold non_term_unreachable_before non_term_unreachable_combined
  simp_alive_peephole
  sorry
def non_term_unreachable_phi_combined := [llvmfunc|
  llvm.func @non_term_unreachable_phi(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %0, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_non_term_unreachable_phi   : non_term_unreachable_phi_before  ⊑  non_term_unreachable_phi_combined := by
  unfold non_term_unreachable_phi_before non_term_unreachable_phi_combined
  simp_alive_peephole
  sorry
def non_term_unreachable_following_blocks_combined := [llvmfunc|
  llvm.func @non_term_unreachable_following_blocks() {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : !llvm.ptr
    llvm.call @dummy() : () -> ()
    llvm.store %0, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb2
  }]

theorem inst_combine_non_term_unreachable_following_blocks   : non_term_unreachable_following_blocks_before  ⊑  non_term_unreachable_following_blocks_combined := by
  unfold non_term_unreachable_following_blocks_before non_term_unreachable_following_blocks_combined
  simp_alive_peephole
  sorry
def br_not_into_loop_combined := [llvmfunc|
  llvm.func @br_not_into_loop(%arg0: i1) {
    %0 = llvm.mlir.constant(true) : i1
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.br ^bb1
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

theorem inst_combine_br_not_into_loop   : br_not_into_loop_before  ⊑  br_not_into_loop_combined := by
  unfold br_not_into_loop_before br_not_into_loop_combined
  simp_alive_peephole
  sorry
def br_into_loop_combined := [llvmfunc|
  llvm.func @br_into_loop(%arg0: i1) {
    %0 = llvm.mlir.constant(true) : i1
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.call @dummy() : () -> ()
    llvm.br ^bb1
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_br_into_loop   : br_into_loop_before  ⊑  br_into_loop_combined := by
  unfold br_into_loop_before br_into_loop_combined
  simp_alive_peephole
  sorry
def two_br_not_into_loop_combined := [llvmfunc|
  llvm.func @two_br_not_into_loop(%arg0: i1) {
    %0 = llvm.mlir.constant(true) : i1
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %0, ^bb3, ^bb2
  ^bb2:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.br ^bb2
  ^bb3:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

theorem inst_combine_two_br_not_into_loop   : two_br_not_into_loop_before  ⊑  two_br_not_into_loop_combined := by
  unfold two_br_not_into_loop_before two_br_not_into_loop_combined
  simp_alive_peephole
  sorry
def one_br_into_loop_one_not_combined := [llvmfunc|
  llvm.func @one_br_into_loop_one_not(%arg0: i1, %arg1: i1) {
    %0 = llvm.mlir.constant(true) : i1
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb2
  ^bb2:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb3:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

theorem inst_combine_one_br_into_loop_one_not   : one_br_into_loop_one_not_before  ⊑  one_br_into_loop_one_not_combined := by
  unfold one_br_into_loop_one_not_before one_br_into_loop_one_not_combined
  simp_alive_peephole
  sorry
def two_br_not_into_loop_with_split_combined := [llvmfunc|
  llvm.func @two_br_not_into_loop_with_split(%arg0: i1) {
    %0 = llvm.mlir.constant(true) : i1
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %0, ^bb5, ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb2, ^bb3, ^bb4
    llvm.br ^bb4
  ^bb5:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

theorem inst_combine_two_br_not_into_loop_with_split   : two_br_not_into_loop_with_split_before  ⊑  two_br_not_into_loop_with_split_combined := by
  unfold two_br_not_into_loop_with_split_before two_br_not_into_loop_with_split_combined
  simp_alive_peephole
  sorry
def irreducible_combined := [llvmfunc|
  llvm.func @irreducible() {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.call @dummy() : () -> ()
    llvm.cond_br %1, ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

theorem inst_combine_irreducible   : irreducible_before  ⊑  irreducible_combined := by
  unfold irreducible_before irreducible_combined
  simp_alive_peephole
  sorry
def really_unreachable_combined := [llvmfunc|
  llvm.func @really_unreachable() {
    llvm.return
  }]

theorem inst_combine_really_unreachable   : really_unreachable_before  ⊑  really_unreachable_combined := by
  unfold really_unreachable_before really_unreachable_combined
  simp_alive_peephole
  sorry
def really_unreachable_predecessor_combined := [llvmfunc|
  llvm.func @really_unreachable_predecessor() {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }]

theorem inst_combine_really_unreachable_predecessor   : really_unreachable_predecessor_before  ⊑  really_unreachable_predecessor_combined := by
  unfold really_unreachable_predecessor_before really_unreachable_predecessor_combined
  simp_alive_peephole
  sorry
def pr64235_combined := [llvmfunc|
  llvm.func @pr64235() -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.poison : !llvm.ptr
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.store %1, %2 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // 2 preds: ^bb0, ^bb3
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb2
  }]

theorem inst_combine_pr64235   : pr64235_before  ⊑  pr64235_combined := by
  unfold pr64235_before pr64235_combined
  simp_alive_peephole
  sorry
def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i1) attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.ptr
    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb5
  ^bb1:  // pred: ^bb0
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.invoke @invoke(%2) to ^bb2 unwind ^bb3 : (!llvm.ptr) -> ()
  ^bb2:  // pred: ^bb1
    llvm.invoke @invoke(%2) to ^bb5 unwind ^bb4 : (!llvm.ptr) -> ()
  ^bb3:  // pred: ^bb1
    %3 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.br ^bb5
  ^bb4:  // pred: ^bb2
    %4 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.br ^bb6
  ^bb5:  // 3 preds: ^bb0, ^bb2, ^bb3
    llvm.return
  ^bb6:  // pred: ^bb4
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
