import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr27343
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def __isnan_before := [llvmfunc|
  llvm.func @__isnan(%arg0: f32) -> i32 attributes {passthrough = ["alwaysinline", "nounwind", "optsize"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-16777216 : i32) : i32
    %2 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %2 {alignment = 4 : i64} : f32, !llvm.ptr]

    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %4 = llvm.bitcast %3 : f32 to i32
    %5 = llvm.shl %4, %0  : i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }]

def icmp_shl7_before := [llvmfunc|
  llvm.func @icmp_shl7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(4608 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def __isnan_combined := [llvmfunc|
  llvm.func @__isnan(%arg0: f32) -> i32 attributes {passthrough = ["alwaysinline", "nounwind", "optsize"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-16777216 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.icmp "ugt" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine___isnan   : __isnan_before  ⊑  __isnan_combined := by
  unfold __isnan_before __isnan_combined
  simp_alive_peephole
  sorry
def icmp_shl7_combined := [llvmfunc|
  llvm.func @icmp_shl7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(4608 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_shl7   : icmp_shl7_before  ⊑  icmp_shl7_combined := by
  unfold icmp_shl7_before icmp_shl7_combined
  simp_alive_peephole
  sorry
