import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  umulo-square
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def umulov_square_i32_before := [llvmfunc|
  llvm.func @umulov_square_i32(%arg0: i32) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.return %1 : i1
  }]

def umulov_square_i16_before := [llvmfunc|
  llvm.func @umulov_square_i16(%arg0: i16) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg0) : (i16, i16) -> !llvm.struct<(i16, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i16, i1)> 
    llvm.return %1 : i1
  }]

def umulov_square_i13_before := [llvmfunc|
  llvm.func @umulov_square_i13(%arg0: i13) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg0) : (i13, i13) -> !llvm.struct<(i13, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i13, i1)> 
    llvm.return %1 : i1
  }]

def umulov_square_i32_multiuse_before := [llvmfunc|
  llvm.func @umulov_square_i32_multiuse(%arg0: i32) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i1)> 
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %1 : i1
  }]

def smulov_square_i32_before := [llvmfunc|
  llvm.func @smulov_square_i32(%arg0: i32) -> i1 {
    %0 = "llvm.intr.smul.with.overflow"(%arg0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.return %1 : i1
  }]

def umulov_square_i32_combined := [llvmfunc|
  llvm.func @umulov_square_i32(%arg0: i32) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.return %1 : i1
  }]

theorem inst_combine_umulov_square_i32   : umulov_square_i32_before  ⊑  umulov_square_i32_combined := by
  unfold umulov_square_i32_before umulov_square_i32_combined
  simp_alive_peephole
  sorry
def umulov_square_i16_combined := [llvmfunc|
  llvm.func @umulov_square_i16(%arg0: i16) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg0) : (i16, i16) -> !llvm.struct<(i16, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i16, i1)> 
    llvm.return %1 : i1
  }]

theorem inst_combine_umulov_square_i16   : umulov_square_i16_before  ⊑  umulov_square_i16_combined := by
  unfold umulov_square_i16_before umulov_square_i16_combined
  simp_alive_peephole
  sorry
def umulov_square_i13_combined := [llvmfunc|
  llvm.func @umulov_square_i13(%arg0: i13) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg0) : (i13, i13) -> !llvm.struct<(i13, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i13, i1)> 
    llvm.return %1 : i1
  }]

theorem inst_combine_umulov_square_i13   : umulov_square_i13_before  ⊑  umulov_square_i13_combined := by
  unfold umulov_square_i13_before umulov_square_i13_combined
  simp_alive_peephole
  sorry
def umulov_square_i32_multiuse_combined := [llvmfunc|
  llvm.func @umulov_square_i32_multiuse(%arg0: i32) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i1)> 
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_umulov_square_i32_multiuse   : umulov_square_i32_multiuse_before  ⊑  umulov_square_i32_multiuse_combined := by
  unfold umulov_square_i32_multiuse_before umulov_square_i32_multiuse_combined
  simp_alive_peephole
  sorry
def smulov_square_i32_combined := [llvmfunc|
  llvm.func @smulov_square_i32(%arg0: i32) -> i1 {
    %0 = "llvm.intr.smul.with.overflow"(%arg0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.return %1 : i1
  }]

theorem inst_combine_smulov_square_i32   : smulov_square_i32_before  ⊑  smulov_square_i32_combined := by
  unfold smulov_square_i32_before smulov_square_i32_combined
  simp_alive_peephole
  sorry
