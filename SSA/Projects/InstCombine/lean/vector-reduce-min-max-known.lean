import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vector-reduce-min-max-known
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def vec_reduce_umax_non_zero_before := [llvmfunc|
  llvm.func @vec_reduce_umax_non_zero(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[0, 1, 0, 0]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def vec_reduce_umax_non_zero_fail_before := [llvmfunc|
  llvm.func @vec_reduce_umax_non_zero_fail(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def vec_reduce_umin_non_zero_before := [llvmfunc|
  llvm.func @vec_reduce_umin_non_zero(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def vec_reduce_umin_non_zero_fail_before := [llvmfunc|
  llvm.func @vec_reduce_umin_non_zero_fail(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[0, 1, 1, 1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def vec_reduce_smax_non_zero0_before := [llvmfunc|
  llvm.func @vec_reduce_smax_non_zero0(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def vec_reduce_smax_non_zero1_before := [llvmfunc|
  llvm.func @vec_reduce_smax_non_zero1(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[127, -1, -1, -1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[1, 0, 0, 0]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.and %arg0, %0  : vector<4xi8>
    %4 = llvm.or %3, %1  : vector<4xi8>
    %5 = "llvm.intr.vector.reduce.smax"(%4) : (vector<4xi8>) -> i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }]

def vec_reduce_smax_non_zero_fail_before := [llvmfunc|
  llvm.func @vec_reduce_smax_non_zero_fail(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[127, -1, -1, -1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[1, 0, 0, 0]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.and %arg0, %0  : vector<4xi8>
    %4 = llvm.add %3, %1 overflow<nuw>  : vector<4xi8>
    %5 = "llvm.intr.vector.reduce.smax"(%4) : (vector<4xi8>) -> i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }]

def vec_reduce_smin_non_zero0_before := [llvmfunc|
  llvm.func @vec_reduce_smin_non_zero0(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def vec_reduce_smin_non_zero1_before := [llvmfunc|
  llvm.func @vec_reduce_smin_non_zero1(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[0, 0, 0, -128]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def vec_reduce_smin_non_zero_fail_before := [llvmfunc|
  llvm.func @vec_reduce_smin_non_zero_fail(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[0, 0, 0, -128]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[0, 0, 0, 1]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.or %arg0, %0  : vector<4xi8>
    %4 = llvm.add %3, %1  : vector<4xi8>
    %5 = "llvm.intr.vector.reduce.smin"(%4) : (vector<4xi8>) -> i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }]

def vec_reduce_umax_known0_before := [llvmfunc|
  llvm.func @vec_reduce_umax_known0(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def vec_reduce_umax_known1_before := [llvmfunc|
  llvm.func @vec_reduce_umax_known1(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[1, 1, 1, -128]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def vec_reduce_umax_known_fail0_before := [llvmfunc|
  llvm.func @vec_reduce_umax_known_fail0(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[1, 1, 1, -128]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def vec_reduce_umax_known_fail1_before := [llvmfunc|
  llvm.func @vec_reduce_umax_known_fail1(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def vec_reduce_umin_known0_before := [llvmfunc|
  llvm.func @vec_reduce_umin_known0(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def vec_reduce_umin_known1_before := [llvmfunc|
  llvm.func @vec_reduce_umin_known1(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[127, -1, -1, -1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.and %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def vec_reduce_umin_known_fail0_before := [llvmfunc|
  llvm.func @vec_reduce_umin_known_fail0(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[127, -1, -1, -1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[1, 0, 0, 0]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.and %arg0, %0  : vector<4xi8>
    %4 = llvm.or %arg0, %1  : vector<4xi8>
    %5 = "llvm.intr.vector.reduce.umin"(%4) : (vector<4xi8>) -> i8
    %6 = llvm.and %5, %2  : i8
    llvm.return %6 : i8
  }]

def vec_reduce_umin_known_fail1_before := [llvmfunc|
  llvm.func @vec_reduce_umin_known_fail1(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def vec_reduce_smax_known_before := [llvmfunc|
  llvm.func @vec_reduce_smax_known(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[4, 4, 4, 5]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def vec_reduce_smax_known_fail_before := [llvmfunc|
  llvm.func @vec_reduce_smax_known_fail(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[4, 4, 8, 5]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def vec_reduce_smin_known_before := [llvmfunc|
  llvm.func @vec_reduce_smin_known(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[8, 24, 56, 9]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def vec_reduce_smin_known_fail_before := [llvmfunc|
  llvm.func @vec_reduce_smin_known_fail(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[8, 23, 56, 9]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def vec_reduce_umax_non_zero_combined := [llvmfunc|
  llvm.func @vec_reduce_umax_non_zero(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[0, 1, 0, 0]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_vec_reduce_umax_non_zero   : vec_reduce_umax_non_zero_before  ⊑  vec_reduce_umax_non_zero_combined := by
  unfold vec_reduce_umax_non_zero_before vec_reduce_umax_non_zero_combined
  simp_alive_peephole
  sorry
def vec_reduce_umax_non_zero_fail_combined := [llvmfunc|
  llvm.func @vec_reduce_umax_non_zero_fail(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_vec_reduce_umax_non_zero_fail   : vec_reduce_umax_non_zero_fail_before  ⊑  vec_reduce_umax_non_zero_fail_combined := by
  unfold vec_reduce_umax_non_zero_fail_before vec_reduce_umax_non_zero_fail_combined
  simp_alive_peephole
  sorry
def vec_reduce_umin_non_zero_combined := [llvmfunc|
  llvm.func @vec_reduce_umin_non_zero(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_vec_reduce_umin_non_zero   : vec_reduce_umin_non_zero_before  ⊑  vec_reduce_umin_non_zero_combined := by
  unfold vec_reduce_umin_non_zero_before vec_reduce_umin_non_zero_combined
  simp_alive_peephole
  sorry
def vec_reduce_umin_non_zero_fail_combined := [llvmfunc|
  llvm.func @vec_reduce_umin_non_zero_fail(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[0, 1, 1, 1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_vec_reduce_umin_non_zero_fail   : vec_reduce_umin_non_zero_fail_before  ⊑  vec_reduce_umin_non_zero_fail_combined := by
  unfold vec_reduce_umin_non_zero_fail_before vec_reduce_umin_non_zero_fail_combined
  simp_alive_peephole
  sorry
def vec_reduce_smax_non_zero0_combined := [llvmfunc|
  llvm.func @vec_reduce_smax_non_zero0(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_vec_reduce_smax_non_zero0   : vec_reduce_smax_non_zero0_before  ⊑  vec_reduce_smax_non_zero0_combined := by
  unfold vec_reduce_smax_non_zero0_before vec_reduce_smax_non_zero0_combined
  simp_alive_peephole
  sorry
def vec_reduce_smax_non_zero1_combined := [llvmfunc|
  llvm.func @vec_reduce_smax_non_zero1(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[127, -1, -1, -1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[1, 0, 0, 0]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.and %arg0, %0  : vector<4xi8>
    %4 = llvm.or %3, %1  : vector<4xi8>
    %5 = "llvm.intr.vector.reduce.smax"(%4) : (vector<4xi8>) -> i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_vec_reduce_smax_non_zero1   : vec_reduce_smax_non_zero1_before  ⊑  vec_reduce_smax_non_zero1_combined := by
  unfold vec_reduce_smax_non_zero1_before vec_reduce_smax_non_zero1_combined
  simp_alive_peephole
  sorry
def vec_reduce_smax_non_zero_fail_combined := [llvmfunc|
  llvm.func @vec_reduce_smax_non_zero_fail(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[127, -1, -1, -1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[1, 0, 0, 0]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.and %arg0, %0  : vector<4xi8>
    %4 = llvm.add %3, %1 overflow<nuw>  : vector<4xi8>
    %5 = "llvm.intr.vector.reduce.smax"(%4) : (vector<4xi8>) -> i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_vec_reduce_smax_non_zero_fail   : vec_reduce_smax_non_zero_fail_before  ⊑  vec_reduce_smax_non_zero_fail_combined := by
  unfold vec_reduce_smax_non_zero_fail_before vec_reduce_smax_non_zero_fail_combined
  simp_alive_peephole
  sorry
def vec_reduce_smin_non_zero0_combined := [llvmfunc|
  llvm.func @vec_reduce_smin_non_zero0(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_vec_reduce_smin_non_zero0   : vec_reduce_smin_non_zero0_before  ⊑  vec_reduce_smin_non_zero0_combined := by
  unfold vec_reduce_smin_non_zero0_before vec_reduce_smin_non_zero0_combined
  simp_alive_peephole
  sorry
def vec_reduce_smin_non_zero1_combined := [llvmfunc|
  llvm.func @vec_reduce_smin_non_zero1(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[0, 0, 0, -128]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_vec_reduce_smin_non_zero1   : vec_reduce_smin_non_zero1_before  ⊑  vec_reduce_smin_non_zero1_combined := by
  unfold vec_reduce_smin_non_zero1_before vec_reduce_smin_non_zero1_combined
  simp_alive_peephole
  sorry
def vec_reduce_smin_non_zero_fail_combined := [llvmfunc|
  llvm.func @vec_reduce_smin_non_zero_fail(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[0, 0, 0, -128]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[0, 0, 0, 1]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.or %arg0, %0  : vector<4xi8>
    %4 = llvm.add %3, %1  : vector<4xi8>
    %5 = "llvm.intr.vector.reduce.smin"(%4) : (vector<4xi8>) -> i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_vec_reduce_smin_non_zero_fail   : vec_reduce_smin_non_zero_fail_before  ⊑  vec_reduce_smin_non_zero_fail_combined := by
  unfold vec_reduce_smin_non_zero_fail_before vec_reduce_smin_non_zero_fail_combined
  simp_alive_peephole
  sorry
def vec_reduce_umax_known0_combined := [llvmfunc|
  llvm.func @vec_reduce_umax_known0(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_vec_reduce_umax_known0   : vec_reduce_umax_known0_before  ⊑  vec_reduce_umax_known0_combined := by
  unfold vec_reduce_umax_known0_before vec_reduce_umax_known0_combined
  simp_alive_peephole
  sorry
def vec_reduce_umax_known1_combined := [llvmfunc|
  llvm.func @vec_reduce_umax_known1(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[1, 1, 1, -128]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_vec_reduce_umax_known1   : vec_reduce_umax_known1_before  ⊑  vec_reduce_umax_known1_combined := by
  unfold vec_reduce_umax_known1_before vec_reduce_umax_known1_combined
  simp_alive_peephole
  sorry
def vec_reduce_umax_known_fail0_combined := [llvmfunc|
  llvm.func @vec_reduce_umax_known_fail0(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[1, 1, 1, -128]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_vec_reduce_umax_known_fail0   : vec_reduce_umax_known_fail0_before  ⊑  vec_reduce_umax_known_fail0_combined := by
  unfold vec_reduce_umax_known_fail0_before vec_reduce_umax_known_fail0_combined
  simp_alive_peephole
  sorry
def vec_reduce_umax_known_fail1_combined := [llvmfunc|
  llvm.func @vec_reduce_umax_known_fail1(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_vec_reduce_umax_known_fail1   : vec_reduce_umax_known_fail1_before  ⊑  vec_reduce_umax_known_fail1_combined := by
  unfold vec_reduce_umax_known_fail1_before vec_reduce_umax_known_fail1_combined
  simp_alive_peephole
  sorry
def vec_reduce_umin_known0_combined := [llvmfunc|
  llvm.func @vec_reduce_umin_known0(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_vec_reduce_umin_known0   : vec_reduce_umin_known0_before  ⊑  vec_reduce_umin_known0_combined := by
  unfold vec_reduce_umin_known0_before vec_reduce_umin_known0_combined
  simp_alive_peephole
  sorry
def vec_reduce_umin_known1_combined := [llvmfunc|
  llvm.func @vec_reduce_umin_known1(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[127, -1, -1, -1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.and %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_vec_reduce_umin_known1   : vec_reduce_umin_known1_before  ⊑  vec_reduce_umin_known1_combined := by
  unfold vec_reduce_umin_known1_before vec_reduce_umin_known1_combined
  simp_alive_peephole
  sorry
def vec_reduce_umin_known_fail0_combined := [llvmfunc|
  llvm.func @vec_reduce_umin_known_fail0(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[1, 0, 0, 0]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_vec_reduce_umin_known_fail0   : vec_reduce_umin_known_fail0_before  ⊑  vec_reduce_umin_known_fail0_combined := by
  unfold vec_reduce_umin_known_fail0_before vec_reduce_umin_known_fail0_combined
  simp_alive_peephole
  sorry
def vec_reduce_umin_known_fail1_combined := [llvmfunc|
  llvm.func @vec_reduce_umin_known_fail1(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_vec_reduce_umin_known_fail1   : vec_reduce_umin_known_fail1_before  ⊑  vec_reduce_umin_known_fail1_combined := by
  unfold vec_reduce_umin_known_fail1_before vec_reduce_umin_known_fail1_combined
  simp_alive_peephole
  sorry
def vec_reduce_smax_known_combined := [llvmfunc|
  llvm.func @vec_reduce_smax_known(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[4, 4, 4, 5]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_vec_reduce_smax_known   : vec_reduce_smax_known_before  ⊑  vec_reduce_smax_known_combined := by
  unfold vec_reduce_smax_known_before vec_reduce_smax_known_combined
  simp_alive_peephole
  sorry
def vec_reduce_smax_known_fail_combined := [llvmfunc|
  llvm.func @vec_reduce_smax_known_fail(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[4, 4, 8, 5]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_vec_reduce_smax_known_fail   : vec_reduce_smax_known_fail_before  ⊑  vec_reduce_smax_known_fail_combined := by
  unfold vec_reduce_smax_known_fail_before vec_reduce_smax_known_fail_combined
  simp_alive_peephole
  sorry
def vec_reduce_smin_known_combined := [llvmfunc|
  llvm.func @vec_reduce_smin_known(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[8, 24, 56, 9]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_vec_reduce_smin_known   : vec_reduce_smin_known_before  ⊑  vec_reduce_smin_known_combined := by
  unfold vec_reduce_smin_known_before vec_reduce_smin_known_combined
  simp_alive_peephole
  sorry
def vec_reduce_smin_known_fail_combined := [llvmfunc|
  llvm.func @vec_reduce_smin_known_fail(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[8, 23, 56, 9]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_vec_reduce_smin_known_fail   : vec_reduce_smin_known_fail_before  ⊑  vec_reduce_smin_known_fail_combined := by
  unfold vec_reduce_smin_known_fail_before vec_reduce_smin_known_fail_combined
  simp_alive_peephole
  sorry
