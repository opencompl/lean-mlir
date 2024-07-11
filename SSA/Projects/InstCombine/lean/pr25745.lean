import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr25745
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i32 to i64
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.icmp "slt" %arg0, %0 : i32
    %5 = llvm.select %4, %1, %3 : i1, i64
    llvm.call @use.i1(%4) : (i1) -> ()
    llvm.call @use.i64(%1) : (i64) -> ()
    llvm.return %5 : i64
  }]

def f_combined := [llvmfunc|
  llvm.func @f(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i32 to i64
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.icmp "slt" %arg0, %0 : i32
    %5 = llvm.select %4, %1, %3 : i1, i64
    llvm.call @use.i1(%4) : (i1) -> ()
    llvm.call @use.i64(%1) : (i64) -> ()
    llvm.return %5 : i64
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
