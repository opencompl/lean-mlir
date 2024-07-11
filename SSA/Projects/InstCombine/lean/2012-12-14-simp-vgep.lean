import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2012-12-14-simp-vgep
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr) -> vector<4xi32> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<4 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<4 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<4 x ptr>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<4 x ptr>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<4 x ptr>
    %10 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.vec<4 x ptr>]

    %11 = llvm.icmp "eq" %10, %9 : !llvm.vec<4 x ptr>
    %12 = llvm.zext %11 : vector<4xi1> to vector<4xi32>
    llvm.return %12 : vector<4xi32>
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr) -> vector<4xi32> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<4 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<4 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<4 x ptr>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<4 x ptr>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<4 x ptr>
    %10 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.vec<4 x ptr>
    %11 = llvm.icmp "eq" %10, %9 : !llvm.vec<4 x ptr>
    %12 = llvm.zext %11 : vector<4xi1> to vector<4xi32>
    llvm.return %12 : vector<4xi32>
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
