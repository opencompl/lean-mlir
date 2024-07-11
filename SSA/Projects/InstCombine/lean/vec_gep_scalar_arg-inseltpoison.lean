import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vec_gep_scalar_arg-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR41270_before := [llvmfunc|
  llvm.func @PR41270(%arg0: !llvm.ptr) -> !llvm.vec<4 x ptr> {
    %0 = llvm.mlir.poison : !llvm.vec<4 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<4 x ptr>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<4 x ptr> 
    %5 = llvm.getelementptr inbounds %4[%1, %2] : (!llvm.vec<4 x ptr>, i32, i32) -> !llvm.vec<4 x ptr>, !llvm.array<4 x i16>
    %6 = llvm.extractelement %5[%2 : i32] : !llvm.vec<4 x ptr>
    %7 = llvm.insertelement %6, %0[%1 : i32] : !llvm.vec<4 x ptr>
    llvm.return %7 : !llvm.vec<4 x ptr>
  }]

def PR41270_combined := [llvmfunc|
  llvm.func @PR41270(%arg0: !llvm.ptr) -> !llvm.vec<4 x ptr> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.poison : !llvm.vec<4 x ptr>
    %3 = llvm.getelementptr inbounds %arg0[%0, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i16>
    %4 = llvm.insertelement %3, %2[%0 : i64] : !llvm.vec<4 x ptr>
    llvm.return %4 : !llvm.vec<4 x ptr>
  }]

theorem inst_combine_PR41270   : PR41270_before  ⊑  PR41270_combined := by
  unfold PR41270_before PR41270_combined
  simp_alive_peephole
  sorry
