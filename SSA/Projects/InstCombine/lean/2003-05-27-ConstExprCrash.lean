import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2003-05-27-ConstExprCrash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test() -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.addressof @X : !llvm.ptr
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.add %0, %1  : i64
    %6 = llvm.add %4, %5  : i64
    llvm.return %6 : i64
  }]

