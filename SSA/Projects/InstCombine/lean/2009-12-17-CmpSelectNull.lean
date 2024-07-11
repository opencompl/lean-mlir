import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-12-17-CmpSelectNull
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def demangle_qualified_before := [llvmfunc|
  llvm.func @demangle_qualified(%arg0: i32) -> !llvm.ptr attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(".\00") : !llvm.array<2 x i8>
    %2 = llvm.mlir.addressof @".str254" : !llvm.ptr
    %3 = llvm.mlir.constant("::\00") : !llvm.array<3 x i8>
    %4 = llvm.mlir.addressof @".str557" : !llvm.ptr
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.icmp "ne" %arg0, %0 : i32
    %7 = llvm.select %6, %2, %4 : i1, !llvm.ptr
    %8 = llvm.icmp "eq" %7, %5 : !llvm.ptr
    %9 = llvm.getelementptr %7[%8] : (!llvm.ptr, i1) -> !llvm.ptr, i8
    llvm.return %9 : !llvm.ptr
  }]

def demangle_qualified_combined := [llvmfunc|
  llvm.func @demangle_qualified(%arg0: i32) -> !llvm.ptr attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant("::\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str557" : !llvm.ptr
    %3 = llvm.mlir.constant(".\00") : !llvm.array<2 x i8>
    %4 = llvm.mlir.addressof @".str254" : !llvm.ptr
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.select %5, %2, %4 : i1, !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_demangle_qualified   : demangle_qualified_before  ⊑  demangle_qualified_combined := by
  unfold demangle_qualified_before demangle_qualified_combined
  simp_alive_peephole
  sorry
