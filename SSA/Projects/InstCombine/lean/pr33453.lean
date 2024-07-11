import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr33453
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def patatino_before := [llvmfunc|
  llvm.func @patatino() -> f32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @g2 : !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    %5 = llvm.uitofp %4 : i1 to f32
    %6 = llvm.uitofp %4 : i1 to f32
    %7 = llvm.fmul %5, %6  : f32
    %8 = llvm.call @fabsf(%7) : (f32) -> f32
    llvm.return %8 : f32
  }]

def patatino_combined := [llvmfunc|
  llvm.func @patatino() -> f32 {
    %0 = llvm.mlir.addressof @g1 : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.addressof @g2 : !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %4 = llvm.icmp "eq" %3, %0 : !llvm.ptr
    %5 = llvm.uitofp %4 : i1 to f32
    %6 = llvm.uitofp %4 : i1 to f32
    %7 = llvm.fmul %5, %6  : f32
    llvm.return %7 : f32
  }]

theorem inst_combine_patatino   : patatino_before  ⊑  patatino_combined := by
  unfold patatino_before patatino_combined
  simp_alive_peephole
  sorry
