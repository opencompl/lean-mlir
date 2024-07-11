import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  unordered-compare-and-ordered
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fcmp_ord_and_uno_before := [llvmfunc|
  llvm.func @fcmp_ord_and_uno(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "uno" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_ueq_before := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_ugt_before := [llvmfunc|
  llvm.func @fcmp_ord_and_ugt(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_uge_before := [llvmfunc|
  llvm.func @fcmp_ord_and_uge(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_ult_before := [llvmfunc|
  llvm.func @fcmp_ord_and_ult(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_ule_before := [llvmfunc|
  llvm.func @fcmp_ord_and_ule(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ule" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_une_before := [llvmfunc|
  llvm.func @fcmp_ord_and_une(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "une" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_true_before := [llvmfunc|
  llvm.func @fcmp_ord_and_true(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "_true" %arg0, %0 : f16
    %2 = llvm.fcmp "une" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_ueq_vector_before := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %2 = llvm.fcmp "ord" %arg0, %1 : vector<2xf16>
    %3 = llvm.fcmp "ueq" %arg0, %arg1 : vector<2xf16>
    %4 = llvm.and %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def fcmp_ord_and_ueq_different_value0_before := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_different_value0(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ueq" %arg2, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_ueq_different_value1_before := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_different_value1(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ueq" %arg1, %arg2 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_ueq_commute0_before := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_commute0() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.call @foo() : () -> f16
    %2 = llvm.call @foo() : () -> f16
    %3 = llvm.fcmp "ord" %1, %0 : f16
    %4 = llvm.fcmp "ueq" %1, %2 : f16
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def fcmp_ord_and_ueq_commute1_before := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_commute1() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.call @foo() : () -> f16
    %2 = llvm.call @foo() : () -> f16
    %3 = llvm.fcmp "ord" %1, %0 : f16
    %4 = llvm.fcmp "ueq" %1, %2 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def fcmp_oeq_x_x_and_ult_before := [llvmfunc|
  llvm.func @fcmp_oeq_x_x_and_ult(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.fcmp "oeq" %arg0, %arg0 : f16
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f16
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

def fcmp_ord_and_ueq_preserve_flags_before := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_preserve_flags(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16]

    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f16]

    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_ueq_preserve_subset_flags0_before := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_preserve_subset_flags0(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16]

    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf, nsz>} : f16]

    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_ueq_preserve_subset_flags1_before := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_preserve_subset_flags1(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf, nsz>} : f16]

    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f16]

    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_ueq_flags_lhs_before := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_flags_lhs(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16]

    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_ueq_flags_rhs_before := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_flags_rhs(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f16]

    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_fabs_ueq_before := [llvmfunc|
  llvm.func @fcmp_ord_and_fabs_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def fcmp_ord_fabs_and_ueq_before := [llvmfunc|
  llvm.func @fcmp_ord_fabs_and_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "ord" %1, %0 : f16
    %3 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def fcmp_ord_and_fabs_ueq_commute0_before := [llvmfunc|
  llvm.func @fcmp_ord_and_fabs_ueq_commute0() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.call @foo() : () -> f16
    %2 = llvm.call @foo() : () -> f16
    %3 = llvm.intr.fabs(%1)  : (f16) -> f16
    %4 = llvm.fcmp "ord" %1, %0 : f16
    %5 = llvm.fcmp "ueq" %2, %3 : f16
    %6 = llvm.and %4, %5  : i1
    llvm.return %6 : i1
  }]

def fcmp_ord_and_fabs_ueq_commute1_before := [llvmfunc|
  llvm.func @fcmp_ord_and_fabs_ueq_commute1() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.call @foo() : () -> f16
    %2 = llvm.call @foo() : () -> f16
    %3 = llvm.intr.fabs(%1)  : (f16) -> f16
    %4 = llvm.fcmp "ord" %1, %0 : f16
    %5 = llvm.fcmp "ueq" %2, %3 : f16
    %6 = llvm.and %5, %4  : i1
    llvm.return %6 : i1
  }]

def fcmp_ord_and_fabs_ueq_vector_before := [llvmfunc|
  llvm.func @fcmp_ord_and_fabs_ueq_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf16>) -> vector<2xf16>
    %3 = llvm.fcmp "ord" %arg0, %1 : vector<2xf16>
    %4 = llvm.fcmp "ueq" %2, %arg1 : vector<2xf16>
    %5 = llvm.and %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def fcmp_ord_fabs_and_fabs_ueq_before := [llvmfunc|
  llvm.func @fcmp_ord_fabs_and_fabs_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "ord" %1, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def fcmp_ord_and_fneg_ueq_before := [llvmfunc|
  llvm.func @fcmp_ord_and_fneg_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fneg %arg0  : f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def fcmp_ord_fneg_and_ueq_before := [llvmfunc|
  llvm.func @fcmp_ord_fneg_and_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fneg %arg0  : f16
    %2 = llvm.fcmp "ord" %1, %0 : f16
    %3 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def fcmp_ord_fneg_and_fneg_ueq_before := [llvmfunc|
  llvm.func @fcmp_ord_fneg_and_fneg_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fneg %arg0  : f16
    %2 = llvm.fcmp "ord" %1, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def fcmp_ord_and_fneg_fabs_ueq_before := [llvmfunc|
  llvm.func @fcmp_ord_and_fneg_fabs_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fneg %1  : f16
    %3 = llvm.fcmp "ord" %arg0, %0 : f16
    %4 = llvm.fcmp "ueq" %2, %arg1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def fcmp_ord_and_copysign_ueq_before := [llvmfunc|
  llvm.func @fcmp_ord_and_copysign_ueq(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%arg0, %arg2)  : (f16, f16) -> f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def fcmp_copysign_ord_and_ueq_before := [llvmfunc|
  llvm.func @fcmp_copysign_ord_and_ueq(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%arg0, %arg2)  : (f16, f16) -> f16
    %2 = llvm.fcmp "ord" %1, %0 : f16
    %3 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def fcmp_ord_and_copysign_ueq_commute_before := [llvmfunc|
  llvm.func @fcmp_ord_and_copysign_ueq_commute(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%arg0, %arg2)  : (f16, f16) -> f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %arg1, %1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def fcmp_ord_and_copysign_fneg_ueq_before := [llvmfunc|
  llvm.func @fcmp_ord_and_copysign_fneg_ueq(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fneg %arg0  : f16
    %2 = llvm.intr.copysign(%1, %arg2)  : (f16, f16) -> f16
    %3 = llvm.fcmp "ord" %arg0, %0 : f16
    %4 = llvm.fcmp "ueq" %2, %arg1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def fcmp_ord_and_fneg_copysign_ueq_before := [llvmfunc|
  llvm.func @fcmp_ord_and_fneg_copysign_ueq(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%arg0, %arg2)  : (f16, f16) -> f16
    %2 = llvm.fneg %1  : f16
    %3 = llvm.fcmp "ord" %arg0, %0 : f16
    %4 = llvm.fcmp "ueq" %2, %arg1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def fcmp_ord_and_uno_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_uno(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "uno" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_and_uno   : fcmp_ord_and_uno_before  ⊑  fcmp_ord_and_uno_combined := by
  unfold fcmp_ord_and_uno_before fcmp_ord_and_uno_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_ueq_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_and_ueq   : fcmp_ord_and_ueq_before  ⊑  fcmp_ord_and_ueq_combined := by
  unfold fcmp_ord_and_ueq_before fcmp_ord_and_ueq_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_ugt_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_ugt(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_and_ugt   : fcmp_ord_and_ugt_before  ⊑  fcmp_ord_and_ugt_combined := by
  unfold fcmp_ord_and_ugt_before fcmp_ord_and_ugt_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_uge_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_uge(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_and_uge   : fcmp_ord_and_uge_before  ⊑  fcmp_ord_and_uge_combined := by
  unfold fcmp_ord_and_uge_before fcmp_ord_and_uge_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_ult_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_ult(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_and_ult   : fcmp_ord_and_ult_before  ⊑  fcmp_ord_and_ult_combined := by
  unfold fcmp_ord_and_ult_before fcmp_ord_and_ult_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_ule_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_ule(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ule" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_and_ule   : fcmp_ord_and_ule_before  ⊑  fcmp_ord_and_ule_combined := by
  unfold fcmp_ord_and_ule_before fcmp_ord_and_ule_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_une_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_une(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "une" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_and_une   : fcmp_ord_and_une_before  ⊑  fcmp_ord_and_une_combined := by
  unfold fcmp_ord_and_une_before fcmp_ord_and_une_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_true_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_true(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f16
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_ord_and_true   : fcmp_ord_and_true_before  ⊑  fcmp_ord_and_true_combined := by
  unfold fcmp_ord_and_true_before fcmp_ord_and_true_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_ueq_vector_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %2 = llvm.fcmp "ord" %arg0, %1 : vector<2xf16>
    %3 = llvm.fcmp "ueq" %arg0, %arg1 : vector<2xf16>
    %4 = llvm.and %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_fcmp_ord_and_ueq_vector   : fcmp_ord_and_ueq_vector_before  ⊑  fcmp_ord_and_ueq_vector_combined := by
  unfold fcmp_ord_and_ueq_vector_before fcmp_ord_and_ueq_vector_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_ueq_different_value0_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_different_value0(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ueq" %arg2, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_and_ueq_different_value0   : fcmp_ord_and_ueq_different_value0_before  ⊑  fcmp_ord_and_ueq_different_value0_combined := by
  unfold fcmp_ord_and_ueq_different_value0_before fcmp_ord_and_ueq_different_value0_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_ueq_different_value1_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_different_value1(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ueq" %arg1, %arg2 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_and_ueq_different_value1   : fcmp_ord_and_ueq_different_value1_before  ⊑  fcmp_ord_and_ueq_different_value1_combined := by
  unfold fcmp_ord_and_ueq_different_value1_before fcmp_ord_and_ueq_different_value1_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_ueq_commute0_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_commute0() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.call @foo() : () -> f16
    %2 = llvm.call @foo() : () -> f16
    %3 = llvm.fcmp "ord" %1, %0 : f16
    %4 = llvm.fcmp "ueq" %1, %2 : f16
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_fcmp_ord_and_ueq_commute0   : fcmp_ord_and_ueq_commute0_before  ⊑  fcmp_ord_and_ueq_commute0_combined := by
  unfold fcmp_ord_and_ueq_commute0_before fcmp_ord_and_ueq_commute0_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_ueq_commute1_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_commute1() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.call @foo() : () -> f16
    %2 = llvm.call @foo() : () -> f16
    %3 = llvm.fcmp "ord" %1, %0 : f16
    %4 = llvm.fcmp "ueq" %1, %2 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_fcmp_ord_and_ueq_commute1   : fcmp_ord_and_ueq_commute1_before  ⊑  fcmp_ord_and_ueq_commute1_combined := by
  unfold fcmp_ord_and_ueq_commute1_before fcmp_ord_and_ueq_commute1_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_x_x_and_ult_combined := [llvmfunc|
  llvm.func @fcmp_oeq_x_x_and_ult(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_oeq_x_x_and_ult   : fcmp_oeq_x_x_and_ult_before  ⊑  fcmp_oeq_x_x_and_ult_combined := by
  unfold fcmp_oeq_x_x_and_ult_before fcmp_oeq_x_x_and_ult_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_ueq_preserve_flags_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_preserve_flags(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16]

theorem inst_combine_fcmp_ord_and_ueq_preserve_flags   : fcmp_ord_and_ueq_preserve_flags_before  ⊑  fcmp_ord_and_ueq_preserve_flags_combined := by
  unfold fcmp_ord_and_ueq_preserve_flags_before fcmp_ord_and_ueq_preserve_flags_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f16]

theorem inst_combine_fcmp_ord_and_ueq_preserve_flags   : fcmp_ord_and_ueq_preserve_flags_before  ⊑  fcmp_ord_and_ueq_preserve_flags_combined := by
  unfold fcmp_ord_and_ueq_preserve_flags_before fcmp_ord_and_ueq_preserve_flags_combined
  simp_alive_peephole
  sorry
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_and_ueq_preserve_flags   : fcmp_ord_and_ueq_preserve_flags_before  ⊑  fcmp_ord_and_ueq_preserve_flags_combined := by
  unfold fcmp_ord_and_ueq_preserve_flags_before fcmp_ord_and_ueq_preserve_flags_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_ueq_preserve_subset_flags0_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_preserve_subset_flags0(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16]

theorem inst_combine_fcmp_ord_and_ueq_preserve_subset_flags0   : fcmp_ord_and_ueq_preserve_subset_flags0_before  ⊑  fcmp_ord_and_ueq_preserve_subset_flags0_combined := by
  unfold fcmp_ord_and_ueq_preserve_subset_flags0_before fcmp_ord_and_ueq_preserve_subset_flags0_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf, nsz>} : f16]

theorem inst_combine_fcmp_ord_and_ueq_preserve_subset_flags0   : fcmp_ord_and_ueq_preserve_subset_flags0_before  ⊑  fcmp_ord_and_ueq_preserve_subset_flags0_combined := by
  unfold fcmp_ord_and_ueq_preserve_subset_flags0_before fcmp_ord_and_ueq_preserve_subset_flags0_combined
  simp_alive_peephole
  sorry
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_and_ueq_preserve_subset_flags0   : fcmp_ord_and_ueq_preserve_subset_flags0_before  ⊑  fcmp_ord_and_ueq_preserve_subset_flags0_combined := by
  unfold fcmp_ord_and_ueq_preserve_subset_flags0_before fcmp_ord_and_ueq_preserve_subset_flags0_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_ueq_preserve_subset_flags1_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_preserve_subset_flags1(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf, nsz>} : f16]

theorem inst_combine_fcmp_ord_and_ueq_preserve_subset_flags1   : fcmp_ord_and_ueq_preserve_subset_flags1_before  ⊑  fcmp_ord_and_ueq_preserve_subset_flags1_combined := by
  unfold fcmp_ord_and_ueq_preserve_subset_flags1_before fcmp_ord_and_ueq_preserve_subset_flags1_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f16]

theorem inst_combine_fcmp_ord_and_ueq_preserve_subset_flags1   : fcmp_ord_and_ueq_preserve_subset_flags1_before  ⊑  fcmp_ord_and_ueq_preserve_subset_flags1_combined := by
  unfold fcmp_ord_and_ueq_preserve_subset_flags1_before fcmp_ord_and_ueq_preserve_subset_flags1_combined
  simp_alive_peephole
  sorry
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_and_ueq_preserve_subset_flags1   : fcmp_ord_and_ueq_preserve_subset_flags1_before  ⊑  fcmp_ord_and_ueq_preserve_subset_flags1_combined := by
  unfold fcmp_ord_and_ueq_preserve_subset_flags1_before fcmp_ord_and_ueq_preserve_subset_flags1_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_ueq_flags_lhs_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_flags_lhs(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16]

theorem inst_combine_fcmp_ord_and_ueq_flags_lhs   : fcmp_ord_and_ueq_flags_lhs_before  ⊑  fcmp_ord_and_ueq_flags_lhs_combined := by
  unfold fcmp_ord_and_ueq_flags_lhs_before fcmp_ord_and_ueq_flags_lhs_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_and_ueq_flags_lhs   : fcmp_ord_and_ueq_flags_lhs_before  ⊑  fcmp_ord_and_ueq_flags_lhs_combined := by
  unfold fcmp_ord_and_ueq_flags_lhs_before fcmp_ord_and_ueq_flags_lhs_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_ueq_flags_rhs_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_ueq_flags_rhs(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f16]

theorem inst_combine_fcmp_ord_and_ueq_flags_rhs   : fcmp_ord_and_ueq_flags_rhs_before  ⊑  fcmp_ord_and_ueq_flags_rhs_combined := by
  unfold fcmp_ord_and_ueq_flags_rhs_before fcmp_ord_and_ueq_flags_rhs_combined
  simp_alive_peephole
  sorry
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_and_ueq_flags_rhs   : fcmp_ord_and_ueq_flags_rhs_before  ⊑  fcmp_ord_and_ueq_flags_rhs_combined := by
  unfold fcmp_ord_and_ueq_flags_rhs_before fcmp_ord_and_ueq_flags_rhs_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_fabs_ueq_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_fabs_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_ord_and_fabs_ueq   : fcmp_ord_and_fabs_ueq_before  ⊑  fcmp_ord_and_fabs_ueq_combined := by
  unfold fcmp_ord_and_fabs_ueq_before fcmp_ord_and_fabs_ueq_combined
  simp_alive_peephole
  sorry
def fcmp_ord_fabs_and_ueq_combined := [llvmfunc|
  llvm.func @fcmp_ord_fabs_and_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_fabs_and_ueq   : fcmp_ord_fabs_and_ueq_before  ⊑  fcmp_ord_fabs_and_ueq_combined := by
  unfold fcmp_ord_fabs_and_ueq_before fcmp_ord_fabs_and_ueq_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_fabs_ueq_commute0_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_fabs_ueq_commute0() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.call @foo() : () -> f16
    %2 = llvm.call @foo() : () -> f16
    %3 = llvm.intr.fabs(%1)  : (f16) -> f16
    %4 = llvm.fcmp "ord" %1, %0 : f16
    %5 = llvm.fcmp "ueq" %2, %3 : f16
    %6 = llvm.and %4, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_fcmp_ord_and_fabs_ueq_commute0   : fcmp_ord_and_fabs_ueq_commute0_before  ⊑  fcmp_ord_and_fabs_ueq_commute0_combined := by
  unfold fcmp_ord_and_fabs_ueq_commute0_before fcmp_ord_and_fabs_ueq_commute0_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_fabs_ueq_commute1_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_fabs_ueq_commute1() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.call @foo() : () -> f16
    %2 = llvm.call @foo() : () -> f16
    %3 = llvm.intr.fabs(%1)  : (f16) -> f16
    %4 = llvm.fcmp "ord" %1, %0 : f16
    %5 = llvm.fcmp "ueq" %2, %3 : f16
    %6 = llvm.and %5, %4  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_fcmp_ord_and_fabs_ueq_commute1   : fcmp_ord_and_fabs_ueq_commute1_before  ⊑  fcmp_ord_and_fabs_ueq_commute1_combined := by
  unfold fcmp_ord_and_fabs_ueq_commute1_before fcmp_ord_and_fabs_ueq_commute1_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_fabs_ueq_vector_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_fabs_ueq_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf16>) -> vector<2xf16>
    %3 = llvm.fcmp "ord" %arg0, %1 : vector<2xf16>
    %4 = llvm.fcmp "ueq" %2, %arg1 : vector<2xf16>
    %5 = llvm.and %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_fcmp_ord_and_fabs_ueq_vector   : fcmp_ord_and_fabs_ueq_vector_before  ⊑  fcmp_ord_and_fabs_ueq_vector_combined := by
  unfold fcmp_ord_and_fabs_ueq_vector_before fcmp_ord_and_fabs_ueq_vector_combined
  simp_alive_peephole
  sorry
def fcmp_ord_fabs_and_fabs_ueq_combined := [llvmfunc|
  llvm.func @fcmp_ord_fabs_and_fabs_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_ord_fabs_and_fabs_ueq   : fcmp_ord_fabs_and_fabs_ueq_before  ⊑  fcmp_ord_fabs_and_fabs_ueq_combined := by
  unfold fcmp_ord_fabs_and_fabs_ueq_before fcmp_ord_fabs_and_fabs_ueq_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_fneg_ueq_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_fneg_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fneg %arg0  : f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_ord_and_fneg_ueq   : fcmp_ord_and_fneg_ueq_before  ⊑  fcmp_ord_and_fneg_ueq_combined := by
  unfold fcmp_ord_and_fneg_ueq_before fcmp_ord_and_fneg_ueq_combined
  simp_alive_peephole
  sorry
def fcmp_ord_fneg_and_ueq_combined := [llvmfunc|
  llvm.func @fcmp_ord_fneg_and_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_fneg_and_ueq   : fcmp_ord_fneg_and_ueq_before  ⊑  fcmp_ord_fneg_and_ueq_combined := by
  unfold fcmp_ord_fneg_and_ueq_before fcmp_ord_fneg_and_ueq_combined
  simp_alive_peephole
  sorry
def fcmp_ord_fneg_and_fneg_ueq_combined := [llvmfunc|
  llvm.func @fcmp_ord_fneg_and_fneg_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fneg %arg0  : f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_ord_fneg_and_fneg_ueq   : fcmp_ord_fneg_and_fneg_ueq_before  ⊑  fcmp_ord_fneg_and_fneg_ueq_combined := by
  unfold fcmp_ord_fneg_and_fneg_ueq_before fcmp_ord_fneg_and_fneg_ueq_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_fneg_fabs_ueq_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_fneg_fabs_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fneg %1  : f16
    %3 = llvm.fcmp "ord" %arg0, %0 : f16
    %4 = llvm.fcmp "ueq" %2, %arg1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_fcmp_ord_and_fneg_fabs_ueq   : fcmp_ord_and_fneg_fabs_ueq_before  ⊑  fcmp_ord_and_fneg_fabs_ueq_combined := by
  unfold fcmp_ord_and_fneg_fabs_ueq_before fcmp_ord_and_fneg_fabs_ueq_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_copysign_ueq_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_copysign_ueq(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%arg0, %arg2)  : (f16, f16) -> f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_ord_and_copysign_ueq   : fcmp_ord_and_copysign_ueq_before  ⊑  fcmp_ord_and_copysign_ueq_combined := by
  unfold fcmp_ord_and_copysign_ueq_before fcmp_ord_and_copysign_ueq_combined
  simp_alive_peephole
  sorry
def fcmp_copysign_ord_and_ueq_combined := [llvmfunc|
  llvm.func @fcmp_copysign_ord_and_ueq(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%arg0, %arg2)  : (f16, f16) -> f16
    %2 = llvm.fcmp "ord" %1, %0 : f16
    %3 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_copysign_ord_and_ueq   : fcmp_copysign_ord_and_ueq_before  ⊑  fcmp_copysign_ord_and_ueq_combined := by
  unfold fcmp_copysign_ord_and_ueq_before fcmp_copysign_ord_and_ueq_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_copysign_ueq_commute_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_copysign_ueq_commute(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%arg0, %arg2)  : (f16, f16) -> f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_ord_and_copysign_ueq_commute   : fcmp_ord_and_copysign_ueq_commute_before  ⊑  fcmp_ord_and_copysign_ueq_commute_combined := by
  unfold fcmp_ord_and_copysign_ueq_commute_before fcmp_ord_and_copysign_ueq_commute_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_copysign_fneg_ueq_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_copysign_fneg_ueq(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%arg0, %arg2)  : (f16, f16) -> f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_ord_and_copysign_fneg_ueq   : fcmp_ord_and_copysign_fneg_ueq_before  ⊑  fcmp_ord_and_copysign_fneg_ueq_combined := by
  unfold fcmp_ord_and_copysign_fneg_ueq_before fcmp_ord_and_copysign_fneg_ueq_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_fneg_copysign_ueq_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_fneg_copysign_ueq(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fneg %arg2  : f16
    %2 = llvm.intr.copysign(%arg0, %1)  : (f16, f16) -> f16
    %3 = llvm.fcmp "ord" %arg0, %0 : f16
    %4 = llvm.fcmp "ueq" %2, %arg1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_fcmp_ord_and_fneg_copysign_ueq   : fcmp_ord_and_fneg_copysign_ueq_before  ⊑  fcmp_ord_and_fneg_copysign_ueq_combined := by
  unfold fcmp_ord_and_fneg_copysign_ueq_before fcmp_ord_and_fneg_copysign_ueq_combined
  simp_alive_peephole
  sorry
