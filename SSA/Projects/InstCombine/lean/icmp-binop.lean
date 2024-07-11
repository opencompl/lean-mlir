import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-binop
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def mul_unkV_oddC_eq_before := [llvmfunc|
  llvm.func @mul_unkV_oddC_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def mul_unkV_oddC_eq_nonzero_before := [llvmfunc|
  llvm.func @mul_unkV_oddC_eq_nonzero(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def mul_unkV_oddC_ne_vec_before := [llvmfunc|
  llvm.func @mul_unkV_oddC_ne_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mul %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }]

def mul_assumeoddV_asumeoddV_eq_before := [llvmfunc|
  llvm.func @mul_assumeoddV_asumeoddV_eq(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.icmp "ne" %2, %1 : i16
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.and %arg1, %0  : i16
    %5 = llvm.icmp "ne" %4, %1 : i16
    "llvm.intr.assume"(%5) : (i1) -> ()
    %6 = llvm.mul %arg0, %arg1  : i16
    %7 = llvm.icmp "ne" %6, %1 : i16
    llvm.return %7 : i1
  }]

def mul_unkV_oddC_sge_before := [llvmfunc|
  llvm.func @mul_unkV_oddC_sge(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def mul_reused_unkV_oddC_ne_before := [llvmfunc|
  llvm.func @mul_reused_unkV_oddC_ne(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mul %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.call @use64(%2) : (i64) -> ()
    llvm.return %3 : i1
  }]

def mul_assumeoddV_unkV_eq_before := [llvmfunc|
  llvm.func @mul_assumeoddV_unkV_eq(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.icmp "eq" %2, %0 : i16
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.mul %arg0, %arg1  : i16
    %5 = llvm.icmp "eq" %4, %1 : i16
    llvm.return %5 : i1
  }]

def mul_reusedassumeoddV_unkV_ne_before := [llvmfunc|
  llvm.func @mul_reusedassumeoddV_unkV_ne(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.mul %arg0, %arg1  : i64
    %5 = llvm.icmp "ne" %4, %1 : i64
    llvm.call @use64(%4) : (i64) -> ()
    llvm.return %5 : i1
  }]

def mul_setoddV_unkV_ne_before := [llvmfunc|
  llvm.func @mul_setoddV_unkV_ne(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.or %arg0, %0  : vector<2xi32>
    %4 = llvm.mul %3, %arg1  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }]

def mul_broddV_unkV_eq_before := [llvmfunc|
  llvm.func @mul_broddV_unkV_eq(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.addressof @use64 : !llvm.ptr
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.and %arg1, %0  : i16
    %5 = llvm.icmp "eq" %4, %0 : i16
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.mul %arg0, %arg1  : i16
    %7 = llvm.icmp "eq" %6, %3 : i16
    llvm.return %7 : i1
  ^bb2:  // pred: ^bb0
    llvm.call %1(%arg0) : !llvm.ptr, (i16) -> ()
    llvm.return %2 : i1
  }]

def mul_unkV_evenC_ne_before := [llvmfunc|
  llvm.func @mul_unkV_evenC_ne(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mul %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.return %3 : i1
  }]

def mul_assumenzV_asumenzV_eq_before := [llvmfunc|
  llvm.func @mul_assumenzV_asumenzV_eq(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg1, %0 : i64
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.mul %arg0, %arg1  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }]

def mul_assumenzV_unkV_nsw_ne_before := [llvmfunc|
  llvm.func @mul_assumenzV_unkV_nsw_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.mul %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

def mul_selectnzV_unkV_nsw_ne_before := [llvmfunc|
  llvm.func @mul_selectnzV_unkV_nsw_ne(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.select %2, %4, %1 : i1, i1
    llvm.return %5 : i1
  }]

def mul_unkV_unkV_nsw_nuw_ne_before := [llvmfunc|
  llvm.func @mul_unkV_unkV_nsw_nuw_ne(%arg0: vector<2xi16>, %arg1: vector<2xi16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mul %arg0, %arg1 overflow<nsw, nuw>  : vector<2xi16>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi16>
    llvm.return %3 : vector<2xi1>
  }]

def mul_setnzV_unkV_nuw_eq_before := [llvmfunc|
  llvm.func @mul_setnzV_unkV_nuw_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.mul %2, %arg1 overflow<nuw>  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def mul_brnzV_unkV_nuw_eq_before := [llvmfunc|
  llvm.func @mul_brnzV_unkV_nuw_eq(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg1, %0 : i64
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.mul %arg0, %arg1 overflow<nuw>  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  ^bb2:  // pred: ^bb0
    llvm.call @use64(%arg0) : (i64) -> ()
    llvm.return %1 : i1
  }]

def mul_unkV_oddC_eq_combined := [llvmfunc|
  llvm.func @mul_unkV_oddC_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_mul_unkV_oddC_eq   : mul_unkV_oddC_eq_before  ⊑  mul_unkV_oddC_eq_combined := by
  unfold mul_unkV_oddC_eq_before mul_unkV_oddC_eq_combined
  simp_alive_peephole
  sorry
def mul_unkV_oddC_eq_nonzero_combined := [llvmfunc|
  llvm.func @mul_unkV_oddC_eq_nonzero(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_mul_unkV_oddC_eq_nonzero   : mul_unkV_oddC_eq_nonzero_before  ⊑  mul_unkV_oddC_eq_nonzero_combined := by
  unfold mul_unkV_oddC_eq_nonzero_before mul_unkV_oddC_eq_nonzero_combined
  simp_alive_peephole
  sorry
def mul_unkV_oddC_ne_vec_combined := [llvmfunc|
  llvm.func @mul_unkV_oddC_ne_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_mul_unkV_oddC_ne_vec   : mul_unkV_oddC_ne_vec_before  ⊑  mul_unkV_oddC_ne_vec_combined := by
  unfold mul_unkV_oddC_ne_vec_before mul_unkV_oddC_ne_vec_combined
  simp_alive_peephole
  sorry
def mul_assumeoddV_asumeoddV_eq_combined := [llvmfunc|
  llvm.func @mul_assumeoddV_asumeoddV_eq(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg0, %0  : i16
    %4 = llvm.icmp "ne" %3, %1 : i16
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg1, %0  : i16
    %6 = llvm.icmp "ne" %5, %1 : i16
    "llvm.intr.assume"(%6) : (i1) -> ()
    llvm.return %2 : i1
  }]

theorem inst_combine_mul_assumeoddV_asumeoddV_eq   : mul_assumeoddV_asumeoddV_eq_before  ⊑  mul_assumeoddV_asumeoddV_eq_combined := by
  unfold mul_assumeoddV_asumeoddV_eq_before mul_assumeoddV_asumeoddV_eq_combined
  simp_alive_peephole
  sorry
def mul_unkV_oddC_sge_combined := [llvmfunc|
  llvm.func @mul_unkV_oddC_sge(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_mul_unkV_oddC_sge   : mul_unkV_oddC_sge_before  ⊑  mul_unkV_oddC_sge_combined := by
  unfold mul_unkV_oddC_sge_before mul_unkV_oddC_sge_combined
  simp_alive_peephole
  sorry
def mul_reused_unkV_oddC_ne_combined := [llvmfunc|
  llvm.func @mul_reused_unkV_oddC_ne(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mul %arg0, %0  : i64
    %3 = llvm.icmp "ne" %arg0, %1 : i64
    llvm.call @use64(%2) : (i64) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_mul_reused_unkV_oddC_ne   : mul_reused_unkV_oddC_ne_before  ⊑  mul_reused_unkV_oddC_ne_combined := by
  unfold mul_reused_unkV_oddC_ne_before mul_reused_unkV_oddC_ne_combined
  simp_alive_peephole
  sorry
def mul_assumeoddV_unkV_eq_combined := [llvmfunc|
  llvm.func @mul_assumeoddV_unkV_eq(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.icmp "ne" %2, %1 : i16
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %arg0, %1 : i16
    llvm.return %4 : i1
  }]

theorem inst_combine_mul_assumeoddV_unkV_eq   : mul_assumeoddV_unkV_eq_before  ⊑  mul_assumeoddV_unkV_eq_combined := by
  unfold mul_assumeoddV_unkV_eq_before mul_assumeoddV_unkV_eq_combined
  simp_alive_peephole
  sorry
def mul_reusedassumeoddV_unkV_ne_combined := [llvmfunc|
  llvm.func @mul_reusedassumeoddV_unkV_ne(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.mul %arg0, %arg1  : i64
    %5 = llvm.icmp "ne" %arg1, %1 : i64
    llvm.call @use64(%4) : (i64) -> ()
    llvm.return %5 : i1
  }]

theorem inst_combine_mul_reusedassumeoddV_unkV_ne   : mul_reusedassumeoddV_unkV_ne_before  ⊑  mul_reusedassumeoddV_unkV_ne_combined := by
  unfold mul_reusedassumeoddV_unkV_ne_before mul_reusedassumeoddV_unkV_ne_combined
  simp_alive_peephole
  sorry
def mul_setoddV_unkV_ne_combined := [llvmfunc|
  llvm.func @mul_setoddV_unkV_ne(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ne" %arg1, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_mul_setoddV_unkV_ne   : mul_setoddV_unkV_ne_before  ⊑  mul_setoddV_unkV_ne_combined := by
  unfold mul_setoddV_unkV_ne_before mul_setoddV_unkV_ne_combined
  simp_alive_peephole
  sorry
def mul_broddV_unkV_eq_combined := [llvmfunc|
  llvm.func @mul_broddV_unkV_eq(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.addressof @use64 : !llvm.ptr
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg1, %0  : i16
    %5 = llvm.icmp "eq" %4, %1 : i16
    llvm.cond_br %5, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %6 = llvm.icmp "eq" %arg0, %1 : i16
    llvm.return %6 : i1
  ^bb2:  // pred: ^bb0
    llvm.call %2(%arg0) : !llvm.ptr, (i16) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_mul_broddV_unkV_eq   : mul_broddV_unkV_eq_before  ⊑  mul_broddV_unkV_eq_combined := by
  unfold mul_broddV_unkV_eq_before mul_broddV_unkV_eq_combined
  simp_alive_peephole
  sorry
def mul_unkV_evenC_ne_combined := [llvmfunc|
  llvm.func @mul_unkV_evenC_ne(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4611686018427387903 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_mul_unkV_evenC_ne   : mul_unkV_evenC_ne_before  ⊑  mul_unkV_evenC_ne_combined := by
  unfold mul_unkV_evenC_ne_before mul_unkV_evenC_ne_combined
  simp_alive_peephole
  sorry
def mul_assumenzV_asumenzV_eq_combined := [llvmfunc|
  llvm.func @mul_assumenzV_asumenzV_eq(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg1, %0 : i64
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.mul %arg0, %arg1  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_mul_assumenzV_asumenzV_eq   : mul_assumenzV_asumenzV_eq_before  ⊑  mul_assumenzV_asumenzV_eq_combined := by
  unfold mul_assumenzV_asumenzV_eq_before mul_assumenzV_asumenzV_eq_combined
  simp_alive_peephole
  sorry
def mul_assumenzV_unkV_nsw_ne_combined := [llvmfunc|
  llvm.func @mul_assumenzV_unkV_nsw_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_mul_assumenzV_unkV_nsw_ne   : mul_assumenzV_unkV_nsw_ne_before  ⊑  mul_assumenzV_unkV_nsw_ne_combined := by
  unfold mul_assumenzV_unkV_nsw_ne_before mul_assumenzV_unkV_nsw_ne_combined
  simp_alive_peephole
  sorry
def mul_selectnzV_unkV_nsw_ne_combined := [llvmfunc|
  llvm.func @mul_selectnzV_unkV_nsw_ne(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.select %2, %4, %1 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_mul_selectnzV_unkV_nsw_ne   : mul_selectnzV_unkV_nsw_ne_before  ⊑  mul_selectnzV_unkV_nsw_ne_combined := by
  unfold mul_selectnzV_unkV_nsw_ne_before mul_selectnzV_unkV_nsw_ne_combined
  simp_alive_peephole
  sorry
def mul_unkV_unkV_nsw_nuw_ne_combined := [llvmfunc|
  llvm.func @mul_unkV_unkV_nsw_nuw_ne(%arg0: vector<2xi16>, %arg1: vector<2xi16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mul %arg0, %arg1 overflow<nsw, nuw>  : vector<2xi16>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi16>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_mul_unkV_unkV_nsw_nuw_ne   : mul_unkV_unkV_nsw_nuw_ne_before  ⊑  mul_unkV_unkV_nsw_nuw_ne_combined := by
  unfold mul_unkV_unkV_nsw_nuw_ne_before mul_unkV_unkV_nsw_nuw_ne_combined
  simp_alive_peephole
  sorry
def mul_setnzV_unkV_nuw_eq_combined := [llvmfunc|
  llvm.func @mul_setnzV_unkV_nuw_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg1, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_mul_setnzV_unkV_nuw_eq   : mul_setnzV_unkV_nuw_eq_before  ⊑  mul_setnzV_unkV_nuw_eq_combined := by
  unfold mul_setnzV_unkV_nuw_eq_before mul_setnzV_unkV_nuw_eq_combined
  simp_alive_peephole
  sorry
def mul_brnzV_unkV_nuw_eq_combined := [llvmfunc|
  llvm.func @mul_brnzV_unkV_nuw_eq(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg1, %0 : i64
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    llvm.call @use64(%arg0) : (i64) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_mul_brnzV_unkV_nuw_eq   : mul_brnzV_unkV_nuw_eq_before  ⊑  mul_brnzV_unkV_nuw_eq_combined := by
  unfold mul_brnzV_unkV_nuw_eq_before mul_brnzV_unkV_nuw_eq_combined
  simp_alive_peephole
  sorry
