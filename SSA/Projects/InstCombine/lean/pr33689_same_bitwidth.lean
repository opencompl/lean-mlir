import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr33689_same_bitwidth
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: i1) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : i16
    %2 = llvm.mlir.addressof @b : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.undef : !llvm.array<1 x ptr>
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @a : !llvm.ptr
    %7 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.getelementptr inbounds %7[%1] : (!llvm.ptr, i16) -> !llvm.ptr, i16
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %9 = llvm.insertvalue %7, %4[0] : !llvm.array<1 x ptr> 
    %10 = llvm.insertvalue %5, %9[0] : !llvm.array<1 x ptr> 
    %11 = llvm.ptrtoint %7 : !llvm.ptr to i16
    llvm.store %11, %6 {alignment = 2 : i64} : i16, !llvm.ptr]

    llvm.unreachable
  ^bb2:  // pred: ^bb0
    %12 = llvm.load %2 {alignment = 2 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.store %3, %12 {alignment = 2 : i64} : i16, !llvm.ptr]

    %13 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %14 = llvm.sub %13, %0  : i32
    llvm.store %14, %7 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def f_combined := [llvmfunc|
  llvm.func @f(%arg0: i1) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    %5 = llvm.load %1 {alignment = 2 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    llvm.store %2, %5 {alignment = 2 : i64} : i16, !llvm.ptr]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    %6 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    %7 = llvm.add %6, %3  : i32
    llvm.store %7, %4 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
