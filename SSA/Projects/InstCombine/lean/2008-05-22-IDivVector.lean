import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-05-22-IDivVector
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.sdiv %arg0, %arg0  : vector<3xi8>
    llvm.return %0 : vector<3xi8>
  }]

