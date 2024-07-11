import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr23809
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def icmp_before := [llvmfunc|
  llvm.func @icmp(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "sge" %1, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return %1 : i32
  }]

def fcmp_before := [llvmfunc|
  llvm.func @fcmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg1  : f32
    %2 = llvm.fcmp "oge" %1, %0 : f32
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return %1 : f32
  }]

def icmp_combined := [llvmfunc|
  llvm.func @icmp(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return %1 : i32
  }]

theorem inst_combine_icmp   : icmp_before  ⊑  icmp_combined := by
  unfold icmp_before icmp_combined
  simp_alive_peephole
  sorry
def fcmp_combined := [llvmfunc|
  llvm.func @fcmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg1  : f32
    %2 = llvm.fcmp "oge" %1, %0 : f32
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return %1 : f32
  }]

theorem inst_combine_fcmp   : fcmp_before  ⊑  fcmp_combined := by
  unfold fcmp_before fcmp_combined
  simp_alive_peephole
  sorry
