import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  OverlappingInsertvalues
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_simple(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @foo_simple(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.struct<(ptr, i64, i32)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, i64, i32)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, i64, i32)> 
    %2 = llvm.insertvalue %arg1, %1[0] : !llvm.struct<(ptr, i64, i32)> 
    llvm.return %2 : !llvm.struct<(ptr, i64, i32)>
  }]

def foo_ovwrt_chain(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @foo_ovwrt_chain(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<(ptr, i64, i32)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, i64, i32)>
    %1 = llvm.mlir.constant(555 : i32) : i32
    %2 = llvm.mlir.constant(777 : i32) : i32
    %3 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, i64, i32)> 
    %4 = llvm.insertvalue %arg1, %3[1] : !llvm.struct<(ptr, i64, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<(ptr, i64, i32)> 
    %6 = llvm.insertvalue %arg2, %5[1] : !llvm.struct<(ptr, i64, i32)> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.struct<(ptr, i64, i32)> 
    llvm.return %7 : !llvm.struct<(ptr, i64, i32)>
  }]

def foo_use_as_second_operand(%arg0: i16) -> !llvm.struct<(i8, struct<_before := [llvmfunc|
  llvm.func @foo_use_as_second_operand(%arg0: i16) -> !llvm.struct<(i8, struct<(i16, i32)>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.undef : !llvm.struct<(i16, i32)>
    %1 = llvm.mlir.undef : !llvm.struct<(i8, struct<(i16, i32)>)>
    %2 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(i16, i32)> 
    %3 = llvm.insertvalue %2, %1[1] : !llvm.struct<(i8, struct<(i16, i32)>)> 
    llvm.return %3 : !llvm.struct<(i8, struct<(i16, i32)>)>
  }]

def foo_simple(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @foo_simple(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.struct<(ptr, i64, i32)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, i64, i32)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr, i64, i32)> 
    llvm.return %1 : !llvm.struct<(ptr, i64, i32)>
  }]

theorem inst_combine_foo_simple(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.struct<   : foo_simple(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.struct<_before  ⊑  foo_simple(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.struct<_combined := by
  unfold foo_simple(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.struct<_before foo_simple(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def foo_ovwrt_chain(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @foo_ovwrt_chain(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<(ptr, i64, i32)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, i64, i32)>
    %1 = llvm.mlir.constant(777 : i32) : i32
    %2 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, i64, i32)> 
    %3 = llvm.insertvalue %arg2, %2[1] : !llvm.struct<(ptr, i64, i32)> 
    %4 = llvm.insertvalue %1, %3[2] : !llvm.struct<(ptr, i64, i32)> 
    llvm.return %4 : !llvm.struct<(ptr, i64, i32)>
  }]

theorem inst_combine_foo_ovwrt_chain(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<   : foo_ovwrt_chain(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<_before  ⊑  foo_ovwrt_chain(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<_combined := by
  unfold foo_ovwrt_chain(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<_before foo_ovwrt_chain(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def foo_use_as_second_operand(%arg0: i16) -> !llvm.struct<(i8, struct<_combined := [llvmfunc|
  llvm.func @foo_use_as_second_operand(%arg0: i16) -> !llvm.struct<(i8, struct<(i16, i32)>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.undef : !llvm.struct<(i16, i32)>
    %1 = llvm.mlir.undef : !llvm.struct<(i8, struct<(i16, i32)>)>
    %2 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(i16, i32)> 
    %3 = llvm.insertvalue %2, %1[1] : !llvm.struct<(i8, struct<(i16, i32)>)> 
    llvm.return %3 : !llvm.struct<(i8, struct<(i16, i32)>)>
  }]

theorem inst_combine_foo_use_as_second_operand(%arg0: i16) -> !llvm.struct<(i8, struct<   : foo_use_as_second_operand(%arg0: i16) -> !llvm.struct<(i8, struct<_before  ⊑  foo_use_as_second_operand(%arg0: i16) -> !llvm.struct<(i8, struct<_combined := by
  unfold foo_use_as_second_operand(%arg0: i16) -> !llvm.struct<(i8, struct<_before foo_use_as_second_operand(%arg0: i16) -> !llvm.struct<(i8, struct<_combined
  simp_alive_peephole
  sorry
