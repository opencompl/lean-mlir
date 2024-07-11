import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  gep-canonicalize-constant-indices
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def basic_before := [llvmfunc|
  llvm.func @basic(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.getelementptr inbounds %1[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

def partialConstant1_before := [llvmfunc|
  llvm.func @partialConstant1(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%arg1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i32>
    %2 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %2 : !llvm.ptr
  }]

def partialConstant2_before := [llvmfunc|
  llvm.func @partialConstant2(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i32>
    %2 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %2 : !llvm.ptr
  }]

def merge_before := [llvmfunc|
  llvm.func @merge(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def nested_before := [llvmfunc|
  llvm.func @nested(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, vector<3xi32>
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.mul %arg1, %arg2  : i64
    %5 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, vector<5xi32>
    %6 = llvm.getelementptr inbounds %5[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %7 = llvm.getelementptr inbounds %6[%0] : (!llvm.ptr, i64) -> !llvm.ptr, vector<4xi32>
    llvm.return %7 : !llvm.ptr
  }]

def multipleUses1_before := [llvmfunc|
  llvm.func @multipleUses1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.getelementptr inbounds %1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

def multipleUses2_before := [llvmfunc|
  llvm.func @multipleUses2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return %3 : !llvm.ptr
  }]

def multipleUses3_before := [llvmfunc|
  llvm.func @multipleUses3(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.getelementptr inbounds %1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

def basic_combined := [llvmfunc|
  llvm.func @basic(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.getelementptr inbounds %1[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_basic   : basic_before  ⊑  basic_combined := by
  unfold basic_before basic_combined
  simp_alive_peephole
  sorry
def partialConstant1_combined := [llvmfunc|
  llvm.func @partialConstant1(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_partialConstant1   : partialConstant1_before  ⊑  partialConstant1_combined := by
  unfold partialConstant1_before partialConstant1_combined
  simp_alive_peephole
  sorry
def partialConstant2_combined := [llvmfunc|
  llvm.func @partialConstant2(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_partialConstant2   : partialConstant2_before  ⊑  partialConstant2_combined := by
  unfold partialConstant2_before partialConstant2_combined
  simp_alive_peephole
  sorry
def merge_combined := [llvmfunc|
  llvm.func @merge(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_merge   : merge_before  ⊑  merge_combined := by
  unfold merge_before merge_combined
  simp_alive_peephole
  sorry
def nested_combined := [llvmfunc|
  llvm.func @nested(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, vector<3xi32>
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.mul %arg1, %arg2  : i64
    %5 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, vector<5xi32>
    %6 = llvm.getelementptr inbounds %5[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %7 = llvm.getelementptr inbounds %6[%0] : (!llvm.ptr, i64) -> !llvm.ptr, vector<4xi32>
    llvm.return %7 : !llvm.ptr
  }]

theorem inst_combine_nested   : nested_before  ⊑  nested_combined := by
  unfold nested_before nested_combined
  simp_alive_peephole
  sorry
def multipleUses1_combined := [llvmfunc|
  llvm.func @multipleUses1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.getelementptr inbounds %1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_multipleUses1   : multipleUses1_before  ⊑  multipleUses1_combined := by
  unfold multipleUses1_before multipleUses1_combined
  simp_alive_peephole
  sorry
def multipleUses2_combined := [llvmfunc|
  llvm.func @multipleUses2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_multipleUses2   : multipleUses2_before  ⊑  multipleUses2_combined := by
  unfold multipleUses2_before multipleUses2_combined
  simp_alive_peephole
  sorry
def multipleUses3_combined := [llvmfunc|
  llvm.func @multipleUses3(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.getelementptr inbounds %1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_multipleUses3   : multipleUses3_before  ⊑  multipleUses3_combined := by
  unfold multipleUses3_before multipleUses3_combined
  simp_alive_peephole
  sorry
