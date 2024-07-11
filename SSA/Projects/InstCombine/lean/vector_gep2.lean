import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vector_gep2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def testa_before := [llvmfunc|
  llvm.func @testa(%arg0: !llvm.vec<2 x ptr>) -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.vec<2 x ptr>, vector<2xi32>) -> !llvm.vec<2 x ptr>, i8
    llvm.return %1 : !llvm.vec<2 x ptr>
  }]

def vgep_s_v8i64_before := [llvmfunc|
  llvm.func @vgep_s_v8i64(%arg0: !llvm.ptr, %arg1: vector<8xi64>) -> !llvm.vec<8 x ptr> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, vector<8xi64>) -> !llvm.vec<8 x ptr>, f64
    llvm.return %0 : !llvm.vec<8 x ptr>
  }]

def vgep_s_v8i32_before := [llvmfunc|
  llvm.func @vgep_s_v8i32(%arg0: !llvm.ptr, %arg1: vector<8xi32>) -> !llvm.vec<8 x ptr> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, vector<8xi32>) -> !llvm.vec<8 x ptr>, f64
    llvm.return %0 : !llvm.vec<8 x ptr>
  }]

def vgep_v8iPtr_i32_before := [llvmfunc|
  llvm.func @vgep_v8iPtr_i32(%arg0: !llvm.vec<8 x ptr>, %arg1: i32) -> !llvm.vec<8 x ptr> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.vec<8 x ptr>, i32) -> !llvm.vec<8 x ptr>, i8
    llvm.return %0 : !llvm.vec<8 x ptr>
  }]

def testa_combined := [llvmfunc|
  llvm.func @testa(%arg0: !llvm.vec<2 x ptr>) -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    llvm.return %1 : !llvm.vec<2 x ptr>
  }]

theorem inst_combine_testa   : testa_before  ⊑  testa_combined := by
  unfold testa_before testa_combined
  simp_alive_peephole
  sorry
def vgep_s_v8i64_combined := [llvmfunc|
  llvm.func @vgep_s_v8i64(%arg0: !llvm.ptr, %arg1: vector<8xi64>) -> !llvm.vec<8 x ptr> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, vector<8xi64>) -> !llvm.vec<8 x ptr>, f64
    llvm.return %0 : !llvm.vec<8 x ptr>
  }]

theorem inst_combine_vgep_s_v8i64   : vgep_s_v8i64_before  ⊑  vgep_s_v8i64_combined := by
  unfold vgep_s_v8i64_before vgep_s_v8i64_combined
  simp_alive_peephole
  sorry
def vgep_s_v8i32_combined := [llvmfunc|
  llvm.func @vgep_s_v8i32(%arg0: !llvm.ptr, %arg1: vector<8xi32>) -> !llvm.vec<8 x ptr> {
    %0 = llvm.sext %arg1 : vector<8xi32> to vector<8xi64>
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<8xi64>) -> !llvm.vec<8 x ptr>, f64
    llvm.return %1 : !llvm.vec<8 x ptr>
  }]

theorem inst_combine_vgep_s_v8i32   : vgep_s_v8i32_before  ⊑  vgep_s_v8i32_combined := by
  unfold vgep_s_v8i32_before vgep_s_v8i32_combined
  simp_alive_peephole
  sorry
def vgep_v8iPtr_i32_combined := [llvmfunc|
  llvm.func @vgep_v8iPtr_i32(%arg0: !llvm.vec<8 x ptr>, %arg1: i32) -> !llvm.vec<8 x ptr> {
    %0 = llvm.sext %arg1 : i32 to i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.vec<8 x ptr>, i64) -> !llvm.vec<8 x ptr>, i8
    llvm.return %1 : !llvm.vec<8 x ptr>
  }]

theorem inst_combine_vgep_v8iPtr_i32   : vgep_v8iPtr_i32_before  ⊑  vgep_v8iPtr_i32_combined := by
  unfold vgep_v8iPtr_i32_before vgep_v8iPtr_i32_combined
  simp_alive_peephole
  sorry
