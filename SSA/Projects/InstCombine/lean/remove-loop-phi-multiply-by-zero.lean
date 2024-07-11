import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  remove-loop-phi-multiply-by-zero
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_mul_fast_flags_before := [llvmfunc|
  llvm.func @test_mul_fast_flags(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2(%8 : f64)
  ^bb2(%11: f64):  // pred: ^bb1
    llvm.return %11 : f64
  }]

def test_nsz_nnan_flags_enabled_before := [llvmfunc|
  llvm.func @test_nsz_nnan_flags_enabled(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64]

    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2(%8 : f64)
  ^bb2(%11: f64):  // pred: ^bb1
    llvm.return %11 : f64
  }]

def test_nnan_flag_enabled_before := [llvmfunc|
  llvm.func @test_nnan_flag_enabled(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2(%8 : f64)
  ^bb2(%11: f64):  // pred: ^bb1
    llvm.return %11 : f64
  }]

def test_ninf_flag_enabled_before := [llvmfunc|
  llvm.func @test_ninf_flag_enabled(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<ninf>} : f64]

    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2(%8 : f64)
  ^bb2(%11: f64):  // pred: ^bb1
    llvm.return %11 : f64
  }]

def test_nsz_flag_enabled_before := [llvmfunc|
  llvm.func @test_nsz_flag_enabled(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<nsz>} : f64]

    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2(%8 : f64)
  ^bb2(%11: f64):  // pred: ^bb1
    llvm.return %11 : f64
  }]

def test_phi_initalise_to_non_zero_before := [llvmfunc|
  llvm.func @test_phi_initalise_to_non_zero(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2(%8 : f64)
  ^bb2(%11: f64):  // pred: ^bb1
    llvm.return %11 : f64
  }]

def test_multiple_phi_operands_before := [llvmfunc|
  llvm.func @test_multiple_phi_operands(%arg0: !llvm.ptr, %arg1: i1) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.cond_br %arg1, ^bb2(%0, %1 : i64, f64), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i64, f64)
  ^bb2(%4: i64, %5: f64):  // 3 preds: ^bb0, ^bb1, ^bb2
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb2(%9, %8 : i64, f64), ^bb3(%8 : f64)
  ^bb3(%11: f64):  // pred: ^bb2
    llvm.return %11 : f64
  }]

def test_multiple_phi_operands_with_non_zero_before := [llvmfunc|
  llvm.func @test_multiple_phi_operands_with_non_zero(%arg0: !llvm.ptr, %arg1: i1) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(1000 : i64) : i64
    llvm.cond_br %arg1, ^bb2(%0, %1 : i64, f64), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %2 : i64, f64)
  ^bb2(%5: i64, %6: f64):  // 3 preds: ^bb0, ^bb1, ^bb2
    %7 = llvm.getelementptr inbounds %arg0[%0, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %9 = llvm.fmul %6, %8  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %10 = llvm.add %5, %3  : i64
    %11 = llvm.icmp "ult" %10, %4 : i64
    llvm.cond_br %11, ^bb2(%10, %9 : i64, f64), ^bb3(%9 : f64)
  ^bb3(%12: f64):  // pred: ^bb2
    llvm.return %12 : f64
  }]

def test_int_phi_operands_before := [llvmfunc|
  llvm.func @test_int_phi_operands(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, i32)
  ^bb1(%4: i64, %5: i32):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %8 = llvm.mul %5, %7 overflow<nsw>  : i32
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, i32), ^bb2(%8 : i32)
  ^bb2(%11: i32):  // pred: ^bb1
    llvm.return %11 : i32
  }]

def test_int_phi_operands_initalise_to_non_zero_before := [llvmfunc|
  llvm.func @test_int_phi_operands_initalise_to_non_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, i32)
  ^bb1(%4: i64, %5: i32):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %8 = llvm.mul %5, %7  : i32
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, i32), ^bb2(%8 : i32)
  ^bb2(%11: i32):  // pred: ^bb1
    llvm.return %11 : i32
  }]

