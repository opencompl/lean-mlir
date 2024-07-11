import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cttz-abs
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def cttz_abs_before := [llvmfunc|
  llvm.func @cttz_abs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %4 : i32
  }]

def cttz_abs_vec_before := [llvmfunc|
  llvm.func @cttz_abs_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "slt" %arg0, %1 : vector<2xi64>
    %3 = llvm.sub %1, %arg0  : vector<2xi64>
    %4 = llvm.select %2, %3, %arg0 : vector<2xi1>, vector<2xi64>
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>]

    llvm.return %5 : vector<2xi64>
  }]

def cttz_abs2_before := [llvmfunc|
  llvm.func @cttz_abs2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use_cond(%1) : (i1) -> ()
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %4 : i32
  }]

def cttz_abs3_before := [llvmfunc|
  llvm.func @cttz_abs3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use_cond(%2) : (i1) -> ()
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %5 : i32
  }]

def cttz_abs4_before := [llvmfunc|
  llvm.func @cttz_abs4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %5 : i32
  }]

def cttz_nabs_before := [llvmfunc|
  llvm.func @cttz_nabs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %4 : i32
  }]

def cttz_nabs_vec_before := [llvmfunc|
  llvm.func @cttz_nabs_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "slt" %arg0, %1 : vector<2xi64>
    %3 = llvm.sub %1, %arg0  : vector<2xi64>
    %4 = llvm.select %2, %arg0, %3 : vector<2xi1>, vector<2xi64>
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>]

    llvm.return %5 : vector<2xi64>
  }]

def cttz_abs_64_before := [llvmfunc|
  llvm.func @cttz_abs_64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sub %0, %arg0  : i64
    %3 = llvm.select %1, %2, %arg0 : i1, i64
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = false}> : (i64) -> i64]

    llvm.return %4 : i64
  }]

def cttz_abs_multiuse_before := [llvmfunc|
  llvm.func @cttz_abs_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    llvm.call @use_abs(%4) : (i32) -> ()
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %5 : i32
  }]

def cttz_nabs_multiuse_before := [llvmfunc|
  llvm.func @cttz_nabs_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    llvm.call @use_abs(%4) : (i32) -> ()
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %5 : i32
  }]

def no_cttz_abs_before := [llvmfunc|
  llvm.func @no_cttz_abs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %5 : i32
  }]

def no_cttz_abs2_before := [llvmfunc|
  llvm.func @no_cttz_abs2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %5 : i32
  }]

def no_cttz_abs3_before := [llvmfunc|
  llvm.func @no_cttz_abs3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use_cond(%2) : (i1) -> ()
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %5 : i32
  }]

def no_cttz_abs_vec_before := [llvmfunc|
  llvm.func @no_cttz_abs_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi64>
    %3 = llvm.sub %1, %arg0  : vector<2xi64>
    %4 = llvm.select %2, %3, %arg0 : vector<2xi1>, vector<2xi64>
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>]

    llvm.return %5 : vector<2xi64>
  }]

def no_cttz_nabs_vec_before := [llvmfunc|
  llvm.func @no_cttz_nabs_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi64>
    %3 = llvm.sub %1, %arg0  : vector<2xi64>
    %4 = llvm.select %2, %arg0, %3 : vector<2xi1>, vector<2xi64>
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>]

    llvm.return %5 : vector<2xi64>
  }]

def cttz_abs_intrin_before := [llvmfunc|
  llvm.func @cttz_abs_intrin(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %1 : i32
  }]

