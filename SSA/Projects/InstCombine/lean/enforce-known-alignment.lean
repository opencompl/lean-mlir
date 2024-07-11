import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  enforce-known-alignment
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.alloca %0 x !llvm.array<3 x struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.getelementptr %3[%1, %1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<3 x struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>
    %5 = llvm.getelementptr %4[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>
    %6 = llvm.getelementptr %5[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>
    %7 = llvm.getelementptr %6[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(array<8 x i16>)>
    %8 = llvm.getelementptr %7[%1, %1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<8 x i16>
    llvm.store %2, %8 {alignment = 16 : i64} : i16, !llvm.ptr]

    llvm.call @bar(%8) : (!llvm.ptr) -> ()
    llvm.return
  }]

def foo_as1_before := [llvmfunc|
  llvm.func @foo_as1(%arg0: i32, %arg1: !llvm.ptr<1>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.getelementptr %arg1[%0, %0] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<3 x struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>
    %3 = llvm.getelementptr %2[%0, 0] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, !llvm.struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>
    %4 = llvm.getelementptr %3[%0, 0] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, !llvm.struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>
    %5 = llvm.getelementptr %4[%0, 0] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, !llvm.struct<(array<8 x i16>)>
    %6 = llvm.getelementptr %5[%0, %0] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<8 x i16>
    llvm.store %1, %6 {alignment = 16 : i64} : i16, !llvm.ptr<1>]

    llvm.call @bar_as1(%6) : (!llvm.ptr<1>) -> ()
    llvm.return
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.alloca %0 x !llvm.array<3 x struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 16 : i64} : i16, !llvm.ptr
    llvm.call @bar(%2) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def foo_as1_combined := [llvmfunc|
  llvm.func @foo_as1(%arg0: i32, %arg1: !llvm.ptr<1>) {
    %0 = llvm.mlir.constant(0 : i16) : i16
    llvm.store %0, %arg1 {alignment = 16 : i64} : i16, !llvm.ptr<1>
    llvm.call @bar_as1(%arg1) : (!llvm.ptr<1>) -> ()
    llvm.return
  }]

theorem inst_combine_foo_as1   : foo_as1_before  ⊑  foo_as1_combined := by
  unfold foo_as1_before foo_as1_combined
  simp_alive_peephole
  sorry