def test_multiple_int_phi_operands_before := [llvmfunc|
  llvm.func @test_multiple_int_phi_operands(%arg0: !llvm.ptr, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.cond_br %arg1, ^bb2(%0, %1 : i64, i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i64, i32)
  ^bb2(%4: i64, %5: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    %6 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %8 = llvm.mul %5, %7  : i32
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb2(%9, %8 : i64, i32), ^bb3(%8 : i32)
  ^bb3(%11: i32):  // pred: ^bb2
    llvm.return %11 : i32
  }]

def test_multiple_int_phi_operands_initalise_to_non_zero_before := [llvmfunc|
  llvm.func @test_multiple_int_phi_operands_initalise_to_non_zero(%arg0: !llvm.ptr, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(1000 : i64) : i64
    llvm.cond_br %arg1, ^bb2(%0, %1 : i64, i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %2 : i64, i32)
  ^bb2(%5: i64, %6: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    %7 = llvm.getelementptr inbounds %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %9 = llvm.mul %6, %8  : i32
    %10 = llvm.add %5, %3  : i64
    %11 = llvm.icmp "ult" %10, %4 : i64
    llvm.cond_br %11, ^bb2(%10, %9 : i64, i32), ^bb3(%9 : i32)
  ^bb3(%12: i32):  // pred: ^bb2
    llvm.return %12 : i32
  }]

def test_mul_fast_flags_combined := [llvmfunc|
  llvm.func @test_mul_fast_flags(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(1000 : i64) : i64
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    llvm.br ^bb1(%0 : i64)
  ^bb1(%4: i64):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.add %4, %1  : i64
    %6 = llvm.icmp "ult" %5, %2 : i64
    llvm.cond_br %6, ^bb1(%5 : i64), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %3 : f64
  }]

theorem inst_combine_test_mul_fast_flags   : test_mul_fast_flags_before  ⊑  test_mul_fast_flags_combined := by
  unfold test_mul_fast_flags_before test_mul_fast_flags_combined
  simp_alive_peephole
  sorry
def test_nsz_nnan_flags_enabled_combined := [llvmfunc|
  llvm.func @test_nsz_nnan_flags_enabled(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(1000 : i64) : i64
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    llvm.br ^bb1(%0 : i64)
  ^bb1(%4: i64):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.add %4, %1  : i64
    %6 = llvm.icmp "ult" %5, %2 : i64
    llvm.cond_br %6, ^bb1(%5 : i64), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %3 : f64
  }]

theorem inst_combine_test_nsz_nnan_flags_enabled   : test_nsz_nnan_flags_enabled_before  ⊑  test_nsz_nnan_flags_enabled_combined := by
  unfold test_nsz_nnan_flags_enabled_before test_nsz_nnan_flags_enabled_combined
  simp_alive_peephole
  sorry
def test_nnan_flag_enabled_combined := [llvmfunc|
  llvm.func @test_nnan_flag_enabled(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64]

theorem inst_combine_test_nnan_flag_enabled   : test_nnan_flag_enabled_before  ⊑  test_nnan_flag_enabled_combined := by
  unfold test_nnan_flag_enabled_before test_nnan_flag_enabled_combined
  simp_alive_peephole
  sorry
    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_test_nnan_flag_enabled   : test_nnan_flag_enabled_before  ⊑  test_nnan_flag_enabled_combined := by
  unfold test_nnan_flag_enabled_before test_nnan_flag_enabled_combined
  simp_alive_peephole
  sorry
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %8 : f64
  }]

theorem inst_combine_test_nnan_flag_enabled   : test_nnan_flag_enabled_before  ⊑  test_nnan_flag_enabled_combined := by
  unfold test_nnan_flag_enabled_before test_nnan_flag_enabled_combined
  simp_alive_peephole
  sorry
def test_ninf_flag_enabled_combined := [llvmfunc|
  llvm.func @test_ninf_flag_enabled(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64]

theorem inst_combine_test_ninf_flag_enabled   : test_ninf_flag_enabled_before  ⊑  test_ninf_flag_enabled_combined := by
  unfold test_ninf_flag_enabled_before test_ninf_flag_enabled_combined
  simp_alive_peephole
  sorry
    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<ninf>} : f64]

theorem inst_combine_test_ninf_flag_enabled   : test_ninf_flag_enabled_before  ⊑  test_ninf_flag_enabled_combined := by
  unfold test_ninf_flag_enabled_before test_ninf_flag_enabled_combined
  simp_alive_peephole
  sorry
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %8 : f64
  }]

theorem inst_combine_test_ninf_flag_enabled   : test_ninf_flag_enabled_before  ⊑  test_ninf_flag_enabled_combined := by
  unfold test_ninf_flag_enabled_before test_ninf_flag_enabled_combined
  simp_alive_peephole
  sorry
def test_nsz_flag_enabled_combined := [llvmfunc|
  llvm.func @test_nsz_flag_enabled(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64]

theorem inst_combine_test_nsz_flag_enabled   : test_nsz_flag_enabled_before  ⊑  test_nsz_flag_enabled_combined := by
  unfold test_nsz_flag_enabled_before test_nsz_flag_enabled_combined
  simp_alive_peephole
  sorry
    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<nsz>} : f64]

theorem inst_combine_test_nsz_flag_enabled   : test_nsz_flag_enabled_before  ⊑  test_nsz_flag_enabled_combined := by
  unfold test_nsz_flag_enabled_before test_nsz_flag_enabled_combined
  simp_alive_peephole
  sorry
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %8 : f64
  }]

