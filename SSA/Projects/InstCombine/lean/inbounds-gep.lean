import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  inbounds-gep
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def call1_before := [llvmfunc|
  llvm.func @call1() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.call @g() : () -> !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

def call2_before := [llvmfunc|
  llvm.func @call2() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.call @g() : () -> !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

def call3_before := [llvmfunc|
  llvm.func @call3() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.call @g() : () -> !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

def alloca_before := [llvmfunc|
  llvm.func @alloca() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.addressof @use : !llvm.ptr
    %3 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %2(%4) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

def arg1_before := [llvmfunc|
  llvm.func @arg1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%2) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

def arg2_before := [llvmfunc|
  llvm.func @arg2(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%2) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

def arg3_before := [llvmfunc|
  llvm.func @arg3(%arg0: !llvm.ptr {llvm.dereferenceable_or_null = 8 : i64}) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%2) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

def call1_combined := [llvmfunc|
  llvm.func @call1() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.call @g() : () -> !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_call1   : call1_before  ⊑  call1_combined := by
  unfold call1_before call1_combined
  simp_alive_peephole
  sorry
def call2_combined := [llvmfunc|
  llvm.func @call2() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.call @g() : () -> !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_call2   : call2_before  ⊑  call2_combined := by
  unfold call2_before call2_combined
  simp_alive_peephole
  sorry
def call3_combined := [llvmfunc|
  llvm.func @call3() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.call @g() : () -> !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_call3   : call3_before  ⊑  call3_combined := by
  unfold call3_before call3_combined
  simp_alive_peephole
  sorry
def alloca_combined := [llvmfunc|
  llvm.func @alloca() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.addressof @use : !llvm.ptr
    %3 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_alloca   : alloca_before  ⊑  alloca_combined := by
  unfold alloca_before alloca_combined
  simp_alive_peephole
  sorry
    %4 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %2(%4) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_alloca   : alloca_before  ⊑  alloca_combined := by
  unfold alloca_before alloca_combined
  simp_alive_peephole
  sorry
def arg1_combined := [llvmfunc|
  llvm.func @arg1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%2) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_arg1   : arg1_before  ⊑  arg1_combined := by
  unfold arg1_before arg1_combined
  simp_alive_peephole
  sorry
def arg2_combined := [llvmfunc|
  llvm.func @arg2(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%2) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_arg2   : arg2_before  ⊑  arg2_combined := by
  unfold arg2_before arg2_combined
  simp_alive_peephole
  sorry
def arg3_combined := [llvmfunc|
  llvm.func @arg3(%arg0: !llvm.ptr {llvm.dereferenceable_or_null = 8 : i64}) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call %1(%2) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_arg3   : arg3_before  ⊑  arg3_combined := by
  unfold arg3_before arg3_combined
  simp_alive_peephole
  sorry
