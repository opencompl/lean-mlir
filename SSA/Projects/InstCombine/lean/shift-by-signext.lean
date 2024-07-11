import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shift-by-signext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_shl_before := [llvmfunc|
  llvm.func @t0_shl(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg1 : i8 to i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def t1_lshr_before := [llvmfunc|
  llvm.func @t1_lshr(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg1 : i8 to i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def t2_ashr_before := [llvmfunc|
  llvm.func @t2_ashr(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg1 : i8 to i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def t3_vec_shl_before := [llvmfunc|
  llvm.func @t3_vec_shl(%arg0: vector<2xi32>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.sext %arg1 : vector<2xi8> to vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def t4_vec_lshr_before := [llvmfunc|
  llvm.func @t4_vec_lshr(%arg0: vector<2xi32>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.sext %arg1 : vector<2xi8> to vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def t5_vec_ashr_before := [llvmfunc|
  llvm.func @t5_vec_ashr(%arg0: vector<2xi32>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.sext %arg1 : vector<2xi8> to vector<2xi32>
    %1 = llvm.ashr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def t6_twoshifts_before := [llvmfunc|
  llvm.func @t6_twoshifts(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg1 : i8 to i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %2 : i32
  }]

def n7_fshl_before := [llvmfunc|
  llvm.func @n7_fshl(%arg0: i7, %arg1: i7, %arg2: i6) -> i7 {
    %0 = llvm.sext %arg2 : i6 to i7
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i7, i7, i7) -> i7
    llvm.return %1 : i7
  }]

def n8_fshr_before := [llvmfunc|
  llvm.func @n8_fshr(%arg0: i7, %arg1: i7, %arg2: i6) -> i7 {
    %0 = llvm.sext %arg2 : i6 to i7
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i7, i7, i7) -> i7
    llvm.return %1 : i7
  }]

def t9_fshl_before := [llvmfunc|
  llvm.func @t9_fshl(%arg0: i8, %arg1: i8, %arg2: i6) -> i8 {
    %0 = llvm.sext %arg2 : i6 to i8
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i8, i8, i8) -> i8
    llvm.return %1 : i8
  }]

def t10_fshr_before := [llvmfunc|
  llvm.func @t10_fshr(%arg0: i8, %arg1: i8, %arg2: i6) -> i8 {
    %0 = llvm.sext %arg2 : i6 to i8
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i8, i8, i8) -> i8
    llvm.return %1 : i8
  }]

def n11_extrause_before := [llvmfunc|
  llvm.func @n11_extrause(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg1 : i8 to i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def n12_twoshifts_and_extrause_before := [llvmfunc|
  llvm.func @n12_twoshifts_and_extrause(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg1 : i8 to i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.call @use32(%0) : (i32) -> ()
    llvm.return %2 : i32
  }]

def t0_shl_combined := [llvmfunc|
  llvm.func @t0_shl(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg1 : i8 to i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_t0_shl   : t0_shl_before  ⊑  t0_shl_combined := by
  unfold t0_shl_before t0_shl_combined
  simp_alive_peephole
  sorry
def t1_lshr_combined := [llvmfunc|
  llvm.func @t1_lshr(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg1 : i8 to i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_t1_lshr   : t1_lshr_before  ⊑  t1_lshr_combined := by
  unfold t1_lshr_before t1_lshr_combined
  simp_alive_peephole
  sorry
def t2_ashr_combined := [llvmfunc|
  llvm.func @t2_ashr(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg1 : i8 to i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_t2_ashr   : t2_ashr_before  ⊑  t2_ashr_combined := by
  unfold t2_ashr_before t2_ashr_combined
  simp_alive_peephole
  sorry
def t3_vec_shl_combined := [llvmfunc|
  llvm.func @t3_vec_shl(%arg0: vector<2xi32>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_t3_vec_shl   : t3_vec_shl_before  ⊑  t3_vec_shl_combined := by
  unfold t3_vec_shl_before t3_vec_shl_combined
  simp_alive_peephole
  sorry
def t4_vec_lshr_combined := [llvmfunc|
  llvm.func @t4_vec_lshr(%arg0: vector<2xi32>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_t4_vec_lshr   : t4_vec_lshr_before  ⊑  t4_vec_lshr_combined := by
  unfold t4_vec_lshr_before t4_vec_lshr_combined
  simp_alive_peephole
  sorry
def t5_vec_ashr_combined := [llvmfunc|
  llvm.func @t5_vec_ashr(%arg0: vector<2xi32>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %1 = llvm.ashr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_t5_vec_ashr   : t5_vec_ashr_before  ⊑  t5_vec_ashr_combined := by
  unfold t5_vec_ashr_before t5_vec_ashr_combined
  simp_alive_peephole
  sorry
def t6_twoshifts_combined := [llvmfunc|
  llvm.func @t6_twoshifts(%arg0: i32, %arg1: i8) -> i32 {
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    %0 = llvm.sext %arg1 : i8 to i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t6_twoshifts   : t6_twoshifts_before  ⊑  t6_twoshifts_combined := by
  unfold t6_twoshifts_before t6_twoshifts_combined
  simp_alive_peephole
  sorry
def n7_fshl_combined := [llvmfunc|
  llvm.func @n7_fshl(%arg0: i7, %arg1: i7, %arg2: i6) -> i7 {
    %0 = llvm.sext %arg2 : i6 to i7
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i7, i7, i7) -> i7
    llvm.return %1 : i7
  }]

theorem inst_combine_n7_fshl   : n7_fshl_before  ⊑  n7_fshl_combined := by
  unfold n7_fshl_before n7_fshl_combined
  simp_alive_peephole
  sorry
def n8_fshr_combined := [llvmfunc|
  llvm.func @n8_fshr(%arg0: i7, %arg1: i7, %arg2: i6) -> i7 {
    %0 = llvm.sext %arg2 : i6 to i7
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i7, i7, i7) -> i7
    llvm.return %1 : i7
  }]

theorem inst_combine_n8_fshr   : n8_fshr_before  ⊑  n8_fshr_combined := by
  unfold n8_fshr_before n8_fshr_combined
  simp_alive_peephole
  sorry
def t9_fshl_combined := [llvmfunc|
  llvm.func @t9_fshl(%arg0: i8, %arg1: i8, %arg2: i6) -> i8 {
    %0 = llvm.zext %arg2 : i6 to i8
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i8, i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t9_fshl   : t9_fshl_before  ⊑  t9_fshl_combined := by
  unfold t9_fshl_before t9_fshl_combined
  simp_alive_peephole
  sorry
def t10_fshr_combined := [llvmfunc|
  llvm.func @t10_fshr(%arg0: i8, %arg1: i8, %arg2: i6) -> i8 {
    %0 = llvm.zext %arg2 : i6 to i8
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i8, i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t10_fshr   : t10_fshr_before  ⊑  t10_fshr_combined := by
  unfold t10_fshr_before t10_fshr_combined
  simp_alive_peephole
  sorry
def n11_extrause_combined := [llvmfunc|
  llvm.func @n11_extrause(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg1 : i8 to i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_n11_extrause   : n11_extrause_before  ⊑  n11_extrause_combined := by
  unfold n11_extrause_before n11_extrause_combined
  simp_alive_peephole
  sorry
def n12_twoshifts_and_extrause_combined := [llvmfunc|
  llvm.func @n12_twoshifts_and_extrause(%arg0: i32, %arg1: i8) -> i32 {
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    %0 = llvm.sext %arg1 : i8 to i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.return %2 : i32
  }]

theorem inst_combine_n12_twoshifts_and_extrause   : n12_twoshifts_and_extrause_before  ⊑  n12_twoshifts_and_extrause_combined := by
  unfold n12_twoshifts_and_extrause_before n12_twoshifts_and_extrause_combined
  simp_alive_peephole
  sorry
