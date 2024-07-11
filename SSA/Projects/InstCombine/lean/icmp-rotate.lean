import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-rotate
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def rol_eq_before := [llvmfunc|
  llvm.func @rol_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }]

def rol_ne_before := [llvmfunc|
  llvm.func @rol_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %0, %1 : i8
    llvm.return %2 : i1
  }]

def ror_eq_before := [llvmfunc|
  llvm.func @ror_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshr(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }]

def ror_ne_before := [llvmfunc|
  llvm.func @ror_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshr(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %0, %1 : i8
    llvm.return %2 : i1
  }]

def rol_eq_use_before := [llvmfunc|
  llvm.func @rol_eq_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }]

def rol_eq_uses_before := [llvmfunc|
  llvm.func @rol_eq_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }]

def rol_eq_vec_before := [llvmfunc|
  llvm.func @rol_eq_vec(%arg0: vector<2xi5>, %arg1: vector<2xi5>, %arg2: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %2 = llvm.icmp "eq" %0, %1 : vector<2xi5>
    llvm.return %2 : vector<2xi1>
  }]

def ror_eq_vec_before := [llvmfunc|
  llvm.func @ror_eq_vec(%arg0: vector<2xi5>, %arg1: vector<2xi5>, %arg2: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg2)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %1 = llvm.intr.fshr(%arg1, %arg1, %arg2)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %2 = llvm.icmp "eq" %0, %1 : vector<2xi5>
    llvm.return %2 : vector<2xi1>
  }]

