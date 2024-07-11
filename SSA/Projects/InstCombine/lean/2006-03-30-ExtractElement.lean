import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2006-03-30-ExtractElement
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    %4 = llvm.extractelement %3[%2 : i32] : vector<4xf32>
    llvm.return %4 : f32
  }]

