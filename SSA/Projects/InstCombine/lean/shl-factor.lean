import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shl-factor
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def add_shl_same_amount_before := [llvmfunc|
  llvm.func @add_shl_same_amount(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2  : i6
    %1 = llvm.shl %arg1, %arg2  : i6
    %2 = llvm.add %0, %1  : i6
    llvm.return %2 : i6
  }]

def add_shl_same_amount_nsw_before := [llvmfunc|
  llvm.func @add_shl_same_amount_nsw(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : vector<2xi4>
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : vector<2xi4>
    %2 = llvm.add %0, %1 overflow<nsw>  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

def add_shl_same_amount_nuw_before := [llvmfunc|
  llvm.func @add_shl_same_amount_nuw(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i64
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i64
    %2 = llvm.add %0, %1 overflow<nuw>  : i64
    llvm.return %2 : i64
  }]

def add_shl_same_amount_nsw_extra_use1_before := [llvmfunc|
  llvm.func @add_shl_same_amount_nsw_extra_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    %2 = llvm.add %0, %1 overflow<nsw>  : i8
    llvm.return %2 : i8
  }]

def add_shl_same_amount_nuw_extra_use2_before := [llvmfunc|
  llvm.func @add_shl_same_amount_nuw_extra_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %0, %1 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }]

def add_shl_same_amount_nsw_nuw_extra_use3_before := [llvmfunc|
  llvm.func @add_shl_same_amount_nsw_nuw_extra_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %0, %1 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }]

def add_shl_same_amount_partial_nsw1_before := [llvmfunc|
  llvm.func @add_shl_same_amount_partial_nsw1(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i6
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i6
    %2 = llvm.add %0, %1  : i6
    llvm.return %2 : i6
  }]

def add_shl_same_amount_partial_nsw2_before := [llvmfunc|
  llvm.func @add_shl_same_amount_partial_nsw2(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2  : i6
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i6
    %2 = llvm.add %0, %1 overflow<nsw>  : i6
    llvm.return %2 : i6
  }]

def add_shl_same_amount_partial_nuw1_before := [llvmfunc|
  llvm.func @add_shl_same_amount_partial_nuw1(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i6
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i6
    %2 = llvm.add %0, %1  : i6
    llvm.return %2 : i6
  }]

def add_shl_same_amount_partial_nuw2_before := [llvmfunc|
  llvm.func @add_shl_same_amount_partial_nuw2(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i6
    %1 = llvm.shl %arg1, %arg2  : i6
    %2 = llvm.add %0, %1 overflow<nuw>  : i6
    llvm.return %2 : i6
  }]

def sub_shl_same_amount_before := [llvmfunc|
  llvm.func @sub_shl_same_amount(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2  : i6
    %1 = llvm.shl %arg1, %arg2  : i6
    %2 = llvm.sub %0, %1  : i6
    llvm.return %2 : i6
  }]

def sub_shl_same_amount_nsw_before := [llvmfunc|
  llvm.func @sub_shl_same_amount_nsw(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : vector<2xi4>
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : vector<2xi4>
    %2 = llvm.sub %0, %1 overflow<nsw>  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

def sub_shl_same_amount_nuw_before := [llvmfunc|
  llvm.func @sub_shl_same_amount_nuw(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i64
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i64
    %2 = llvm.sub %0, %1 overflow<nuw>  : i64
    llvm.return %2 : i64
  }]

def sub_shl_same_amount_nsw_extra_use1_before := [llvmfunc|
  llvm.func @sub_shl_same_amount_nsw_extra_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    %2 = llvm.sub %0, %1 overflow<nsw>  : i8
    llvm.return %2 : i8
  }]

def sub_shl_same_amount_nuw_extra_use2_before := [llvmfunc|
  llvm.func @sub_shl_same_amount_nuw_extra_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %1 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }]

def sub_shl_same_amount_nsw_nuw_extra_use3_before := [llvmfunc|
  llvm.func @sub_shl_same_amount_nsw_nuw_extra_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %1 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }]

def sub_shl_same_amount_partial_nsw1_before := [llvmfunc|
  llvm.func @sub_shl_same_amount_partial_nsw1(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i6
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i6
    %2 = llvm.sub %0, %1  : i6
    llvm.return %2 : i6
  }]

