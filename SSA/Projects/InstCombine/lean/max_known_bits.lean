import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  max_known_bits
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    %6 = llvm.trunc %5 : i32 to i16
    %7 = llvm.and %6, %0  : i16
    llvm.return %7 : i16
  }]

def min_max_clamp_before := [llvmfunc|
  llvm.func @min_max_clamp(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.icmp "sgt" %arg0, %0 : i16
    %4 = llvm.select %3, %arg0, %0 : i1, i16
    %5 = llvm.icmp "slt" %4, %1 : i16
    %6 = llvm.select %5, %4, %1 : i1, i16
    %7 = llvm.add %6, %2  : i16
    llvm.return %7 : i16
  }]

def min_max_clamp_2_before := [llvmfunc|
  llvm.func @min_max_clamp_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2048 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.icmp "slt" %arg0, %0 : i16
    %4 = llvm.select %3, %arg0, %0 : i1, i16
    %5 = llvm.icmp "sgt" %4, %1 : i16
    %6 = llvm.select %5, %4, %1 : i1, i16
    %7 = llvm.add %6, %2  : i16
    llvm.return %7 : i16
  }]

def min_max_clamp_3_before := [llvmfunc|
  llvm.func @min_max_clamp_3(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.icmp "sgt" %arg0, %0 : i16
    %5 = llvm.select %4, %arg0, %0 : i1, i16
    %6 = llvm.icmp "slt" %5, %1 : i16
    %7 = llvm.select %6, %5, %1 : i1, i16
    %8 = llvm.add %7, %2  : i16
    %9 = llvm.sext %8 : i16 to i32
    %10 = llvm.add %9, %3  : i32
    llvm.return %10 : i32
  }]

def min_max_clamp_4_before := [llvmfunc|
  llvm.func @min_max_clamp_4(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2048 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.icmp "slt" %arg0, %0 : i16
    %5 = llvm.select %4, %arg0, %0 : i1, i16
    %6 = llvm.icmp "sgt" %5, %1 : i16
    %7 = llvm.select %6, %5, %1 : i1, i16
    %8 = llvm.add %7, %2  : i16
    %9 = llvm.sext %8 : i16 to i32
    %10 = llvm.add %9, %3  : i32
    llvm.return %10 : i32
  }]

def min_max_clamp_intrinsic_before := [llvmfunc|
  llvm.func @min_max_clamp_intrinsic(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.intr.smax(%arg0, %0)  : (i16, i16) -> i16
    %4 = llvm.intr.smin(%3, %1)  : (i16, i16) -> i16
    %5 = llvm.add %4, %2  : i16
    llvm.return %5 : i16
  }]

def min_max_clamp_intrinsic_2_before := [llvmfunc|
  llvm.func @min_max_clamp_intrinsic_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2048 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.intr.smin(%arg0, %0)  : (i16, i16) -> i16
    %4 = llvm.intr.smax(%3, %1)  : (i16, i16) -> i16
    %5 = llvm.add %4, %2  : i16
    llvm.return %5 : i16
  }]

def min_max_clamp_intrinsic_3_before := [llvmfunc|
  llvm.func @min_max_clamp_intrinsic_3(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.intr.smax(%arg0, %0)  : (i16, i16) -> i16
    %5 = llvm.intr.smin(%4, %1)  : (i16, i16) -> i16
    %6 = llvm.add %5, %2  : i16
    %7 = llvm.sext %6 : i16 to i32
    %8 = llvm.add %7, %3  : i32
    llvm.return %8 : i32
  }]

