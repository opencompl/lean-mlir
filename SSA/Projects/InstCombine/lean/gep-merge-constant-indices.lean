import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  gep-merge-constant-indices
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def mergeBasic_before := [llvmfunc|
  llvm.func @mergeBasic(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

def mergeDifferentTypes_before := [llvmfunc|
  llvm.func @mergeDifferentTypes(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.return %3 : !llvm.ptr
  }]

def mergeReverse_before := [llvmfunc|
  llvm.func @mergeReverse(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %3 : !llvm.ptr
  }]

def zeroSum_before := [llvmfunc|
  llvm.func @zeroSum(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(-4 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %3 : !llvm.ptr
  }]

def array1_before := [llvmfunc|
  llvm.func @array1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<20 x i8>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.return %3 : !llvm.ptr
  }]

def array2_before := [llvmfunc|
  llvm.func @array2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %3 = llvm.getelementptr inbounds %2[%1, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    llvm.return %3 : !llvm.ptr
  }]

def struct1_before := [llvmfunc|
  llvm.func @struct1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.C", (i8, i32, i32)>
    llvm.return %3 : !llvm.ptr
  }]

def struct2_before := [llvmfunc|
  llvm.func @struct2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-128 : i64) : i64
    %3 = llvm.getelementptr inbounds %arg0[%0, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.A", (array<123 x i8>, i32)>
    %4 = llvm.getelementptr inbounds %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %4 : !llvm.ptr
  }]