def sub_shl_same_amount_partial_nsw2_before := [llvmfunc|
  llvm.func @sub_shl_same_amount_partial_nsw2(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2  : i6
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i6
    %2 = llvm.sub %0, %1 overflow<nsw>  : i6
    llvm.return %2 : i6
  }]

def sub_shl_same_amount_partial_nuw1_before := [llvmfunc|
  llvm.func @sub_shl_same_amount_partial_nuw1(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i6
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i6
    %2 = llvm.sub %0, %1  : i6
    llvm.return %2 : i6
  }]

def sub_shl_same_amount_partial_nuw2_before := [llvmfunc|
  llvm.func @sub_shl_same_amount_partial_nuw2(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i6
    %1 = llvm.shl %arg1, %arg2  : i6
    %2 = llvm.sub %0, %1 overflow<nuw>  : i6
    llvm.return %2 : i6
  }]

def add_shl_same_amount_combined := [llvmfunc|
  llvm.func @add_shl_same_amount(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.add %arg0, %arg1  : i6
    %1 = llvm.shl %0, %arg2  : i6
    llvm.return %1 : i6
  }]

theorem inst_combine_add_shl_same_amount   : add_shl_same_amount_before  ⊑  add_shl_same_amount_combined := by
  unfold add_shl_same_amount_before add_shl_same_amount_combined
  simp_alive_peephole
  sorry
def add_shl_same_amount_nsw_combined := [llvmfunc|
  llvm.func @add_shl_same_amount_nsw(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.add %arg0, %arg1 overflow<nsw>  : vector<2xi4>
    %1 = llvm.shl %0, %arg2 overflow<nsw>  : vector<2xi4>
    llvm.return %1 : vector<2xi4>
  }]

theorem inst_combine_add_shl_same_amount_nsw   : add_shl_same_amount_nsw_before  ⊑  add_shl_same_amount_nsw_combined := by
  unfold add_shl_same_amount_nsw_before add_shl_same_amount_nsw_combined
  simp_alive_peephole
  sorry