def cttz_nabs_intrin_before := [llvmfunc|
  llvm.func @cttz_nabs_intrin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

    %2 = llvm.sub %0, %1  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def cttz_abs_combined := [llvmfunc|
  llvm.func @cttz_abs(%arg0: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

theorem inst_combine_cttz_abs   : cttz_abs_before  ⊑  cttz_abs_combined := by
  unfold cttz_abs_before cttz_abs_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_cttz_abs   : cttz_abs_before  ⊑  cttz_abs_combined := by
  unfold cttz_abs_before cttz_abs_combined
  simp_alive_peephole
  sorry
def cttz_abs_vec_combined := [llvmfunc|
  llvm.func @cttz_abs_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>]

theorem inst_combine_cttz_abs_vec   : cttz_abs_vec_before  ⊑  cttz_abs_vec_combined := by
  unfold cttz_abs_vec_before cttz_abs_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_cttz_abs_vec   : cttz_abs_vec_before  ⊑  cttz_abs_vec_combined := by
  unfold cttz_abs_vec_before cttz_abs_vec_combined
  simp_alive_peephole
  sorry
def cttz_abs2_combined := [llvmfunc|
  llvm.func @cttz_abs2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use_cond(%1) : (i1) -> ()
    %2 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

theorem inst_combine_cttz_abs2   : cttz_abs2_before  ⊑  cttz_abs2_combined := by
  unfold cttz_abs2_before cttz_abs2_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_cttz_abs2   : cttz_abs2_before  ⊑  cttz_abs2_combined := by
  unfold cttz_abs2_before cttz_abs2_combined
  simp_alive_peephole
  sorry
def cttz_abs3_combined := [llvmfunc|
  llvm.func @cttz_abs3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use_cond(%1) : (i1) -> ()
    %2 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

theorem inst_combine_cttz_abs3   : cttz_abs3_before  ⊑  cttz_abs3_combined := by
  unfold cttz_abs3_before cttz_abs3_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_cttz_abs3   : cttz_abs3_before  ⊑  cttz_abs3_combined := by
  unfold cttz_abs3_before cttz_abs3_combined
  simp_alive_peephole
  sorry
def cttz_abs4_combined := [llvmfunc|
  llvm.func @cttz_abs4(%arg0: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

theorem inst_combine_cttz_abs4   : cttz_abs4_before  ⊑  cttz_abs4_combined := by
  unfold cttz_abs4_before cttz_abs4_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_cttz_abs4   : cttz_abs4_before  ⊑  cttz_abs4_combined := by
  unfold cttz_abs4_before cttz_abs4_combined
  simp_alive_peephole
  sorry
def cttz_nabs_combined := [llvmfunc|
  llvm.func @cttz_nabs(%arg0: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_cttz_nabs   : cttz_nabs_before  ⊑  cttz_nabs_combined := by
  unfold cttz_nabs_before cttz_nabs_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_cttz_nabs   : cttz_nabs_before  ⊑  cttz_nabs_combined := by
  unfold cttz_nabs_before cttz_nabs_combined
  simp_alive_peephole
  sorry
def cttz_nabs_vec_combined := [llvmfunc|
  llvm.func @cttz_nabs_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>]

theorem inst_combine_cttz_nabs_vec   : cttz_nabs_vec_before  ⊑  cttz_nabs_vec_combined := by
  unfold cttz_nabs_vec_before cttz_nabs_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_cttz_nabs_vec   : cttz_nabs_vec_before  ⊑  cttz_nabs_vec_combined := by
  unfold cttz_nabs_vec_before cttz_nabs_vec_combined
  simp_alive_peephole
  sorry
def cttz_abs_64_combined := [llvmfunc|
  llvm.func @cttz_abs_64(%arg0: i64) -> i64 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64]

theorem inst_combine_cttz_abs_64   : cttz_abs_64_before  ⊑  cttz_abs_64_combined := by
  unfold cttz_abs_64_before cttz_abs_64_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i64
  }]

theorem inst_combine_cttz_abs_64   : cttz_abs_64_before  ⊑  cttz_abs_64_combined := by
  unfold cttz_abs_64_before cttz_abs_64_combined
  simp_alive_peephole
  sorry
def cttz_abs_multiuse_combined := [llvmfunc|
  llvm.func @cttz_abs_multiuse(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_cttz_abs_multiuse   : cttz_abs_multiuse_before  ⊑  cttz_abs_multiuse_combined := by
  unfold cttz_abs_multiuse_before cttz_abs_multiuse_combined
  simp_alive_peephole
  sorry
    llvm.call @use_abs(%0) : (i32) -> ()
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

theorem inst_combine_cttz_abs_multiuse   : cttz_abs_multiuse_before  ⊑  cttz_abs_multiuse_combined := by
  unfold cttz_abs_multiuse_before cttz_abs_multiuse_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_cttz_abs_multiuse   : cttz_abs_multiuse_before  ⊑  cttz_abs_multiuse_combined := by
  unfold cttz_abs_multiuse_before cttz_abs_multiuse_combined
  simp_alive_peephole
  sorry
def cttz_nabs_multiuse_combined := [llvmfunc|
  llvm.func @cttz_nabs_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_cttz_nabs_multiuse   : cttz_nabs_multiuse_before  ⊑  cttz_nabs_multiuse_combined := by
  unfold cttz_nabs_multiuse_before cttz_nabs_multiuse_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.call @use_abs(%2) : (i32) -> ()
    %3 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

theorem inst_combine_cttz_nabs_multiuse   : cttz_nabs_multiuse_before  ⊑  cttz_nabs_multiuse_combined := by
  unfold cttz_nabs_multiuse_before cttz_nabs_multiuse_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i32
  }]

theorem inst_combine_cttz_nabs_multiuse   : cttz_nabs_multiuse_before  ⊑  cttz_nabs_multiuse_combined := by
  unfold cttz_nabs_multiuse_before cttz_nabs_multiuse_combined
  simp_alive_peephole
  sorry
def no_cttz_abs_combined := [llvmfunc|
  llvm.func @no_cttz_abs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32]

theorem inst_combine_no_cttz_abs   : no_cttz_abs_before  ⊑  no_cttz_abs_combined := by
  unfold no_cttz_abs_before no_cttz_abs_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i32
  }]

theorem inst_combine_no_cttz_abs   : no_cttz_abs_before  ⊑  no_cttz_abs_combined := by
  unfold no_cttz_abs_before no_cttz_abs_combined
  simp_alive_peephole
  sorry
def no_cttz_abs2_combined := [llvmfunc|
  llvm.func @no_cttz_abs2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32]

theorem inst_combine_no_cttz_abs2   : no_cttz_abs2_before  ⊑  no_cttz_abs2_combined := by
  unfold no_cttz_abs2_before no_cttz_abs2_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i32
  }]

theorem inst_combine_no_cttz_abs2   : no_cttz_abs2_before  ⊑  no_cttz_abs2_combined := by
  unfold no_cttz_abs2_before no_cttz_abs2_combined
  simp_alive_peephole
  sorry
def no_cttz_abs3_combined := [llvmfunc|
  llvm.func @no_cttz_abs3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use_cond(%2) : (i1) -> ()
    %3 = llvm.sub %1, %arg0  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = true}> : (i32) -> i32]

theorem inst_combine_no_cttz_abs3   : no_cttz_abs3_before  ⊑  no_cttz_abs3_combined := by
  unfold no_cttz_abs3_before no_cttz_abs3_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i32
  }]

theorem inst_combine_no_cttz_abs3   : no_cttz_abs3_before  ⊑  no_cttz_abs3_combined := by
  unfold no_cttz_abs3_before no_cttz_abs3_combined
  simp_alive_peephole
  sorry
def no_cttz_abs_vec_combined := [llvmfunc|
  llvm.func @no_cttz_abs_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi64>
    %3 = llvm.sub %1, %arg0  : vector<2xi64>
    %4 = llvm.select %2, %3, %arg0 : vector<2xi1>, vector<2xi64>
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>]

theorem inst_combine_no_cttz_abs_vec   : no_cttz_abs_vec_before  ⊑  no_cttz_abs_vec_combined := by
  unfold no_cttz_abs_vec_before no_cttz_abs_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : vector<2xi64>
  }]

