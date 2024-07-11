import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2012-3-15-or-xor-constant
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def function_before := [llvmfunc|
  llvm.func @function(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %3 = llvm.mlir.addressof @g : !llvm.ptr
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.xor %arg0, %0  : i32
    llvm.store volatile %5, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %6 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    %7 = llvm.zext %6 : i1 to i32
    %8 = llvm.or %7, %0  : i32
    %9 = llvm.or %8, %5  : i32
    llvm.return %9 : i32
  }]

def function_combined := [llvmfunc|
  llvm.func @function(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %3 = llvm.xor %arg0, %0  : i32
    llvm.store volatile %3, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.or %arg0, %0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_function   : function_before  ⊑  function_combined := by
  unfold function_before function_combined
  simp_alive_peephole
  sorry
