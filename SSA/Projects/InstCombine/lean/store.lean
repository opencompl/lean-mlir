import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  store
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def store_of_undef_before := [llvmfunc|
  llvm.func @store_of_undef(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def store_of_poison_before := [llvmfunc|
  llvm.func @store_of_poison(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.poison : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def store_into_undef_before := [llvmfunc|
  llvm.func @store_into_undef(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def store_into_null_before := [llvmfunc|
  llvm.func @store_into_null(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(124 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %2 = llvm.add %1, %0  : i32
    llvm.store %2, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def store_at_gep_off_null_inbounds_before := [llvmfunc|
  llvm.func @store_at_gep_off_null_inbounds(%arg0: i64) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.getelementptr inbounds %0[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def store_at_gep_off_null_not_inbounds_before := [llvmfunc|
  llvm.func @store_at_gep_off_null_not_inbounds(%arg0: i64) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.getelementptr %0[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def store_at_gep_off_no_null_opt_before := [llvmfunc|
  llvm.func @store_at_gep_off_no_null_opt(%arg0: i64) attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.getelementptr inbounds %0[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(47 : i32) : i32
    %2 = llvm.mlir.constant(-987654321 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %2, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %1, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %4 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(47 : i32) : i32
    %2 = llvm.mlir.constant(-987654321 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %2, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %4 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(47 : i32) : i32
    %1 = llvm.mlir.constant(-987654321 : i32) : i32
    llvm.store %0, %arg1 {alignment = 1 : i64} : i32, !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %1, %arg1 {alignment = 1 : i64} : i32, !llvm.ptr]

    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(1 : i32) : i32
    llvm.store %0, %arg2 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : i32, !llvm.ptr]

    llvm.br ^bb1(%1 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb2
    %5 = llvm.load %arg2 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32]

    %6 = llvm.icmp "slt" %5, %arg0 : i32
    llvm.cond_br %6, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %7 = llvm.sext %5 : i32 to i64
    %8 = llvm.getelementptr inbounds %arg1[%7] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %2, %8 {alignment = 4 : i64, tbaa = [#tbaa_tag1]} : f32, !llvm.ptr]

    %9 = llvm.load %arg2 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32]

    %10 = llvm.add %9, %3 overflow<nsw>  : i32
    llvm.store %10, %arg2 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : i32, !llvm.ptr]

    llvm.br ^bb1(%10 : i32)
  ^bb3:  // pred: ^bb1
    llvm.return
  }]

def dse1_before := [llvmfunc|
  llvm.func @dse1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def dse2_before := [llvmfunc|
  llvm.func @dse2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def dse3_before := [llvmfunc|
  llvm.func @dse3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def dse4_before := [llvmfunc|
  llvm.func @dse4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def dse5_before := [llvmfunc|
  llvm.func @dse5(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %arg0 atomic seq_cst {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def write_back1_before := [llvmfunc|
  llvm.func @write_back1(%arg0: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def write_back2_before := [llvmfunc|
  llvm.func @write_back2(%arg0: !llvm.ptr) {
    %0 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def write_back3_before := [llvmfunc|
  llvm.func @write_back3(%arg0: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def write_back4_before := [llvmfunc|
  llvm.func @write_back4(%arg0: !llvm.ptr) {
    %0 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def write_back5_before := [llvmfunc|
  llvm.func @write_back5(%arg0: !llvm.ptr) {
    %0 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %0, %arg0 atomic seq_cst {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def write_back6_before := [llvmfunc|
  llvm.func @write_back6(%arg0: !llvm.ptr) {
    %0 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def write_back7_before := [llvmfunc|
  llvm.func @write_back7(%arg0: !llvm.ptr) {
    %0 = llvm.load volatile %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def store_to_constant_before := [llvmfunc|
  llvm.func @store_to_constant() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @Unknown : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def store_to_readonly_noalias_before := [llvmfunc|
  llvm.func @store_to_readonly_noalias(%arg0: !llvm.ptr {llvm.noalias, llvm.readonly}) {
    %0 = llvm.mlir.constant(3 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def store_of_undef_combined := [llvmfunc|
  llvm.func @store_of_undef(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_store_of_undef   : store_of_undef_before  ⊑  store_of_undef_combined := by
  unfold store_of_undef_before store_of_undef_combined
  simp_alive_peephole
  sorry
def store_of_poison_combined := [llvmfunc|
  llvm.func @store_of_poison(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_store_of_poison   : store_of_poison_before  ⊑  store_of_poison_combined := by
  unfold store_of_poison_before store_of_poison_combined
  simp_alive_peephole
  sorry
def store_into_undef_combined := [llvmfunc|
  llvm.func @store_into_undef(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_store_into_undef   : store_into_undef_before  ⊑  store_into_undef_combined := by
  unfold store_into_undef_before store_into_undef_combined
  simp_alive_peephole
  sorry
def store_into_null_combined := [llvmfunc|
  llvm.func @store_into_null(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_store_into_null   : store_into_null_before  ⊑  store_into_null_combined := by
  unfold store_into_null_before store_into_null_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def store_at_gep_off_null_inbounds_combined := [llvmfunc|
  llvm.func @store_at_gep_off_null_inbounds(%arg0: i64) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.poison : i32
    %2 = llvm.getelementptr inbounds %0[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_store_at_gep_off_null_inbounds   : store_at_gep_off_null_inbounds_before  ⊑  store_at_gep_off_null_inbounds_combined := by
  unfold store_at_gep_off_null_inbounds_before store_at_gep_off_null_inbounds_combined
  simp_alive_peephole
  sorry
def store_at_gep_off_null_not_inbounds_combined := [llvmfunc|
  llvm.func @store_at_gep_off_null_not_inbounds(%arg0: i64) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.poison : i32
    %2 = llvm.getelementptr %0[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_store_at_gep_off_null_not_inbounds   : store_at_gep_off_null_not_inbounds_before  ⊑  store_at_gep_off_null_not_inbounds_combined := by
  unfold store_at_gep_off_null_not_inbounds_before store_at_gep_off_null_not_inbounds_combined
  simp_alive_peephole
  sorry
def store_at_gep_off_no_null_opt_combined := [llvmfunc|
  llvm.func @store_at_gep_off_no_null_opt(%arg0: i64) attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.getelementptr inbounds %0[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_store_at_gep_off_no_null_opt   : store_at_gep_off_no_null_opt_before  ⊑  store_at_gep_off_no_null_opt_combined := by
  unfold store_at_gep_off_no_null_opt_before store_at_gep_off_no_null_opt_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(47 : i32) : i32
    %1 = llvm.mlir.constant(-987654321 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(47 : i32) : i32
    %1 = llvm.mlir.constant(-987654321 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(47 : i32) : i32
    %1 = llvm.mlir.constant(-987654321 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    llvm.store %2, %arg1 {alignment = 1 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb2
    llvm.store %3, %arg2 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : i32, !llvm.ptr
    %4 = llvm.icmp "slt" %3, %arg0 : i32
    llvm.cond_br %4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %5 = llvm.sext %3 : i32 to i64
    %6 = llvm.getelementptr inbounds %arg1[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %1, %6 {alignment = 4 : i64, tbaa = [#tbaa_tag1]} : f32, !llvm.ptr
    %7 = llvm.load %arg2 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32
    %8 = llvm.add %7, %2 overflow<nsw>  : i32
    llvm.br ^bb1(%8 : i32)
  ^bb3:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def dse1_combined := [llvmfunc|
  llvm.func @dse1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_dse1   : dse1_before  ⊑  dse1_combined := by
  unfold dse1_before dse1_combined
  simp_alive_peephole
  sorry
def dse2_combined := [llvmfunc|
  llvm.func @dse2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_dse2   : dse2_before  ⊑  dse2_combined := by
  unfold dse2_before dse2_combined
  simp_alive_peephole
  sorry
def dse3_combined := [llvmfunc|
  llvm.func @dse3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_dse3   : dse3_before  ⊑  dse3_combined := by
  unfold dse3_before dse3_combined
  simp_alive_peephole
  sorry
def dse4_combined := [llvmfunc|
  llvm.func @dse4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_dse4   : dse4_before  ⊑  dse4_combined := by
  unfold dse4_before dse4_combined
  simp_alive_peephole
  sorry
def dse5_combined := [llvmfunc|
  llvm.func @dse5(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %arg0 atomic seq_cst {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_dse5   : dse5_before  ⊑  dse5_combined := by
  unfold dse5_before dse5_combined
  simp_alive_peephole
  sorry
def write_back1_combined := [llvmfunc|
  llvm.func @write_back1(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_write_back1   : write_back1_before  ⊑  write_back1_combined := by
  unfold write_back1_before write_back1_combined
  simp_alive_peephole
  sorry
def write_back2_combined := [llvmfunc|
  llvm.func @write_back2(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_write_back2   : write_back2_before  ⊑  write_back2_combined := by
  unfold write_back2_before write_back2_combined
  simp_alive_peephole
  sorry
def write_back3_combined := [llvmfunc|
  llvm.func @write_back3(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_write_back3   : write_back3_before  ⊑  write_back3_combined := by
  unfold write_back3_before write_back3_combined
  simp_alive_peephole
  sorry
def write_back4_combined := [llvmfunc|
  llvm.func @write_back4(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_write_back4   : write_back4_before  ⊑  write_back4_combined := by
  unfold write_back4_before write_back4_combined
  simp_alive_peephole
  sorry
def write_back5_combined := [llvmfunc|
  llvm.func @write_back5(%arg0: !llvm.ptr) {
    %0 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %0, %arg0 atomic seq_cst {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_write_back5   : write_back5_before  ⊑  write_back5_combined := by
  unfold write_back5_before write_back5_combined
  simp_alive_peephole
  sorry
def write_back6_combined := [llvmfunc|
  llvm.func @write_back6(%arg0: !llvm.ptr) {
    %0 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return
  }]

theorem inst_combine_write_back6   : write_back6_before  ⊑  write_back6_combined := by
  unfold write_back6_before write_back6_combined
  simp_alive_peephole
  sorry
def write_back7_combined := [llvmfunc|
  llvm.func @write_back7(%arg0: !llvm.ptr) {
    %0 = llvm.load volatile %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return
  }]

theorem inst_combine_write_back7   : write_back7_before  ⊑  write_back7_combined := by
  unfold write_back7_before write_back7_combined
  simp_alive_peephole
  sorry
def store_to_constant_combined := [llvmfunc|
  llvm.func @store_to_constant() {
    llvm.return
  }]

theorem inst_combine_store_to_constant   : store_to_constant_before  ⊑  store_to_constant_combined := by
  unfold store_to_constant_before store_to_constant_combined
  simp_alive_peephole
  sorry
def store_to_readonly_noalias_combined := [llvmfunc|
  llvm.func @store_to_readonly_noalias(%arg0: !llvm.ptr {llvm.noalias, llvm.readonly}) {
    llvm.return
  }]

theorem inst_combine_store_to_readonly_noalias   : store_to_readonly_noalias_before  ⊑  store_to_readonly_noalias_combined := by
  unfold store_to_readonly_noalias_before store_to_readonly_noalias_combined
  simp_alive_peephole
  sorry
