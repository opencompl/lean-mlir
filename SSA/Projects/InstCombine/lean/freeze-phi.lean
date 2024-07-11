import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  freeze-phi
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def const_before := [llvmfunc|
  llvm.func @const(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    %3 = llvm.freeze %2 : i32
    llvm.return %3 : i32
  }]

def vec_before := [llvmfunc|
  llvm.func @vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : vector<2xi32>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : vector<2xi32>)
  ^bb3(%2: vector<2xi32>):  // 2 preds: ^bb1, ^bb2
    %3 = llvm.freeze %2 : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def vec_undef_before := [llvmfunc|
  llvm.func @vec_undef(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%7 : vector<2xi32>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%6 : vector<2xi32>)
  ^bb3(%8: vector<2xi32>):  // 2 preds: ^bb1, ^bb2
    %9 = llvm.freeze %8 : vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }]

def one_before := [llvmfunc|
  llvm.func @one(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : i32)
  ^bb3(%1: i32):  // 2 preds: ^bb1, ^bb2
    %2 = llvm.freeze %1 : i32
    llvm.return %2 : i32
  }]

def two_before := [llvmfunc|
  llvm.func @two(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : i32)
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    %1 = llvm.freeze %0 : i32
    llvm.return %1 : i32
  }]

def two_undef_before := [llvmfunc|
  llvm.func @two_undef(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : i32
    llvm.switch %arg0 : i8, ^bb1 [
      0: ^bb2,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%arg1 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb4(%2: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %3 = llvm.freeze %2 : i32
    llvm.return %3 : i32
  }]

def one_undef_before := [llvmfunc|
  llvm.func @one_undef(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.undef : i32
    llvm.switch %arg0 : i8, ^bb1 [
      0: ^bb2,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%2 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%1 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb4(%3: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %4 = llvm.freeze %3 : i32
    llvm.return %4 : i32
  }]

def one_constexpr_before := [llvmfunc|
  llvm.func @one_constexpr(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.addressof @glb : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i32
    llvm.switch %arg0 : i8, ^bb1 [
      0: ^bb2,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%6 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%1 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb4(%7: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %8 = llvm.freeze %7 : i32
    llvm.return %8 : i32
  }]

def const_combined := [llvmfunc|
  llvm.func @const(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_const   : const_before  ⊑  const_combined := by
  unfold const_before const_combined
  simp_alive_peephole
  sorry
def vec_combined := [llvmfunc|
  llvm.func @vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : vector<2xi32>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : vector<2xi32>)
  ^bb3(%2: vector<2xi32>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_vec   : vec_before  ⊑  vec_combined := by
  unfold vec_before vec_combined
  simp_alive_peephole
  sorry
def vec_undef_combined := [llvmfunc|
  llvm.func @vec_undef(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : vector<2xi32>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : vector<2xi32>)
  ^bb3(%2: vector<2xi32>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_vec_undef   : vec_undef_before  ⊑  vec_undef_combined := by
  unfold vec_undef_before vec_undef_combined
  simp_alive_peephole
  sorry
def one_combined := [llvmfunc|
  llvm.func @one(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.freeze %arg1 : i32
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_one   : one_before  ⊑  one_combined := by
  unfold one_before one_combined
  simp_alive_peephole
  sorry
def two_combined := [llvmfunc|
  llvm.func @two(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : i32)
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    %1 = llvm.freeze %0 : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_two   : two_before  ⊑  two_combined := by
  unfold two_before two_combined
  simp_alive_peephole
  sorry
def two_undef_combined := [llvmfunc|
  llvm.func @two_undef(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : i32
    llvm.switch %arg0 : i8, ^bb1 [
      0: ^bb2,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%arg1 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb4(%2: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %3 = llvm.freeze %2 : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_two_undef   : two_undef_before  ⊑  two_undef_combined := by
  unfold two_undef_before two_undef_combined
  simp_alive_peephole
  sorry
def one_undef_combined := [llvmfunc|
  llvm.func @one_undef(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    llvm.switch %arg0 : i8, ^bb1 [
      0: ^bb2,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%1 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb4(%2: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %2 : i32
  }]

theorem inst_combine_one_undef   : one_undef_before  ⊑  one_undef_combined := by
  unfold one_undef_before one_undef_combined
  simp_alive_peephole
  sorry
def one_constexpr_combined := [llvmfunc|
  llvm.func @one_constexpr(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.addressof @glb : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i32
    llvm.switch %arg0 : i8, ^bb1 [
      0: ^bb2,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    %7 = llvm.freeze %6 : i32
    llvm.br ^bb4(%7 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%1 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb4(%8: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %8 : i32
  }]

theorem inst_combine_one_constexpr   : one_constexpr_before  ⊑  one_constexpr_combined := by
  unfold one_constexpr_before one_constexpr_combined
  simp_alive_peephole
  sorry