def add_shl_same_amount_nuw_combined := [llvmfunc|
  llvm.func @add_shl_same_amount_nuw(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.add %arg0, %arg1 overflow<nuw>  : i64
    %1 = llvm.shl %0, %arg2 overflow<nuw>  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_add_shl_same_amount_nuw   : add_shl_same_amount_nuw_before  ⊑  add_shl_same_amount_nuw_combined := by
  unfold add_shl_same_amount_nuw_before add_shl_same_amount_nuw_combined
  simp_alive_peephole
  sorry
def add_shl_same_amount_nsw_extra_use1_combined := [llvmfunc|
  llvm.func @add_shl_same_amount_nsw_extra_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.add %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.shl %1, %arg2 overflow<nsw>  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_add_shl_same_amount_nsw_extra_use1   : add_shl_same_amount_nsw_extra_use1_before  ⊑  add_shl_same_amount_nsw_extra_use1_combined := by
  unfold add_shl_same_amount_nsw_extra_use1_before add_shl_same_amount_nsw_extra_use1_combined
  simp_alive_peephole
  sorry
def add_shl_same_amount_nuw_extra_use2_combined := [llvmfunc|
  llvm.func @add_shl_same_amount_nuw_extra_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.add %arg0, %arg1 overflow<nuw>  : i8
    %2 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_add_shl_same_amount_nuw_extra_use2   : add_shl_same_amount_nuw_extra_use2_before  ⊑  add_shl_same_amount_nuw_extra_use2_combined := by
  unfold add_shl_same_amount_nuw_extra_use2_before add_shl_same_amount_nuw_extra_use2_combined
  simp_alive_peephole
  sorry
def add_shl_same_amount_nsw_nuw_extra_use3_combined := [llvmfunc|
  llvm.func @add_shl_same_amount_nsw_nuw_extra_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %0, %1 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_add_shl_same_amount_nsw_nuw_extra_use3   : add_shl_same_amount_nsw_nuw_extra_use3_before  ⊑  add_shl_same_amount_nsw_nuw_extra_use3_combined := by
  unfold add_shl_same_amount_nsw_nuw_extra_use3_before add_shl_same_amount_nsw_nuw_extra_use3_combined
  simp_alive_peephole
  sorry
def add_shl_same_amount_partial_nsw1_combined := [llvmfunc|
  llvm.func @add_shl_same_amount_partial_nsw1(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.add %arg0, %arg1  : i6
    %1 = llvm.shl %0, %arg2  : i6
    llvm.return %1 : i6
  }]

theorem inst_combine_add_shl_same_amount_partial_nsw1   : add_shl_same_amount_partial_nsw1_before  ⊑  add_shl_same_amount_partial_nsw1_combined := by
  unfold add_shl_same_amount_partial_nsw1_before add_shl_same_amount_partial_nsw1_combined
  simp_alive_peephole
  sorry
def add_shl_same_amount_partial_nsw2_combined := [llvmfunc|
  llvm.func @add_shl_same_amount_partial_nsw2(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.add %arg0, %arg1  : i6
    %1 = llvm.shl %0, %arg2  : i6
    llvm.return %1 : i6
  }]

theorem inst_combine_add_shl_same_amount_partial_nsw2   : add_shl_same_amount_partial_nsw2_before  ⊑  add_shl_same_amount_partial_nsw2_combined := by
  unfold add_shl_same_amount_partial_nsw2_before add_shl_same_amount_partial_nsw2_combined
  simp_alive_peephole
  sorry
def add_shl_same_amount_partial_nuw1_combined := [llvmfunc|
  llvm.func @add_shl_same_amount_partial_nuw1(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.add %arg0, %arg1  : i6
    %1 = llvm.shl %0, %arg2  : i6
    llvm.return %1 : i6
  }]

theorem inst_combine_add_shl_same_amount_partial_nuw1   : add_shl_same_amount_partial_nuw1_before  ⊑  add_shl_same_amount_partial_nuw1_combined := by
  unfold add_shl_same_amount_partial_nuw1_before add_shl_same_amount_partial_nuw1_combined
  simp_alive_peephole
  sorry
def add_shl_same_amount_partial_nuw2_combined := [llvmfunc|
  llvm.func @add_shl_same_amount_partial_nuw2(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.add %arg0, %arg1  : i6
    %1 = llvm.shl %0, %arg2  : i6
    llvm.return %1 : i6
  }]

theorem inst_combine_add_shl_same_amount_partial_nuw2   : add_shl_same_amount_partial_nuw2_before  ⊑  add_shl_same_amount_partial_nuw2_combined := by
  unfold add_shl_same_amount_partial_nuw2_before add_shl_same_amount_partial_nuw2_combined
  simp_alive_peephole
  sorry
def sub_shl_same_amount_combined := [llvmfunc|
  llvm.func @sub_shl_same_amount(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.sub %arg0, %arg1  : i6
    %1 = llvm.shl %0, %arg2  : i6
    llvm.return %1 : i6
  }]

theorem inst_combine_sub_shl_same_amount   : sub_shl_same_amount_before  ⊑  sub_shl_same_amount_combined := by
  unfold sub_shl_same_amount_before sub_shl_same_amount_combined
  simp_alive_peephole
  sorry
def sub_shl_same_amount_nsw_combined := [llvmfunc|
  llvm.func @sub_shl_same_amount_nsw(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi4>
    %1 = llvm.shl %0, %arg2 overflow<nsw>  : vector<2xi4>
    llvm.return %1 : vector<2xi4>
  }]

theorem inst_combine_sub_shl_same_amount_nsw   : sub_shl_same_amount_nsw_before  ⊑  sub_shl_same_amount_nsw_combined := by
  unfold sub_shl_same_amount_nsw_before sub_shl_same_amount_nsw_combined
  simp_alive_peephole
  sorry
def sub_shl_same_amount_nuw_combined := [llvmfunc|
  llvm.func @sub_shl_same_amount_nuw(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sub %arg0, %arg1 overflow<nuw>  : i64
    %1 = llvm.shl %0, %arg2 overflow<nuw>  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_sub_shl_same_amount_nuw   : sub_shl_same_amount_nuw_before  ⊑  sub_shl_same_amount_nuw_combined := by
  unfold sub_shl_same_amount_nuw_before sub_shl_same_amount_nuw_combined
  simp_alive_peephole
  sorry
def sub_shl_same_amount_nsw_extra_use1_combined := [llvmfunc|
  llvm.func @sub_shl_same_amount_nsw_extra_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.shl %1, %arg2 overflow<nsw>  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_shl_same_amount_nsw_extra_use1   : sub_shl_same_amount_nsw_extra_use1_before  ⊑  sub_shl_same_amount_nsw_extra_use1_combined := by
  unfold sub_shl_same_amount_nsw_extra_use1_before sub_shl_same_amount_nsw_extra_use1_combined
  simp_alive_peephole
  sorry
def sub_shl_same_amount_nuw_extra_use2_combined := [llvmfunc|
  llvm.func @sub_shl_same_amount_nuw_extra_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg0, %arg1 overflow<nuw>  : i8
    %2 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_shl_same_amount_nuw_extra_use2   : sub_shl_same_amount_nuw_extra_use2_before  ⊑  sub_shl_same_amount_nuw_extra_use2_combined := by
  unfold sub_shl_same_amount_nuw_extra_use2_before sub_shl_same_amount_nuw_extra_use2_combined
  simp_alive_peephole
  sorry
def sub_shl_same_amount_nsw_nuw_extra_use3_combined := [llvmfunc|
  llvm.func @sub_shl_same_amount_nsw_nuw_extra_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %1 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_shl_same_amount_nsw_nuw_extra_use3   : sub_shl_same_amount_nsw_nuw_extra_use3_before  ⊑  sub_shl_same_amount_nsw_nuw_extra_use3_combined := by
  unfold sub_shl_same_amount_nsw_nuw_extra_use3_before sub_shl_same_amount_nsw_nuw_extra_use3_combined
  simp_alive_peephole
  sorry
def sub_shl_same_amount_partial_nsw1_combined := [llvmfunc|
  llvm.func @sub_shl_same_amount_partial_nsw1(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.sub %arg0, %arg1  : i6
    %1 = llvm.shl %0, %arg2  : i6
    llvm.return %1 : i6
  }]

theorem inst_combine_sub_shl_same_amount_partial_nsw1   : sub_shl_same_amount_partial_nsw1_before  ⊑  sub_shl_same_amount_partial_nsw1_combined := by
  unfold sub_shl_same_amount_partial_nsw1_before sub_shl_same_amount_partial_nsw1_combined
  simp_alive_peephole
  sorry
def sub_shl_same_amount_partial_nsw2_combined := [llvmfunc|
  llvm.func @sub_shl_same_amount_partial_nsw2(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.sub %arg0, %arg1  : i6
    %1 = llvm.shl %0, %arg2  : i6
    llvm.return %1 : i6
  }]

theorem inst_combine_sub_shl_same_amount_partial_nsw2   : sub_shl_same_amount_partial_nsw2_before  ⊑  sub_shl_same_amount_partial_nsw2_combined := by
  unfold sub_shl_same_amount_partial_nsw2_before sub_shl_same_amount_partial_nsw2_combined
  simp_alive_peephole
  sorry
def sub_shl_same_amount_partial_nuw1_combined := [llvmfunc|
  llvm.func @sub_shl_same_amount_partial_nuw1(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.sub %arg0, %arg1  : i6
    %1 = llvm.shl %0, %arg2  : i6
    llvm.return %1 : i6
  }]

theorem inst_combine_sub_shl_same_amount_partial_nuw1   : sub_shl_same_amount_partial_nuw1_before  ⊑  sub_shl_same_amount_partial_nuw1_combined := by
  unfold sub_shl_same_amount_partial_nuw1_before sub_shl_same_amount_partial_nuw1_combined
  simp_alive_peephole
  sorry
def sub_shl_same_amount_partial_nuw2_combined := [llvmfunc|
  llvm.func @sub_shl_same_amount_partial_nuw2(%arg0: i6, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.sub %arg0, %arg1  : i6
    %1 = llvm.shl %0, %arg2  : i6
    llvm.return %1 : i6
  }]

theorem inst_combine_sub_shl_same_amount_partial_nuw2   : sub_shl_same_amount_partial_nuw2_before  ⊑  sub_shl_same_amount_partial_nuw2_combined := by
  unfold sub_shl_same_amount_partial_nuw2_before sub_shl_same_amount_partial_nuw2_combined
  simp_alive_peephole
  sorry