theorem inst_combine_test_nsz_flag_enabled   : test_nsz_flag_enabled_before  ⊑  test_nsz_flag_enabled_combined := by
  unfold test_nsz_flag_enabled_before test_nsz_flag_enabled_combined
  simp_alive_peephole
  sorry
def test_phi_initalise_to_non_zero_combined := [llvmfunc|
  llvm.func @test_phi_initalise_to_non_zero(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64]

theorem inst_combine_test_phi_initalise_to_non_zero   : test_phi_initalise_to_non_zero_before  ⊑  test_phi_initalise_to_non_zero_combined := by
  unfold test_phi_initalise_to_non_zero_before test_phi_initalise_to_non_zero_combined
  simp_alive_peephole
  sorry
    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_test_phi_initalise_to_non_zero   : test_phi_initalise_to_non_zero_before  ⊑  test_phi_initalise_to_non_zero_combined := by
  unfold test_phi_initalise_to_non_zero_before test_phi_initalise_to_non_zero_combined
  simp_alive_peephole
  sorry
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %8 : f64
  }]

theorem inst_combine_test_phi_initalise_to_non_zero   : test_phi_initalise_to_non_zero_before  ⊑  test_phi_initalise_to_non_zero_combined := by
  unfold test_phi_initalise_to_non_zero_before test_phi_initalise_to_non_zero_combined
  simp_alive_peephole
  sorry
def test_multiple_phi_operands_combined := [llvmfunc|
  llvm.func @test_multiple_phi_operands(%arg0: !llvm.ptr, %arg1: i1) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(999 : i64) : i64
    llvm.cond_br %arg1, ^bb2(%0, %1 : i64, f64), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i64, f64)
  ^bb2(%4: i64, %5: f64):  // 3 preds: ^bb0, ^bb1, ^bb2
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64]

theorem inst_combine_test_multiple_phi_operands   : test_multiple_phi_operands_before  ⊑  test_multiple_phi_operands_combined := by
  unfold test_multiple_phi_operands_before test_multiple_phi_operands_combined
  simp_alive_peephole
  sorry
    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_test_multiple_phi_operands   : test_multiple_phi_operands_before  ⊑  test_multiple_phi_operands_combined := by
  unfold test_multiple_phi_operands_before test_multiple_phi_operands_combined
  simp_alive_peephole
  sorry
    %9 = llvm.add %4, %2 overflow<nsw, nuw>  : i64
    %10 = llvm.icmp "ult" %4, %3 : i64
    llvm.cond_br %10, ^bb2(%9, %8 : i64, f64), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.return %8 : f64
  }]

theorem inst_combine_test_multiple_phi_operands   : test_multiple_phi_operands_before  ⊑  test_multiple_phi_operands_combined := by
  unfold test_multiple_phi_operands_before test_multiple_phi_operands_combined
  simp_alive_peephole
  sorry
def test_multiple_phi_operands_with_non_zero_combined := [llvmfunc|
  llvm.func @test_multiple_phi_operands_with_non_zero(%arg0: !llvm.ptr, %arg1: i1) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(999 : i64) : i64
    llvm.cond_br %arg1, ^bb2(%0, %1 : i64, f64), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %2 : i64, f64)
  ^bb2(%5: i64, %6: f64):  // 3 preds: ^bb0, ^bb1, ^bb2
    %7 = llvm.getelementptr inbounds %arg0[%0, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> f64]

theorem inst_combine_test_multiple_phi_operands_with_non_zero   : test_multiple_phi_operands_with_non_zero_before  ⊑  test_multiple_phi_operands_with_non_zero_combined := by
  unfold test_multiple_phi_operands_with_non_zero_before test_multiple_phi_operands_with_non_zero_combined
  simp_alive_peephole
  sorry
    %9 = llvm.fmul %6, %8  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_test_multiple_phi_operands_with_non_zero   : test_multiple_phi_operands_with_non_zero_before  ⊑  test_multiple_phi_operands_with_non_zero_combined := by
  unfold test_multiple_phi_operands_with_non_zero_before test_multiple_phi_operands_with_non_zero_combined
  simp_alive_peephole
  sorry
    %10 = llvm.add %5, %3 overflow<nsw, nuw>  : i64
    %11 = llvm.icmp "ult" %5, %4 : i64
    llvm.cond_br %11, ^bb2(%10, %9 : i64, f64), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.return %9 : f64
  }]

theorem inst_combine_test_multiple_phi_operands_with_non_zero   : test_multiple_phi_operands_with_non_zero_before  ⊑  test_multiple_phi_operands_with_non_zero_combined := by
  unfold test_multiple_phi_operands_with_non_zero_before test_multiple_phi_operands_with_non_zero_combined
  simp_alive_peephole
  sorry