theorem inst_combine_no_cttz_abs_vec   : no_cttz_abs_vec_before  ⊑  no_cttz_abs_vec_combined := by
  unfold no_cttz_abs_vec_before no_cttz_abs_vec_combined
  simp_alive_peephole
  sorry
def no_cttz_nabs_vec_combined := [llvmfunc|
  llvm.func @no_cttz_nabs_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi64>
    %3 = llvm.sub %1, %arg0  : vector<2xi64>
    %4 = llvm.select %2, %arg0, %3 : vector<2xi1>, vector<2xi64>
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>]

theorem inst_combine_no_cttz_nabs_vec   : no_cttz_nabs_vec_before  ⊑  no_cttz_nabs_vec_combined := by
  unfold no_cttz_nabs_vec_before no_cttz_nabs_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : vector<2xi64>
  }]

theorem inst_combine_no_cttz_nabs_vec   : no_cttz_nabs_vec_before  ⊑  no_cttz_nabs_vec_combined := by
  unfold no_cttz_nabs_vec_before no_cttz_nabs_vec_combined
  simp_alive_peephole
  sorry
def cttz_abs_intrin_combined := [llvmfunc|
  llvm.func @cttz_abs_intrin(%arg0: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_cttz_abs_intrin   : cttz_abs_intrin_before  ⊑  cttz_abs_intrin_combined := by
  unfold cttz_abs_intrin_before cttz_abs_intrin_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_cttz_abs_intrin   : cttz_abs_intrin_before  ⊑  cttz_abs_intrin_combined := by
  unfold cttz_abs_intrin_before cttz_abs_intrin_combined
  simp_alive_peephole
  sorry
def cttz_nabs_intrin_combined := [llvmfunc|
  llvm.func @cttz_nabs_intrin(%arg0: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_cttz_nabs_intrin   : cttz_nabs_intrin_before  ⊑  cttz_nabs_intrin_combined := by
  unfold cttz_nabs_intrin_before cttz_nabs_intrin_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_cttz_nabs_intrin   : cttz_nabs_intrin_before  ⊑  cttz_nabs_intrin_combined := by
  unfold cttz_nabs_intrin_before cttz_nabs_intrin_combined
  simp_alive_peephole
  sorry
