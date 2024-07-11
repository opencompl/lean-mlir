import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-of-xor-x
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_xor1_before := [llvmfunc|
  llvm.func @test_xor1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %arg1  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "slt" %2, %3 : i8
    llvm.return %4 : i1
  }]

def test_xor2_before := [llvmfunc|
  llvm.func @test_xor2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %arg0  : i8
    %4 = llvm.icmp "sle" %1, %3 : i8
    llvm.return %4 : i1
  }]

def test_xor3_before := [llvmfunc|
  llvm.func @test_xor3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.icmp "sgt" %1, %3 : i8
    llvm.return %4 : i1
  }]

def test_xor_ne_before := [llvmfunc|
  llvm.func @test_xor_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %2, %arg0  : i8
    %4 = llvm.icmp "ne" %1, %3 : i8
    llvm.return %4 : i1
  }]

def test_xor_eq_before := [llvmfunc|
  llvm.func @test_xor_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %2, %arg0  : i8
    %4 = llvm.icmp "eq" %1, %3 : i8
    llvm.return %4 : i1
  }]

def test_xor4_before := [llvmfunc|
  llvm.func @test_xor4(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.icmp "sge" %3, %1 : i8
    llvm.return %4 : i1
  }]

def test_xor5_before := [llvmfunc|
  llvm.func @test_xor5(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    llvm.return %4 : i1
  }]

def test_xor6_before := [llvmfunc|
  llvm.func @test_xor6(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.icmp "ule" %3, %1 : i8
    llvm.return %4 : i1
  }]

def test_xor7_before := [llvmfunc|
  llvm.func @test_xor7(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.icmp "ugt" %3, %1 : i8
    llvm.return %4 : i1
  }]

def test_xor8_before := [llvmfunc|
  llvm.func @test_xor8(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.icmp "uge" %3, %1 : i8
    llvm.return %4 : i1
  }]

