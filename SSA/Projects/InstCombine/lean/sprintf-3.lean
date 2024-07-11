import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sprintf-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR51200_before := [llvmfunc|
  llvm.func @PR51200(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_s : !llvm.ptr
    %2 = llvm.call @sprintf(%arg0, %1, %arg1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

def PR51200_combined := [llvmfunc|
  llvm.func @PR51200(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.call @stpcpy(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.sub %1, %2  : i64
    %4 = llvm.trunc %3 : i64 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_PR51200   : PR51200_before  ⊑  PR51200_combined := by
  unfold PR51200_before PR51200_combined
  simp_alive_peephole
  sorry