def test_int_phi_operands_combined := [llvmfunc|
  llvm.func @test_int_phi_operands(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, i32)
  ^bb1(%4: i64, %5: i32):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test_int_phi_operands   : test_int_phi_operands_before  ⊑  test_int_phi_operands_combined := by
  unfold test_int_phi_operands_before test_int_phi_operands_combined
  simp_alive_peephole
  sorry
    %8 = llvm.mul %5, %7 overflow<nsw>  : i32
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %8 : i32
  }]

theorem inst_combine_test_int_phi_operands   : test_int_phi_operands_before  ⊑  test_int_phi_operands_combined := by
  unfold test_int_phi_operands_before test_int_phi_operands_combined
  simp_alive_peephole
  sorry
def test_int_phi_operands_initalise_to_non_zero_combined := [llvmfunc|
  llvm.func @test_int_phi_operands_initalise_to_non_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, i32)
  ^bb1(%4: i64, %5: i32):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test_int_phi_operands_initalise_to_non_zero   : test_int_phi_operands_initalise_to_non_zero_before  ⊑  test_int_phi_operands_initalise_to_non_zero_combined := by
  unfold test_int_phi_operands_initalise_to_non_zero_before test_int_phi_operands_initalise_to_non_zero_combined
  simp_alive_peephole
  sorry
    %8 = llvm.mul %5, %7  : i32
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %8 : i32
  }]

theorem inst_combine_test_int_phi_operands_initalise_to_non_zero   : test_int_phi_operands_initalise_to_non_zero_before  ⊑  test_int_phi_operands_initalise_to_non_zero_combined := by
  unfold test_int_phi_operands_initalise_to_non_zero_before test_int_phi_operands_initalise_to_non_zero_combined
  simp_alive_peephole
  sorry
def test_multiple_int_phi_operands_combined := [llvmfunc|
  llvm.func @test_multiple_int_phi_operands(%arg0: !llvm.ptr, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(999 : i64) : i64
    llvm.cond_br %arg1, ^bb2(%0, %1 : i64, i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i64, i32)
  ^bb2(%4: i64, %5: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    %6 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test_multiple_int_phi_operands   : test_multiple_int_phi_operands_before  ⊑  test_multiple_int_phi_operands_combined := by
  unfold test_multiple_int_phi_operands_before test_multiple_int_phi_operands_combined
  simp_alive_peephole
  sorry
    %8 = llvm.mul %5, %7  : i32
    %9 = llvm.add %4, %2 overflow<nsw, nuw>  : i64
    %10 = llvm.icmp "ult" %4, %3 : i64
    llvm.cond_br %10, ^bb2(%9, %8 : i64, i32), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.return %8 : i32
  }]

theorem inst_combine_test_multiple_int_phi_operands   : test_multiple_int_phi_operands_before  ⊑  test_multiple_int_phi_operands_combined := by
  unfold test_multiple_int_phi_operands_before test_multiple_int_phi_operands_combined
  simp_alive_peephole
  sorry
def test_multiple_int_phi_operands_initalise_to_non_zero_combined := [llvmfunc|
  llvm.func @test_multiple_int_phi_operands_initalise_to_non_zero(%arg0: !llvm.ptr, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(999 : i64) : i64
    llvm.cond_br %arg1, ^bb2(%0, %1 : i64, i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %2 : i64, i32)
  ^bb2(%5: i64, %6: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    %7 = llvm.getelementptr inbounds %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test_multiple_int_phi_operands_initalise_to_non_zero   : test_multiple_int_phi_operands_initalise_to_non_zero_before  ⊑  test_multiple_int_phi_operands_initalise_to_non_zero_combined := by
  unfold test_multiple_int_phi_operands_initalise_to_non_zero_before test_multiple_int_phi_operands_initalise_to_non_zero_combined
  simp_alive_peephole
  sorry
    %9 = llvm.mul %6, %8  : i32
    %10 = llvm.add %5, %3 overflow<nsw, nuw>  : i64
    %11 = llvm.icmp "ult" %5, %4 : i64
    llvm.cond_br %11, ^bb2(%10, %9 : i64, i32), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.return %9 : i32
  }]

theorem inst_combine_test_multiple_int_phi_operands_initalise_to_non_zero   : test_multiple_int_phi_operands_initalise_to_non_zero_before  ⊑  test_multiple_int_phi_operands_initalise_to_non_zero_combined := by
  unfold test_multiple_int_phi_operands_initalise_to_non_zero_before test_multiple_int_phi_operands_initalise_to_non_zero_combined
  simp_alive_peephole
  sorry
