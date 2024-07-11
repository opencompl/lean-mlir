import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2010-05-30-memcpy-Struct
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def CopyEventArg_before := [llvmfunc|
  llvm.func @CopyEventArg(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.call @sprintf(%arg1, %1, %arg0) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def CopyEventArg_combined := [llvmfunc|
  llvm.func @CopyEventArg(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.call @strcpy(%arg1, %arg0) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return
  }]

theorem inst_combine_CopyEventArg   : CopyEventArg_before  ⊑  CopyEventArg_combined := by
  unfold CopyEventArg_before CopyEventArg_combined
  simp_alive_peephole
  sorry