def min_max_clamp_intrinsic_4_before := [llvmfunc|
  llvm.func @min_max_clamp_intrinsic_4(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2048 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.intr.smin(%arg0, %0)  : (i16, i16) -> i16
    %5 = llvm.intr.smax(%4, %1)  : (i16, i16) -> i16
    %6 = llvm.add %5, %2  : i16
    %7 = llvm.sext %6 : i16 to i32
    %8 = llvm.add %7, %3  : i32
    llvm.return %8 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def min_max_clamp_combined := [llvmfunc|
  llvm.func @min_max_clamp(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.intr.smax(%arg0, %0)  : (i16, i16) -> i16
    %4 = llvm.intr.smin(%3, %1)  : (i16, i16) -> i16
    %5 = llvm.add %4, %2 overflow<nsw>  : i16
    llvm.return %5 : i16
  }]

theorem inst_combine_min_max_clamp   : min_max_clamp_before  ⊑  min_max_clamp_combined := by
  unfold min_max_clamp_before min_max_clamp_combined
  simp_alive_peephole
  sorry
def min_max_clamp_2_combined := [llvmfunc|
  llvm.func @min_max_clamp_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2048 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.intr.smin(%arg0, %0)  : (i16, i16) -> i16
    %4 = llvm.intr.smax(%3, %1)  : (i16, i16) -> i16
    %5 = llvm.add %4, %2 overflow<nsw>  : i16
    llvm.return %5 : i16
  }]

theorem inst_combine_min_max_clamp_2   : min_max_clamp_2_before  ⊑  min_max_clamp_2_combined := by
  unfold min_max_clamp_2_before min_max_clamp_2_combined
  simp_alive_peephole
  sorry
def min_max_clamp_3_combined := [llvmfunc|
  llvm.func @min_max_clamp_3(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.intr.smax(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.intr.smin(%2, %1)  : (i16, i16) -> i16
    %4 = llvm.sext %3 : i16 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_min_max_clamp_3   : min_max_clamp_3_before  ⊑  min_max_clamp_3_combined := by
  unfold min_max_clamp_3_before min_max_clamp_3_combined
  simp_alive_peephole
  sorry
def min_max_clamp_4_combined := [llvmfunc|
  llvm.func @min_max_clamp_4(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2048 : i16) : i16
    %2 = llvm.intr.smin(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.intr.smax(%2, %1)  : (i16, i16) -> i16
    %4 = llvm.sext %3 : i16 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_min_max_clamp_4   : min_max_clamp_4_before  ⊑  min_max_clamp_4_combined := by
  unfold min_max_clamp_4_before min_max_clamp_4_combined
  simp_alive_peephole
  sorry
def min_max_clamp_intrinsic_combined := [llvmfunc|
  llvm.func @min_max_clamp_intrinsic(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.intr.smax(%arg0, %0)  : (i16, i16) -> i16
    %4 = llvm.intr.smin(%3, %1)  : (i16, i16) -> i16
    %5 = llvm.add %4, %2 overflow<nsw>  : i16
    llvm.return %5 : i16
  }]

theorem inst_combine_min_max_clamp_intrinsic   : min_max_clamp_intrinsic_before  ⊑  min_max_clamp_intrinsic_combined := by
  unfold min_max_clamp_intrinsic_before min_max_clamp_intrinsic_combined
  simp_alive_peephole
  sorry
def min_max_clamp_intrinsic_2_combined := [llvmfunc|
  llvm.func @min_max_clamp_intrinsic_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2048 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.intr.smin(%arg0, %0)  : (i16, i16) -> i16
    %4 = llvm.intr.smax(%3, %1)  : (i16, i16) -> i16
    %5 = llvm.add %4, %2 overflow<nsw>  : i16
    llvm.return %5 : i16
  }]

theorem inst_combine_min_max_clamp_intrinsic_2   : min_max_clamp_intrinsic_2_before  ⊑  min_max_clamp_intrinsic_2_combined := by
  unfold min_max_clamp_intrinsic_2_before min_max_clamp_intrinsic_2_combined
  simp_alive_peephole
  sorry
def min_max_clamp_intrinsic_3_combined := [llvmfunc|
  llvm.func @min_max_clamp_intrinsic_3(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.intr.smax(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.intr.smin(%2, %1)  : (i16, i16) -> i16
    %4 = llvm.sext %3 : i16 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_min_max_clamp_intrinsic_3   : min_max_clamp_intrinsic_3_before  ⊑  min_max_clamp_intrinsic_3_combined := by
  unfold min_max_clamp_intrinsic_3_before min_max_clamp_intrinsic_3_combined
  simp_alive_peephole
  sorry
def min_max_clamp_intrinsic_4_combined := [llvmfunc|
  llvm.func @min_max_clamp_intrinsic_4(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2048 : i16) : i16
    %2 = llvm.intr.smin(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.intr.smax(%2, %1)  : (i16, i16) -> i16
    %4 = llvm.sext %3 : i16 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_min_max_clamp_intrinsic_4   : min_max_clamp_intrinsic_4_before  ⊑  min_max_clamp_intrinsic_4_combined := by
  unfold min_max_clamp_intrinsic_4_before min_max_clamp_intrinsic_4_combined
  simp_alive_peephole
  sorry
