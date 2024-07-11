import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  trunc-shl-zext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def trunc_shl_zext_32_before := [llvmfunc|
  llvm.func @trunc_shl_zext_32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.shl %1, %0  : i16
    %3 = llvm.zext %2 : i16 to i32
    llvm.return %3 : i32
  }]

def trunc_shl_zext_64_before := [llvmfunc|
  llvm.func @trunc_shl_zext_64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i64 to i8
    %2 = llvm.shl %1, %0  : i8
    %3 = llvm.zext %2 : i8 to i64
    llvm.return %3 : i64
  }]

def trunc_shl_zext_32_combined := [llvmfunc|
  llvm.func @trunc_shl_zext_32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.shl %1, %0  : i16
    %3 = llvm.zext %2 : i16 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_trunc_shl_zext_32   : trunc_shl_zext_32_before  ⊑  trunc_shl_zext_32_combined := by
  unfold trunc_shl_zext_32_before trunc_shl_zext_32_combined
  simp_alive_peephole
  sorry
def trunc_shl_zext_64_combined := [llvmfunc|
  llvm.func @trunc_shl_zext_64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i64 to i8
    %2 = llvm.shl %1, %0  : i8
    %3 = llvm.zext %2 : i8 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_trunc_shl_zext_64   : trunc_shl_zext_64_before  ⊑  trunc_shl_zext_64_combined := by
  unfold trunc_shl_zext_64_before trunc_shl_zext_64_combined
  simp_alive_peephole
  sorry