def structStruct_before := [llvmfunc|
  llvm.func @structStruct(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.getelementptr inbounds %arg0[%0, 2, 0, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.struct<"struct.B", (i8, array<3 x i16>, struct<"struct.A", (array<123 x i8>, i32)>, f32)>
    %6 = llvm.getelementptr inbounds %5[%0, 0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.struct<"struct.A", (array<123 x i8>, i32)>
    llvm.return %6 : !llvm.ptr
  }]

def appendIndex_before := [llvmfunc|
  llvm.func @appendIndex(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.B", (i8, array<3 x i16>, struct<"struct.A", (array<123 x i8>, i32)>, f32)>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

def notDivisible_before := [llvmfunc|
  llvm.func @notDivisible(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i24
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %2 : !llvm.ptr
  }]

def partialConstant2_before := [llvmfunc|
  llvm.func @partialConstant2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%arg1, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i64>
    llvm.return %3 : !llvm.ptr
  }]

def partialConstant3_before := [llvmfunc|
  llvm.func @partialConstant3(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.getelementptr inbounds %2[%3, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i64>
    llvm.return %4 : !llvm.ptr
  }]

def partialConstantMemberAliasing1_before := [llvmfunc|
  llvm.func @partialConstantMemberAliasing1(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.C", (i8, i32, i32)>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

def partialConstantMemberAliasing2_before := [llvmfunc|
  llvm.func @partialConstantMemberAliasing2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.C", (i8, i32, i32)>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %3 : !llvm.ptr
  }]

def partialConstantMemberAliasing3_before := [llvmfunc|
  llvm.func @partialConstantMemberAliasing3(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1, 2] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.C", (i8, i32, i32)>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

def mergeBasic_combined := [llvmfunc|
  llvm.func @mergeBasic(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_mergeBasic   : mergeBasic_before  ⊑  mergeBasic_combined := by
  unfold mergeBasic_before mergeBasic_combined
  simp_alive_peephole
  sorry
def mergeDifferentTypes_combined := [llvmfunc|
  llvm.func @mergeDifferentTypes(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_mergeDifferentTypes   : mergeDifferentTypes_before  ⊑  mergeDifferentTypes_combined := by
  unfold mergeDifferentTypes_before mergeDifferentTypes_combined
  simp_alive_peephole
  sorry
def mergeReverse_combined := [llvmfunc|
  llvm.func @mergeReverse(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_mergeReverse   : mergeReverse_before  ⊑  mergeReverse_combined := by
  unfold mergeReverse_before mergeReverse_combined
  simp_alive_peephole
  sorry
def zeroSum_combined := [llvmfunc|
  llvm.func @zeroSum(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_zeroSum   : zeroSum_before  ⊑  zeroSum_combined := by
  unfold zeroSum_before zeroSum_combined
  simp_alive_peephole
  sorry
def array1_combined := [llvmfunc|
  llvm.func @array1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(17 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<20 x i8>
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_array1   : array1_before  ⊑  array1_combined := by
  unfold array1_before array1_combined
  simp_alive_peephole
  sorry
def array2_combined := [llvmfunc|
  llvm.func @array2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(20 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_array2   : array2_before  ⊑  array2_combined := by
  unfold array2_before array2_combined
  simp_alive_peephole
  sorry
def struct1_combined := [llvmfunc|
  llvm.func @struct1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(36 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_struct1   : struct1_before  ⊑  struct1_combined := by
  unfold struct1_before struct1_combined
  simp_alive_peephole
  sorry
def struct2_combined := [llvmfunc|
  llvm.func @struct2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.A", (array<123 x i8>, i32)>
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_struct2   : struct2_before  ⊑  struct2_combined := by
  unfold struct2_before struct2_combined
  simp_alive_peephole
  sorry
def structStruct_combined := [llvmfunc|
  llvm.func @structStruct(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(7 : i64) : i64
    %4 = llvm.getelementptr inbounds %arg0[%0, 2, 0, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.struct<"struct.B", (i8, array<3 x i16>, struct<"struct.A", (array<123 x i8>, i32)>, f32)>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_structStruct   : structStruct_before  ⊑  structStruct_combined := by
  unfold structStruct_before structStruct_combined
  simp_alive_peephole
  sorry
def appendIndex_combined := [llvmfunc|
  llvm.func @appendIndex(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1, 1, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.struct<"struct.B", (i8, array<3 x i16>, struct<"struct.A", (array<123 x i8>, i32)>, f32)>
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_appendIndex   : appendIndex_before  ⊑  appendIndex_combined := by
  unfold appendIndex_before appendIndex_combined
  simp_alive_peephole
  sorry
def notDivisible_combined := [llvmfunc|
  llvm.func @notDivisible(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_notDivisible   : notDivisible_before  ⊑  notDivisible_combined := by
  unfold notDivisible_before notDivisible_combined
  simp_alive_peephole
  sorry
def partialConstant2_combined := [llvmfunc|
  llvm.func @partialConstant2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %2[%arg1, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i64>
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_partialConstant2   : partialConstant2_before  ⊑  partialConstant2_combined := by
  unfold partialConstant2_before partialConstant2_combined
  simp_alive_peephole
  sorry
def partialConstant3_combined := [llvmfunc|
  llvm.func @partialConstant3(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.getelementptr inbounds %2[%3, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i64>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_partialConstant3   : partialConstant3_before  ⊑  partialConstant3_combined := by
  unfold partialConstant3_before partialConstant3_combined
  simp_alive_peephole
  sorry
def partialConstantMemberAliasing1_combined := [llvmfunc|
  llvm.func @partialConstantMemberAliasing1(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.getelementptr inbounds %arg0[%arg1, 2] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.C", (i8, i32, i32)>
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_partialConstantMemberAliasing1   : partialConstantMemberAliasing1_before  ⊑  partialConstantMemberAliasing1_combined := by
  unfold partialConstantMemberAliasing1_before partialConstantMemberAliasing1_combined
  simp_alive_peephole
  sorry
def partialConstantMemberAliasing2_combined := [llvmfunc|
  llvm.func @partialConstantMemberAliasing2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.C", (i8, i32, i32)>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_partialConstantMemberAliasing2   : partialConstantMemberAliasing2_before  ⊑  partialConstantMemberAliasing2_combined := by
  unfold partialConstantMemberAliasing2_before partialConstantMemberAliasing2_combined
  simp_alive_peephole
  sorry
def partialConstantMemberAliasing3_combined := [llvmfunc|
  llvm.func @partialConstantMemberAliasing3(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1, 2] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.C", (i8, i32, i32)>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_partialConstantMemberAliasing3   : partialConstantMemberAliasing3_before  ⊑  partialConstantMemberAliasing3_combined := by
  unfold partialConstantMemberAliasing3_before partialConstantMemberAliasing3_combined
  simp_alive_peephole
  sorry