def rol_eq_cst_before := [llvmfunc|
  llvm.func @rol_eq_cst(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def rol_ne_cst_before := [llvmfunc|
  llvm.func @rol_ne_cst(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def rol_eq_cst_use_before := [llvmfunc|
  llvm.func @rol_eq_cst_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ror_eq_cst_before := [llvmfunc|
  llvm.func @ror_eq_cst(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ror_ne_cst_before := [llvmfunc|
  llvm.func @ror_ne_cst(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def rol_eq_cst_vec_before := [llvmfunc|
  llvm.func @rol_eq_cst_vec(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(3 : i5) : i5
    %1 = llvm.mlir.constant(dense<3> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(2 : i5) : i5
    %3 = llvm.mlir.constant(dense<2> : vector<2xi5>) : vector<2xi5>
    %4 = llvm.intr.fshl(%arg0, %arg0, %1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %5 = llvm.icmp "eq" %4, %3 : vector<2xi5>
    llvm.return %5 : vector<2xi1>
  }]

def rol_eq_cst_undef_before := [llvmfunc|
  llvm.func @rol_eq_cst_undef(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(3 : i5) : i5
    %1 = llvm.mlir.constant(dense<3> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.undef : i5
    %3 = llvm.mlir.constant(2 : i5) : i5
    %4 = llvm.mlir.undef : vector<2xi5>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi5>
    %9 = llvm.intr.fshl(%arg0, %arg0, %1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %10 = llvm.icmp "eq" %9, %8 : vector<2xi5>
    llvm.return %10 : vector<2xi1>
  }]

def no_rotate_before := [llvmfunc|
  llvm.func @no_rotate(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }]

def wrong_pred_before := [llvmfunc|
  llvm.func @wrong_pred(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ult" %0, %1 : i8
    llvm.return %2 : i1
  }]

def amounts_mismatch_before := [llvmfunc|
  llvm.func @amounts_mismatch(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg3)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }]

def wrong_pred2_before := [llvmfunc|
  llvm.func @wrong_pred2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(27 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def rol_eq_combined := [llvmfunc|
  llvm.func @rol_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_rol_eq   : rol_eq_before  ⊑  rol_eq_combined := by
  unfold rol_eq_before rol_eq_combined
  simp_alive_peephole
  sorry
def rol_ne_combined := [llvmfunc|
  llvm.func @rol_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_rol_ne   : rol_ne_before  ⊑  rol_ne_combined := by
  unfold rol_ne_before rol_ne_combined
  simp_alive_peephole
  sorry
def ror_eq_combined := [llvmfunc|
  llvm.func @ror_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ror_eq   : ror_eq_before  ⊑  ror_eq_combined := by
  unfold ror_eq_before ror_eq_combined
  simp_alive_peephole
  sorry
def ror_ne_combined := [llvmfunc|
  llvm.func @ror_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ror_ne   : ror_ne_before  ⊑  ror_ne_combined := by
  unfold ror_ne_before ror_ne_combined
  simp_alive_peephole
  sorry
def rol_eq_use_combined := [llvmfunc|
  llvm.func @rol_eq_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_rol_eq_use   : rol_eq_use_before  ⊑  rol_eq_use_combined := by
  unfold rol_eq_use_before rol_eq_use_combined
  simp_alive_peephole
  sorry
def rol_eq_uses_combined := [llvmfunc|
  llvm.func @rol_eq_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_rol_eq_uses   : rol_eq_uses_before  ⊑  rol_eq_uses_combined := by
  unfold rol_eq_uses_before rol_eq_uses_combined
  simp_alive_peephole
  sorry
def rol_eq_vec_combined := [llvmfunc|
  llvm.func @rol_eq_vec(%arg0: vector<2xi5>, %arg1: vector<2xi5>, %arg2: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.icmp "eq" %arg0, %arg1 : vector<2xi5>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_rol_eq_vec   : rol_eq_vec_before  ⊑  rol_eq_vec_combined := by
  unfold rol_eq_vec_before rol_eq_vec_combined
  simp_alive_peephole
  sorry
def ror_eq_vec_combined := [llvmfunc|
  llvm.func @ror_eq_vec(%arg0: vector<2xi5>, %arg1: vector<2xi5>, %arg2: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.icmp "eq" %arg0, %arg1 : vector<2xi5>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_ror_eq_vec   : ror_eq_vec_before  ⊑  ror_eq_vec_combined := by
  unfold ror_eq_vec_before ror_eq_vec_combined
  simp_alive_peephole
  sorry
def rol_eq_cst_combined := [llvmfunc|
  llvm.func @rol_eq_cst(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_rol_eq_cst   : rol_eq_cst_before  ⊑  rol_eq_cst_combined := by
  unfold rol_eq_cst_before rol_eq_cst_combined
  simp_alive_peephole
  sorry
def rol_ne_cst_combined := [llvmfunc|
  llvm.func @rol_ne_cst(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_rol_ne_cst   : rol_ne_cst_before  ⊑  rol_ne_cst_combined := by
  unfold rol_ne_cst_before rol_ne_cst_combined
  simp_alive_peephole
  sorry
def rol_eq_cst_use_combined := [llvmfunc|
  llvm.func @rol_eq_cst_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_rol_eq_cst_use   : rol_eq_cst_use_before  ⊑  rol_eq_cst_use_combined := by
  unfold rol_eq_cst_use_before rol_eq_cst_use_combined
  simp_alive_peephole
  sorry
def ror_eq_cst_combined := [llvmfunc|
  llvm.func @ror_eq_cst(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ror_eq_cst   : ror_eq_cst_before  ⊑  ror_eq_cst_combined := by
  unfold ror_eq_cst_before ror_eq_cst_combined
  simp_alive_peephole
  sorry
def ror_ne_cst_combined := [llvmfunc|
  llvm.func @ror_ne_cst(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ror_ne_cst   : ror_ne_cst_before  ⊑  ror_ne_cst_combined := by
  unfold ror_ne_cst_before ror_ne_cst_combined
  simp_alive_peephole
  sorry
def rol_eq_cst_vec_combined := [llvmfunc|
  llvm.func @rol_eq_cst_vec(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(8 : i5) : i5
    %1 = llvm.mlir.constant(dense<8> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi5>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_rol_eq_cst_vec   : rol_eq_cst_vec_before  ⊑  rol_eq_cst_vec_combined := by
  unfold rol_eq_cst_vec_before rol_eq_cst_vec_combined
  simp_alive_peephole
  sorry
def rol_eq_cst_undef_combined := [llvmfunc|
  llvm.func @rol_eq_cst_undef(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(3 : i5) : i5
    %1 = llvm.mlir.constant(dense<3> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.undef : i5
    %3 = llvm.mlir.constant(2 : i5) : i5
    %4 = llvm.mlir.undef : vector<2xi5>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi5>
    %9 = llvm.intr.fshl(%arg0, %arg0, %1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %10 = llvm.icmp "eq" %9, %8 : vector<2xi5>
    llvm.return %10 : vector<2xi1>
  }]

theorem inst_combine_rol_eq_cst_undef   : rol_eq_cst_undef_before  ⊑  rol_eq_cst_undef_combined := by
  unfold rol_eq_cst_undef_before rol_eq_cst_undef_combined
  simp_alive_peephole
  sorry
def no_rotate_combined := [llvmfunc|
  llvm.func @no_rotate(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_no_rotate   : no_rotate_before  ⊑  no_rotate_combined := by
  unfold no_rotate_before no_rotate_combined
  simp_alive_peephole
  sorry
def wrong_pred_combined := [llvmfunc|
  llvm.func @wrong_pred(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ult" %0, %1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_wrong_pred   : wrong_pred_before  ⊑  wrong_pred_combined := by
  unfold wrong_pred_before wrong_pred_combined
  simp_alive_peephole
  sorry
def amounts_mismatch_combined := [llvmfunc|
  llvm.func @amounts_mismatch(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.sub %arg2, %arg3  : i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_amounts_mismatch   : amounts_mismatch_before  ⊑  amounts_mismatch_combined := by
  unfold amounts_mismatch_before amounts_mismatch_combined
  simp_alive_peephole
  sorry
def wrong_pred2_combined := [llvmfunc|
  llvm.func @wrong_pred2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_wrong_pred2   : wrong_pred2_before  ⊑  wrong_pred2_combined := by
  unfold wrong_pred2_before wrong_pred2_combined
  simp_alive_peephole
  sorry
