import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  overflow-mul
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def pr4917_1_before := [llvmfunc|
  llvm.func @pr4917_1(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.mul %1, %2  : i64
    %4 = llvm.icmp "ugt" %3, %0 : i64
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def pr4917_1a_before := [llvmfunc|
  llvm.func @pr4917_1a(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967296 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.mul %1, %2  : i64
    %4 = llvm.icmp "uge" %3, %0 : i64
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def pr4917_2_before := [llvmfunc|
  llvm.func @pr4917_2(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(111 : i32) : i32
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.mul %2, %3  : i64
    %5 = llvm.icmp "ugt" %4, %0 : i64
    %6 = llvm.trunc %4 : i64 to i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.return %7 : i32
  }]

def pr4917_3_before := [llvmfunc|
  llvm.func @pr4917_3(%arg0: i32, %arg1: i32) -> i64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(111 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.mul %2, %3  : i64
    %5 = llvm.icmp "ugt" %4, %0 : i64
    %6 = llvm.select %5, %4, %1 : i1, i64
    llvm.return %6 : i64
  }]

def pr4917_4_before := [llvmfunc|
  llvm.func @pr4917_4(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.mul %1, %2  : i64
    %4 = llvm.icmp "ule" %3, %0 : i64
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def pr4917_4a_before := [llvmfunc|
  llvm.func @pr4917_4a(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967296 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.mul %1, %2  : i64
    %4 = llvm.icmp "ult" %3, %0 : i64
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def pr4917_5_before := [llvmfunc|
  llvm.func @pr4917_5(%arg0: i32, %arg1: i8) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(111 : i32) : i32
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.zext %arg1 : i8 to i64
    %4 = llvm.mul %2, %3  : i64
    %5 = llvm.icmp "ugt" %4, %0 : i64
    %6 = llvm.trunc %4 : i64 to i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.return %7 : i32
  }]

def pr4918_1_before := [llvmfunc|
  llvm.func @pr4918_1(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.mul %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def pr4918_2_before := [llvmfunc|
  llvm.func @pr4918_2(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.mul %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def pr4918_3_before := [llvmfunc|
  llvm.func @pr4918_3(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.mul %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.icmp "ne" %4, %2 : i64
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def pr20113_before := [llvmfunc|
  llvm.func @pr20113(%arg0: vector<4xi16>, %arg1: vector<4xi16>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.zext %arg0 : vector<4xi16> to vector<4xi32>
    %3 = llvm.zext %arg1 : vector<4xi16> to vector<4xi32>
    %4 = llvm.mul %3, %2  : vector<4xi32>
    %5 = llvm.icmp "sge" %4, %1 : vector<4xi32>
    %6 = llvm.sext %5 : vector<4xi1> to vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }]

def pr21445_before := [llvmfunc|
  llvm.func @pr21445(%arg0: i8) -> i1 {
    %0 = llvm.mlir.addressof @pr21445_data : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.zext %arg0 : i8 to i32
    %4 = llvm.zext %1 : i8 to i32
    %5 = llvm.mul %3, %4  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.icmp "ne" %5, %6 : i32
    llvm.return %7 : i1
  }]

def mul_may_overflow_before := [llvmfunc|
  llvm.func @mul_may_overflow(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4294967295 : i34) : i34
    %1 = llvm.zext %arg0 : i32 to i34
    %2 = llvm.zext %arg1 : i32 to i34
    %3 = llvm.mul %1, %2  : i34
    %4 = llvm.icmp "ule" %3, %0 : i34
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def mul_known_nuw_before := [llvmfunc|
  llvm.func @mul_known_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4294967295 : i34) : i34
    %1 = llvm.zext %arg0 : i32 to i34
    %2 = llvm.zext %arg1 : i32 to i34
    %3 = llvm.mul %1, %2 overflow<nuw>  : i34
    %4 = llvm.icmp "ule" %3, %0 : i34
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def extra_and_use_before := [llvmfunc|
  llvm.func @extra_and_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.mul %1, %2  : i64
    %4 = llvm.icmp "ugt" %3, %0 : i64
    %5 = llvm.and %3, %0  : i64
    llvm.call @use.i64(%5) : (i64) -> ()
    %6 = llvm.zext %4 : i1 to i32
    llvm.return %6 : i32
  }]

def extra_and_use_small_mask_before := [llvmfunc|
  llvm.func @extra_and_use_small_mask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(268435455 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.mul %2, %3  : i64
    %5 = llvm.icmp "ugt" %4, %0 : i64
    %6 = llvm.and %4, %1  : i64
    llvm.call @use.i64(%6) : (i64) -> ()
    %7 = llvm.zext %5 : i1 to i32
    llvm.return %7 : i32
  }]

def extra_and_use_mask_too_large_before := [llvmfunc|
  llvm.func @extra_and_use_mask_too_large(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(68719476735 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.mul %2, %3  : i64
    %5 = llvm.icmp "ugt" %4, %0 : i64
    %6 = llvm.and %4, %1  : i64
    llvm.call @use.i64(%6) : (i64) -> ()
    %7 = llvm.zext %5 : i1 to i32
    llvm.return %7 : i32
  }]

def pr4917_1_combined := [llvmfunc|
  llvm.func @pr4917_1(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_pr4917_1   : pr4917_1_before  ⊑  pr4917_1_combined := by
  unfold pr4917_1_before pr4917_1_combined
  simp_alive_peephole
  sorry
def pr4917_1a_combined := [llvmfunc|
  llvm.func @pr4917_1a(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_pr4917_1a   : pr4917_1a_before  ⊑  pr4917_1a_combined := by
  unfold pr4917_1a_before pr4917_1a_combined
  simp_alive_peephole
  sorry
def pr4917_2_combined := [llvmfunc|
  llvm.func @pr4917_2(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(111 : i32) : i32
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.select %3, %2, %0 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_pr4917_2   : pr4917_2_before  ⊑  pr4917_2_combined := by
  unfold pr4917_2_before pr4917_2_combined
  simp_alive_peephole
  sorry
def pr4917_3_combined := [llvmfunc|
  llvm.func @pr4917_3(%arg0: i32, %arg1: i32) -> i64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(111 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.mul %2, %3 overflow<nuw>  : i64
    %5 = llvm.icmp "ugt" %4, %0 : i64
    %6 = llvm.select %5, %4, %1 : i1, i64
    llvm.return %6 : i64
  }]

theorem inst_combine_pr4917_3   : pr4917_3_before  ⊑  pr4917_3_combined := by
  unfold pr4917_3_before pr4917_3_combined
  simp_alive_peephole
  sorry
def pr4917_4_combined := [llvmfunc|
  llvm.func @pr4917_4(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %3 = llvm.xor %2, %0  : i1
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_pr4917_4   : pr4917_4_before  ⊑  pr4917_4_combined := by
  unfold pr4917_4_before pr4917_4_combined
  simp_alive_peephole
  sorry
def pr4917_4a_combined := [llvmfunc|
  llvm.func @pr4917_4a(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %3 = llvm.xor %2, %0  : i1
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_pr4917_4a   : pr4917_4a_before  ⊑  pr4917_4a_combined := by
  unfold pr4917_4a_before pr4917_4a_combined
  simp_alive_peephole
  sorry
def pr4917_5_combined := [llvmfunc|
  llvm.func @pr4917_5(%arg0: i32, %arg1: i8) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(111 : i32) : i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.select %4, %3, %0 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_pr4917_5   : pr4917_5_before  ⊑  pr4917_5_combined := by
  unfold pr4917_5_before pr4917_5_combined
  simp_alive_peephole
  sorry
def pr4918_1_combined := [llvmfunc|
  llvm.func @pr4918_1(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_pr4918_1   : pr4918_1_before  ⊑  pr4918_1_combined := by
  unfold pr4918_1_before pr4918_1_combined
  simp_alive_peephole
  sorry
def pr4918_2_combined := [llvmfunc|
  llvm.func @pr4918_2(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %3 = llvm.xor %2, %0  : i1
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_pr4918_2   : pr4918_2_before  ⊑  pr4918_2_combined := by
  unfold pr4918_2_before pr4918_2_combined
  simp_alive_peephole
  sorry
def pr4918_3_combined := [llvmfunc|
  llvm.func @pr4918_3(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_pr4918_3   : pr4918_3_before  ⊑  pr4918_3_combined := by
  unfold pr4918_3_before pr4918_3_combined
  simp_alive_peephole
  sorry
def pr20113_combined := [llvmfunc|
  llvm.func @pr20113(%arg0: vector<4xi16>, %arg1: vector<4xi16>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.zext %arg0 : vector<4xi16> to vector<4xi32>
    %2 = llvm.zext %arg1 : vector<4xi16> to vector<4xi32>
    %3 = llvm.mul %2, %1 overflow<nuw>  : vector<4xi32>
    %4 = llvm.icmp "sgt" %3, %0 : vector<4xi32>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

theorem inst_combine_pr20113   : pr20113_before  ⊑  pr20113_combined := by
  unfold pr20113_before pr20113_combined
  simp_alive_peephole
  sorry
def pr21445_combined := [llvmfunc|
  llvm.func @pr21445(%arg0: i8) -> i1 {
    %0 = llvm.mlir.addressof @pr21445_data : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i8, i1)> 
    llvm.return %3 : i1
  }]

theorem inst_combine_pr21445   : pr21445_before  ⊑  pr21445_combined := by
  unfold pr21445_before pr21445_combined
  simp_alive_peephole
  sorry
def mul_may_overflow_combined := [llvmfunc|
  llvm.func @mul_may_overflow(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4294967296 : i34) : i34
    %1 = llvm.zext %arg0 : i32 to i34
    %2 = llvm.zext %arg1 : i32 to i34
    %3 = llvm.mul %1, %2  : i34
    %4 = llvm.icmp "ult" %3, %0 : i34
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_mul_may_overflow   : mul_may_overflow_before  ⊑  mul_may_overflow_combined := by
  unfold mul_may_overflow_before mul_may_overflow_combined
  simp_alive_peephole
  sorry
def mul_known_nuw_combined := [llvmfunc|
  llvm.func @mul_known_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %3 = llvm.xor %2, %0  : i1
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_mul_known_nuw   : mul_known_nuw_before  ⊑  mul_known_nuw_combined := by
  unfold mul_known_nuw_before mul_known_nuw_combined
  simp_alive_peephole
  sorry
def extra_and_use_combined := [llvmfunc|
  llvm.func @extra_and_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i1)> 
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.call @use.i64(%2) : (i64) -> ()
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_extra_and_use   : extra_and_use_before  ⊑  extra_and_use_combined := by
  unfold extra_and_use_before extra_and_use_combined
  simp_alive_peephole
  sorry
def extra_and_use_small_mask_combined := [llvmfunc|
  llvm.func @extra_and_use_small_mask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(268435455 : i32) : i32
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    llvm.call @use.i64(%4) : (i64) -> ()
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_extra_and_use_small_mask   : extra_and_use_small_mask_before  ⊑  extra_and_use_small_mask_combined := by
  unfold extra_and_use_small_mask_before extra_and_use_small_mask_combined
  simp_alive_peephole
  sorry
def extra_and_use_mask_too_large_combined := [llvmfunc|
  llvm.func @extra_and_use_mask_too_large(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(68719476735 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.mul %2, %3 overflow<nuw>  : i64
    %5 = llvm.icmp "ugt" %4, %0 : i64
    %6 = llvm.and %4, %1  : i64
    llvm.call @use.i64(%6) : (i64) -> ()
    %7 = llvm.zext %5 : i1 to i32
    llvm.return %7 : i32
  }]

theorem inst_combine_extra_and_use_mask_too_large   : extra_and_use_mask_too_large_before  ⊑  extra_and_use_mask_too_large_combined := by
  unfold extra_and_use_mask_too_large_before extra_and_use_mask_too_large_combined
  simp_alive_peephole
  sorry
