import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-08-02-InfiniteLoop
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i16, %arg1: i16) -> i64 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.sext %arg1 : i16 to i32
    %2 = llvm.add %0, %1  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }]