def test_slt_xor_before := [llvmfunc|
  llvm.func @test_slt_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test_sle_xor_before := [llvmfunc|
  llvm.func @test_sle_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.icmp "sle" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test_sgt_xor_before := [llvmfunc|
  llvm.func @test_sgt_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test_sge_xor_before := [llvmfunc|
  llvm.func @test_sge_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "sge" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test_ult_xor_before := [llvmfunc|
  llvm.func @test_ult_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test_ule_xor_before := [llvmfunc|
  llvm.func @test_ule_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "ule" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test_ugt_xor_before := [llvmfunc|
  llvm.func @test_ugt_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test_uge_xor_before := [llvmfunc|
  llvm.func @test_uge_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "uge" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test_xor1_nofold_multi_use_before := [llvmfunc|
  llvm.func @test_xor1_nofold_multi_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %1, %arg1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "slt" %2, %3 : i8
    llvm.return %4 : i1
  }]

def xor_uge_before := [llvmfunc|
  llvm.func @xor_uge(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.icmp "uge" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def xor_uge_fail_maybe_zero_before := [llvmfunc|
  llvm.func @xor_uge_fail_maybe_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.xor %arg0, %arg1  : i8
    %1 = llvm.icmp "uge" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

def xor_ule_2_before := [llvmfunc|
  llvm.func @xor_ule_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[9, 8]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg1, %0  : vector<2xi8>
    %2 = llvm.xor %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "ule" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def xor_sle_2_before := [llvmfunc|
  llvm.func @xor_sle_2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg2  : i8
    %2 = llvm.icmp "ne" %arg1, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.xor %1, %arg1  : i8
    %4 = llvm.icmp "sle" %1, %3 : i8
    llvm.return %4 : i1
  }]

def xor_sge_before := [llvmfunc|
  llvm.func @xor_sge(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.icmp "sge" %1, %3 : i8
    llvm.return %4 : i1
  }]

def xor_ugt_2_before := [llvmfunc|
  llvm.func @xor_ugt_2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.add %arg0, %arg2  : i8
    %3 = llvm.and %arg1, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.xor %2, %4  : i8
    %6 = llvm.icmp "ugt" %2, %5 : i8
    llvm.return %6 : i1
  }]

def xor_ult_before := [llvmfunc|
  llvm.func @xor_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def xor_sgt_before := [llvmfunc|
  llvm.func @xor_sgt(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<64> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.or %2, %1  : vector<2xi8>
    %4 = llvm.xor %arg0, %3  : vector<2xi8>
    %5 = llvm.icmp "sgt" %4, %arg0 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

def xor_sgt_fail_no_known_msb_before := [llvmfunc|
  llvm.func @xor_sgt_fail_no_known_msb(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<63> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.or %2, %1  : vector<2xi8>
    %4 = llvm.xor %arg0, %3  : vector<2xi8>
    %5 = llvm.icmp "sgt" %4, %arg0 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

def xor_slt_2_before := [llvmfunc|
  llvm.func @xor_slt_2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(88 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.icmp "slt" %arg0, %1 : i8
    llvm.return %2 : i1
  }]

def xor_sgt_intmin_2_before := [llvmfunc|
  llvm.func @xor_sgt_intmin_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %arg2  : vector<2xi8>
    %2 = llvm.or %arg1, %0  : vector<2xi8>
    %3 = llvm.xor %1, %2  : vector<2xi8>
    %4 = llvm.icmp "sgt" %1, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def or_slt_intmin_indirect_before := [llvmfunc|
  llvm.func @or_slt_intmin_indirect(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg1, %0 : i8
    llvm.cond_br %2, ^bb2, ^bb3
  ^bb1(%3: i1):  // 2 preds: ^bb2, ^bb3
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %4 = llvm.xor %arg1, %arg0  : i8
    %5 = llvm.icmp "slt" %4, %arg0 : i8
    llvm.br ^bb1(%5 : i1)
  ^bb3:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.br ^bb1(%1 : i1)
  }]

def test_xor1_combined := [llvmfunc|
  llvm.func @test_xor1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.icmp "sgt" %2, %arg2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_test_xor1   : test_xor1_before  ⊑  test_xor1_combined := by
  unfold test_xor1_before test_xor1_combined
  simp_alive_peephole
  sorry
def test_xor2_combined := [llvmfunc|
  llvm.func @test_xor2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %arg0  : i8
    %3 = llvm.icmp "sle" %2, %arg2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_test_xor2   : test_xor2_before  ⊑  test_xor2_combined := by
  unfold test_xor2_before test_xor2_combined
  simp_alive_peephole
  sorry
def test_xor3_combined := [llvmfunc|
  llvm.func @test_xor3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.icmp "sgt" %2, %arg2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_test_xor3   : test_xor3_before  ⊑  test_xor3_combined := by
  unfold test_xor3_before test_xor3_combined
  simp_alive_peephole
  sorry
def test_xor_ne_combined := [llvmfunc|
  llvm.func @test_xor_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.xor %arg1, %arg0  : i8
    %1 = llvm.icmp "ne" %0, %arg2 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_xor_ne   : test_xor_ne_before  ⊑  test_xor_ne_combined := by
  unfold test_xor_ne_before test_xor_ne_combined
  simp_alive_peephole
  sorry
def test_xor_eq_combined := [llvmfunc|
  llvm.func @test_xor_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.xor %arg1, %arg0  : i8
    %1 = llvm.icmp "eq" %0, %arg2 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_xor_eq   : test_xor_eq_before  ⊑  test_xor_eq_combined := by
  unfold test_xor_eq_before test_xor_eq_combined
  simp_alive_peephole
  sorry
def test_xor4_combined := [llvmfunc|
  llvm.func @test_xor4(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.icmp "sle" %2, %arg2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_test_xor4   : test_xor4_before  ⊑  test_xor4_combined := by
  unfold test_xor4_before test_xor4_combined
  simp_alive_peephole
  sorry
def test_xor5_combined := [llvmfunc|
  llvm.func @test_xor5(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.icmp "ugt" %2, %arg2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_test_xor5   : test_xor5_before  ⊑  test_xor5_combined := by
  unfold test_xor5_before test_xor5_combined
  simp_alive_peephole
  sorry
def test_xor6_combined := [llvmfunc|
  llvm.func @test_xor6(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.icmp "uge" %2, %arg2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_test_xor6   : test_xor6_before  ⊑  test_xor6_combined := by
  unfold test_xor6_before test_xor6_combined
  simp_alive_peephole
  sorry
def test_xor7_combined := [llvmfunc|
  llvm.func @test_xor7(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.icmp "ult" %2, %arg2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_test_xor7   : test_xor7_before  ⊑  test_xor7_combined := by
  unfold test_xor7_before test_xor7_combined
  simp_alive_peephole
  sorry
def test_xor8_combined := [llvmfunc|
  llvm.func @test_xor8(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.icmp "ule" %2, %arg2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_test_xor8   : test_xor8_before  ⊑  test_xor8_combined := by
  unfold test_xor8_before test_xor8_combined
  simp_alive_peephole
  sorry
def test_slt_xor_combined := [llvmfunc|
  llvm.func @test_slt_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.icmp "sgt" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_slt_xor   : test_slt_xor_before  ⊑  test_slt_xor_combined := by
  unfold test_slt_xor_before test_slt_xor_combined
  simp_alive_peephole
  sorry
def test_sle_xor_combined := [llvmfunc|
  llvm.func @test_sle_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.xor %arg1, %arg0  : i32
    %1 = llvm.icmp "sge" %0, %arg1 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_sle_xor   : test_sle_xor_before  ⊑  test_sle_xor_combined := by
  unfold test_sle_xor_before test_sle_xor_combined
  simp_alive_peephole
  sorry
def test_sgt_xor_combined := [llvmfunc|
  llvm.func @test_sgt_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.icmp "slt" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_sgt_xor   : test_sgt_xor_before  ⊑  test_sgt_xor_combined := by
  unfold test_sgt_xor_before test_sgt_xor_combined
  simp_alive_peephole
  sorry
def test_sge_xor_combined := [llvmfunc|
  llvm.func @test_sge_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.icmp "sle" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_sge_xor   : test_sge_xor_before  ⊑  test_sge_xor_combined := by
  unfold test_sge_xor_before test_sge_xor_combined
  simp_alive_peephole
  sorry
def test_ult_xor_combined := [llvmfunc|
  llvm.func @test_ult_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.icmp "ugt" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_ult_xor   : test_ult_xor_before  ⊑  test_ult_xor_combined := by
  unfold test_ult_xor_before test_ult_xor_combined
  simp_alive_peephole
  sorry
def test_ule_xor_combined := [llvmfunc|
  llvm.func @test_ule_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.icmp "uge" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_ule_xor   : test_ule_xor_before  ⊑  test_ule_xor_combined := by
  unfold test_ule_xor_before test_ule_xor_combined
  simp_alive_peephole
  sorry
def test_ugt_xor_combined := [llvmfunc|
  llvm.func @test_ugt_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.icmp "ult" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_ugt_xor   : test_ugt_xor_before  ⊑  test_ugt_xor_combined := by
  unfold test_ugt_xor_before test_ugt_xor_combined
  simp_alive_peephole
  sorry
def test_uge_xor_combined := [llvmfunc|
  llvm.func @test_uge_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.icmp "ule" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_uge_xor   : test_uge_xor_before  ⊑  test_uge_xor_combined := by
  unfold test_uge_xor_before test_uge_xor_combined
  simp_alive_peephole
  sorry
def test_xor1_nofold_multi_use_combined := [llvmfunc|
  llvm.func @test_xor1_nofold_multi_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %arg2, %0  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_test_xor1_nofold_multi_use   : test_xor1_nofold_multi_use_before  ⊑  test_xor1_nofold_multi_use_combined := by
  unfold test_xor1_nofold_multi_use_before test_xor1_nofold_multi_use_combined
  simp_alive_peephole
  sorry
def xor_uge_combined := [llvmfunc|
  llvm.func @xor_uge(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.icmp "ugt" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_xor_uge   : xor_uge_before  ⊑  xor_uge_combined := by
  unfold xor_uge_before xor_uge_combined
  simp_alive_peephole
  sorry
def xor_uge_fail_maybe_zero_combined := [llvmfunc|
  llvm.func @xor_uge_fail_maybe_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.xor %arg0, %arg1  : i8
    %1 = llvm.icmp "uge" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_xor_uge_fail_maybe_zero   : xor_uge_fail_maybe_zero_before  ⊑  xor_uge_fail_maybe_zero_combined := by
  unfold xor_uge_fail_maybe_zero_before xor_uge_fail_maybe_zero_combined
  simp_alive_peephole
  sorry
def xor_ule_2_combined := [llvmfunc|
  llvm.func @xor_ule_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[9, 8]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg1, %0  : vector<2xi8>
    %2 = llvm.xor %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "ult" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_xor_ule_2   : xor_ule_2_before  ⊑  xor_ule_2_combined := by
  unfold xor_ule_2_before xor_ule_2_combined
  simp_alive_peephole
  sorry
def xor_sle_2_combined := [llvmfunc|
  llvm.func @xor_sle_2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg2  : i8
    %2 = llvm.icmp "ne" %arg1, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.xor %1, %arg1  : i8
    %4 = llvm.icmp "sgt" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_xor_sle_2   : xor_sle_2_before  ⊑  xor_sle_2_combined := by
  unfold xor_sle_2_before xor_sle_2_combined
  simp_alive_peephole
  sorry
def xor_sge_combined := [llvmfunc|
  llvm.func @xor_sge(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_xor_sge   : xor_sge_before  ⊑  xor_sge_combined := by
  unfold xor_sge_before xor_sge_combined
  simp_alive_peephole
  sorry
def xor_ugt_2_combined := [llvmfunc|
  llvm.func @xor_ugt_2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.add %arg0, %arg2  : i8
    %3 = llvm.and %arg1, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.xor %2, %4  : i8
    %6 = llvm.icmp "ugt" %2, %5 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_xor_ugt_2   : xor_ugt_2_before  ⊑  xor_ugt_2_combined := by
  unfold xor_ugt_2_before xor_ugt_2_combined
  simp_alive_peephole
  sorry
def xor_ult_combined := [llvmfunc|
  llvm.func @xor_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_xor_ult   : xor_ult_before  ⊑  xor_ult_combined := by
  unfold xor_ult_before xor_ult_combined
  simp_alive_peephole
  sorry
def xor_sgt_combined := [llvmfunc|
  llvm.func @xor_sgt(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<64> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.or %2, %1  : vector<2xi8>
    %4 = llvm.xor %3, %arg0  : vector<2xi8>
    %5 = llvm.icmp "sgt" %4, %arg0 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_xor_sgt   : xor_sgt_before  ⊑  xor_sgt_combined := by
  unfold xor_sgt_before xor_sgt_combined
  simp_alive_peephole
  sorry
def xor_sgt_fail_no_known_msb_combined := [llvmfunc|
  llvm.func @xor_sgt_fail_no_known_msb(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<55> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.or %2, %1  : vector<2xi8>
    %4 = llvm.xor %3, %arg0  : vector<2xi8>
    %5 = llvm.icmp "sgt" %4, %arg0 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_xor_sgt_fail_no_known_msb   : xor_sgt_fail_no_known_msb_before  ⊑  xor_sgt_fail_no_known_msb_combined := by
  unfold xor_sgt_fail_no_known_msb_before xor_sgt_fail_no_known_msb_combined
  simp_alive_peephole
  sorry
def xor_slt_2_combined := [llvmfunc|
  llvm.func @xor_slt_2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(88 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.icmp "sgt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_xor_slt_2   : xor_slt_2_before  ⊑  xor_slt_2_combined := by
  unfold xor_slt_2_before xor_slt_2_combined
  simp_alive_peephole
  sorry
def xor_sgt_intmin_2_combined := [llvmfunc|
  llvm.func @xor_sgt_intmin_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %arg2  : vector<2xi8>
    %2 = llvm.or %arg1, %0  : vector<2xi8>
    %3 = llvm.xor %1, %2  : vector<2xi8>
    %4 = llvm.icmp "sgt" %1, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_xor_sgt_intmin_2   : xor_sgt_intmin_2_before  ⊑  xor_sgt_intmin_2_combined := by
  unfold xor_sgt_intmin_2_before xor_sgt_intmin_2_combined
  simp_alive_peephole
  sorry
def or_slt_intmin_indirect_combined := [llvmfunc|
  llvm.func @or_slt_intmin_indirect(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg1, %0 : i8
    llvm.cond_br %2, ^bb2, ^bb3
  ^bb1(%3: i1):  // 2 preds: ^bb2, ^bb3
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %4 = llvm.xor %arg1, %arg0  : i8
    %5 = llvm.icmp "slt" %4, %arg0 : i8
    llvm.br ^bb1(%5 : i1)
  ^bb3:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.br ^bb1(%1 : i1)
  }]

theorem inst_combine_or_slt_intmin_indirect   : or_slt_intmin_indirect_before  ⊑  or_slt_intmin_indirect_combined := by
  unfold or_slt_intmin_indirect_before or_slt_intmin_indirect_combined
  simp_alive_peephole
  sorry
