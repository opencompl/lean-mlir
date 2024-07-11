import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  binop-itofp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_ui_ui_i8_add_before := [llvmfunc|
  llvm.func @test_ui_ui_i8_add(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.uitofp %1 : i8 to f16
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

def test_ui_ui_i8_add_fail_overflow_before := [llvmfunc|
  llvm.func @test_ui_ui_i8_add_fail_overflow(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.uitofp %3 : i8 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_ui_ui_i8_add_C_before := [llvmfunc|
  llvm.func @test_ui_ui_i8_add_C(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(1.280000e+02 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_ui_ui_i8_add_C_fail_no_repr_before := [llvmfunc|
  llvm.func @test_ui_ui_i8_add_C_fail_no_repr(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(1.275000e+02 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_ui_ui_i8_add_C_fail_overflow_before := [llvmfunc|
  llvm.func @test_ui_ui_i8_add_C_fail_overflow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(1.290000e+02 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_si_si_i8_add_before := [llvmfunc|
  llvm.func @test_si_si_i8_add(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.sitofp %1 : i8 to f16
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

def test_si_si_i8_add_fail_overflow_before := [llvmfunc|
  llvm.func @test_si_si_i8_add_fail_overflow(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(-65 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_ui_si_i8_add_before := [llvmfunc|
  llvm.func @test_ui_si_i8_add(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.sitofp %1 : i8 to f16
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

def test_ui_si_i8_add_overflow_before := [llvmfunc|
  llvm.func @test_ui_si_i8_add_overflow(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(65 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.uitofp %3 : i8 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_ui_ui_i8_sub_C_before := [llvmfunc|
  llvm.func @test_ui_ui_i8_sub_C(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1.280000e+02 : f16) : f16
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fsub %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_ui_ui_i8_sub_C_fail_overflow_before := [llvmfunc|
  llvm.func @test_ui_ui_i8_sub_C_fail_overflow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(1.280000e+02 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fsub %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_si_si_i8_sub_before := [llvmfunc|
  llvm.func @test_si_si_i8_sub(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_si_si_i8_sub_fail_overflow_before := [llvmfunc|
  llvm.func @test_si_si_i8_sub_fail_overflow(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(-65 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_si_si_i8_sub_C_before := [llvmfunc|
  llvm.func @test_si_si_i8_sub_C(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(-6.400000e+01 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sitofp %2 : i8 to f16
    %4 = llvm.fsub %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_si_si_i8_sub_C_fail_overflow_before := [llvmfunc|
  llvm.func @test_si_si_i8_sub_C_fail_overflow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(65 : i8) : i8
    %1 = llvm.mlir.constant(-6.400000e+01 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sitofp %2 : i8 to f16
    %4 = llvm.fsub %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_ui_si_i8_sub_before := [llvmfunc|
  llvm.func @test_ui_si_i8_sub(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.uitofp %3 : i8 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_ui_si_i8_sub_fail_maybe_sign_before := [llvmfunc|
  llvm.func @test_ui_si_i8_sub_fail_maybe_sign(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_ui_ui_i8_mul_before := [llvmfunc|
  llvm.func @test_ui_ui_i8_mul(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.uitofp %1 : i8 to f16
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.fmul %3, %4  : f16
    llvm.return %5 : f16
  }]

def test_ui_ui_i8_mul_C_before := [llvmfunc|
  llvm.func @test_ui_ui_i8_mul_C(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(1.600000e+01 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_ui_ui_i8_mul_C_fail_overlow_before := [llvmfunc|
  llvm.func @test_ui_ui_i8_mul_C_fail_overlow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(14 : i8) : i8
    %1 = llvm.mlir.constant(1.900000e+01 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_si_si_i8_mul_before := [llvmfunc|
  llvm.func @test_si_si_i8_mul(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i8
    %5 = llvm.or %arg1, %2  : i8
    %6 = llvm.sitofp %4 : i8 to f16
    %7 = llvm.sitofp %5 : i8 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

def test_si_si_i8_mul_fail_maybe_zero_before := [llvmfunc|
  llvm.func @test_si_si_i8_mul_fail_maybe_zero(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fmul %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_si_si_i8_mul_C_fail_no_repr_before := [llvmfunc|
  llvm.func @test_si_si_i8_mul_C_fail_no_repr(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-7.500000e+00 : f16) : f16
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i8
    %5 = llvm.sitofp %4 : i8 to f16
    %6 = llvm.fmul %5, %2  : f16
    llvm.return %6 : f16
  }]

def test_si_si_i8_mul_C_fail_overflow_before := [llvmfunc|
  llvm.func @test_si_si_i8_mul_C_fail_overflow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-1.900000e+01 : f16) : f16
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i8
    %5 = llvm.sitofp %4 : i8 to f16
    %6 = llvm.fmul %5, %2  : f16
    llvm.return %6 : f16
  }]

def test_ui_si_i8_mul_before := [llvmfunc|
  llvm.func @test_ui_si_i8_mul(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.add %5, %1  : i8
    %7 = llvm.sitofp %4 : i8 to f16
    %8 = llvm.uitofp %6 : i8 to f16
    %9 = llvm.fmul %7, %8  : f16
    llvm.return %9 : f16
  }]

def test_ui_si_i8_mul_fail_maybe_zero_before := [llvmfunc|
  llvm.func @test_ui_si_i8_mul_fail_maybe_zero(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.and %arg1, %0  : i8
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.uitofp %4 : i8 to f16
    %7 = llvm.fmul %5, %6  : f16
    llvm.return %7 : f16
  }]

def test_ui_si_i8_mul_fail_signed_before := [llvmfunc|
  llvm.func @test_ui_si_i8_mul_fail_signed(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-4 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.or %arg1, %2  : i8
    %6 = llvm.sitofp %4 : i8 to f16
    %7 = llvm.uitofp %5 : i8 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

def test_ui_ui_i16_add_before := [llvmfunc|
  llvm.func @test_ui_ui_i16_add(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.uitofp %1 : i16 to f16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

def test_ui_ui_i16_add_fail_not_promotable_before := [llvmfunc|
  llvm.func @test_ui_ui_i16_add_fail_not_promotable(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2049 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.uitofp %3 : i16 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_ui_ui_i16_add_C_before := [llvmfunc|
  llvm.func @test_ui_ui_i16_add_C(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(6.348800e+04 : f16) : f16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.uitofp %2 : i16 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_ui_ui_i16_add_C_fail_overflow_before := [llvmfunc|
  llvm.func @test_ui_ui_i16_add_C_fail_overflow(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(6.400000e+04 : f16) : f16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.uitofp %2 : i16 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_si_si_i16_add_before := [llvmfunc|
  llvm.func @test_si_si_i16_add(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.or %arg0, %0  : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.sitofp %1 : i16 to f16
    %4 = llvm.sitofp %2 : i16 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

def test_si_si_i16_add_fail_no_promotion_before := [llvmfunc|
  llvm.func @test_si_si_i16_add_fail_no_promotion(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.sub %2, %1  : i16
    %4 = llvm.or %arg1, %0  : i16
    %5 = llvm.sitofp %3 : i16 to f16
    %6 = llvm.sitofp %4 : i16 to f16
    %7 = llvm.fadd %5, %6  : f16
    llvm.return %7 : f16
  }]

def test_si_si_i16_add_C_overflow_before := [llvmfunc|
  llvm.func @test_si_si_i16_add_C_overflow(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(3.481600e+04 : f16) : f16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.sitofp %2 : i16 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_si_si_i16_sub_before := [llvmfunc|
  llvm.func @test_si_si_i16_sub(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.sitofp %2 : i16 to f16
    %5 = llvm.sitofp %3 : i16 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_si_si_i16_sub_fail_no_promotion_before := [llvmfunc|
  llvm.func @test_si_si_i16_sub_fail_no_promotion(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2049 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.or %arg1, %1  : i16
    %4 = llvm.sitofp %2 : i16 to f16
    %5 = llvm.sitofp %3 : i16 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_ui_si_i16_sub_before := [llvmfunc|
  llvm.func @test_ui_si_i16_sub(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.uitofp %1 : i16 to f16
    %4 = llvm.sitofp %2 : i16 to f16
    %5 = llvm.fsub %3, %4  : f16
    llvm.return %5 : f16
  }]

def test_ui_si_i16_sub_fail_maybe_signed_before := [llvmfunc|
  llvm.func @test_ui_si_i16_sub_fail_maybe_signed(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.sitofp %3 : i16 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_ui_ui_i16_mul_before := [llvmfunc|
  llvm.func @test_ui_ui_i16_mul(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.uitofp %1 : i16 to f16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.fmul %3, %4  : f16
    llvm.return %5 : f16
  }]

def test_ui_ui_i16_mul_fail_no_promotion_before := [llvmfunc|
  llvm.func @test_ui_ui_i16_mul_fail_no_promotion(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(4095 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.uitofp %3 : i16 to f16
    %6 = llvm.fmul %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_si_si_i16_mul_before := [llvmfunc|
  llvm.func @test_si_si_i16_mul(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(126 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.mlir.constant(-255 : i16) : i16
    %3 = llvm.and %arg0, %0  : i16
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i16
    %5 = llvm.or %arg1, %2  : i16
    %6 = llvm.sitofp %4 : i16 to f16
    %7 = llvm.sitofp %5 : i16 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

def test_si_si_i16_mul_fail_overflow_before := [llvmfunc|
  llvm.func @test_si_si_i16_mul_fail_overflow(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(126 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.mlir.constant(-257 : i16) : i16
    %3 = llvm.and %arg0, %0  : i16
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i16
    %5 = llvm.or %arg1, %2  : i16
    %6 = llvm.sitofp %4 : i16 to f16
    %7 = llvm.sitofp %5 : i16 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

def test_si_si_i16_mul_C_fail_overflow_before := [llvmfunc|
  llvm.func @test_si_si_i16_mul_C_fail_overflow(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-129 : i16) : i16
    %1 = llvm.mlir.constant(1.280000e+02 : f16) : f16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.sitofp %2 : i16 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_si_si_i16_mul_C_fail_no_promotion_before := [llvmfunc|
  llvm.func @test_si_si_i16_mul_C_fail_no_promotion(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-4097 : i16) : i16
    %1 = llvm.mlir.constant(5.000000e+00 : f16) : f16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.sitofp %2 : i16 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_ui_si_i16_mul_before := [llvmfunc|
  llvm.func @test_ui_si_i16_mul(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(126 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.add %2, %1  : i16
    %4 = llvm.and %arg1, %0  : i16
    %5 = llvm.add %4, %1  : i16
    %6 = llvm.sitofp %3 : i16 to f16
    %7 = llvm.uitofp %5 : i16 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

def test_ui_ui_i12_add_before := [llvmfunc|
  llvm.func @test_ui_ui_i12_add(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i12) : i12
    %1 = llvm.and %arg0, %0  : i12
    %2 = llvm.and %arg1, %0  : i12
    %3 = llvm.uitofp %1 : i12 to f16
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

def test_ui_ui_i12_add_fail_overflow_before := [llvmfunc|
  llvm.func @test_ui_ui_i12_add_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i12) : i12
    %1 = llvm.mlir.constant(-2047 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.and %arg1, %1  : i12
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.uitofp %3 : i12 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_si_si_i12_add_before := [llvmfunc|
  llvm.func @test_si_si_i12_add(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-1024 : i12) : i12
    %1 = llvm.or %arg0, %0  : i12
    %2 = llvm.or %arg1, %0  : i12
    %3 = llvm.sitofp %1 : i12 to f16
    %4 = llvm.sitofp %2 : i12 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

def test_si_si_i12_add_fail_overflow_before := [llvmfunc|
  llvm.func @test_si_si_i12_add_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-1025 : i12) : i12
    %1 = llvm.or %arg0, %0  : i12
    %2 = llvm.or %arg1, %0  : i12
    %3 = llvm.sitofp %1 : i12 to f16
    %4 = llvm.sitofp %2 : i12 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

def test_si_si_i12_add_C_fail_overflow_before := [llvmfunc|
  llvm.func @test_si_si_i12_add_C_fail_overflow(%arg0: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i12) : i12
    %1 = llvm.mlir.constant(-1.000000e+00 : f16) : f16
    %2 = llvm.or %arg0, %0  : i12
    %3 = llvm.sitofp %2 : i12 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_ui_ui_i12_sub_before := [llvmfunc|
  llvm.func @test_ui_ui_i12_sub(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(1023 : i12) : i12
    %1 = llvm.and %arg0, %0  : i12
    %2 = llvm.and %arg1, %0  : i12
    %3 = llvm.uitofp %1 : i12 to f16
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.fsub %3, %4  : f16
    llvm.return %5 : f16
  }]

def test_ui_ui_i12_sub_fail_overflow_before := [llvmfunc|
  llvm.func @test_ui_ui_i12_sub_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(1023 : i12) : i12
    %1 = llvm.mlir.constant(2047 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.and %arg1, %1  : i12
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.uitofp %3 : i12 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_si_si_i12_sub_before := [llvmfunc|
  llvm.func @test_si_si_i12_sub(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(1023 : i12) : i12
    %1 = llvm.mlir.constant(-1024 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.or %arg1, %1  : i12
    %4 = llvm.sitofp %2 : i12 to f16
    %5 = llvm.sitofp %3 : i12 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_si_si_i12_sub_fail_overflow_before := [llvmfunc|
  llvm.func @test_si_si_i12_sub_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.sitofp %arg0 : i12 to f16
    %1 = llvm.sitofp %arg1 : i12 to f16
    %2 = llvm.fsub %0, %1  : f16
    llvm.return %2 : f16
  }]

def test_ui_ui_i12_mul_before := [llvmfunc|
  llvm.func @test_ui_ui_i12_mul(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(31 : i12) : i12
    %1 = llvm.mlir.constant(63 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.and %arg1, %1  : i12
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.uitofp %3 : i12 to f16
    %6 = llvm.fmul %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_ui_ui_i12_mul_fail_overflow_before := [llvmfunc|
  llvm.func @test_ui_ui_i12_mul_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(31 : i12) : i12
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.mlir.constant(63 : i12) : i12
    %3 = llvm.and %arg0, %0  : i12
    %4 = llvm.add %3, %1  : i12
    %5 = llvm.and %arg1, %2  : i12
    %6 = llvm.uitofp %4 : i12 to f16
    %7 = llvm.uitofp %5 : i12 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

def test_ui_ui_i12_mul_C_before := [llvmfunc|
  llvm.func @test_ui_ui_i12_mul_C(%arg0: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(31 : i12) : i12
    %1 = llvm.mlir.constant(6.400000e+01 : f16) : f16
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.uitofp %2 : i12 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_si_si_i12_mul_before := [llvmfunc|
  llvm.func @test_si_si_i12_mul(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(30 : i12) : i12
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.mlir.constant(-64 : i12) : i12
    %3 = llvm.and %arg0, %0  : i12
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i12
    %5 = llvm.or %arg1, %2  : i12
    %6 = llvm.sitofp %4 : i12 to f16
    %7 = llvm.sitofp %5 : i12 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

def test_si_si_i12_mul_fail_overflow_before := [llvmfunc|
  llvm.func @test_si_si_i12_mul_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(30 : i12) : i12
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.mlir.constant(-128 : i12) : i12
    %3 = llvm.and %arg0, %0  : i12
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i12
    %5 = llvm.or %arg1, %2  : i12
    %6 = llvm.sitofp %4 : i12 to f16
    %7 = llvm.sitofp %5 : i12 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

def test_si_si_i12_mul_fail_maybe_non_zero_before := [llvmfunc|
  llvm.func @test_si_si_i12_mul_fail_maybe_non_zero(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(30 : i12) : i12
    %1 = llvm.mlir.constant(-128 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.or %arg1, %1  : i12
    %4 = llvm.sitofp %2 : i12 to f16
    %5 = llvm.sitofp %3 : i12 to f16
    %6 = llvm.fmul %4, %5  : f16
    llvm.return %6 : f16
  }]

def test_si_si_i12_mul_C_before := [llvmfunc|
  llvm.func @test_si_si_i12_mul_C(%arg0: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-64 : i12) : i12
    %1 = llvm.mlir.constant(-1.600000e+01 : f16) : f16
    %2 = llvm.or %arg0, %0  : i12
    %3 = llvm.sitofp %2 : i12 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_si_si_i12_mul_C_fail_overflow_before := [llvmfunc|
  llvm.func @test_si_si_i12_mul_C_fail_overflow(%arg0: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-64 : i12) : i12
    %1 = llvm.mlir.constant(-6.400000e+01 : f16) : f16
    %2 = llvm.or %arg0, %0  : i12
    %3 = llvm.sitofp %2 : i12 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }]

def test_ui_si_i12_mul_nsw_before := [llvmfunc|
  llvm.func @test_ui_si_i12_mul_nsw(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(31 : i12) : i12
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.mlir.constant(30 : i12) : i12
    %3 = llvm.and %arg0, %0  : i12
    %4 = llvm.add %3, %1  : i12
    %5 = llvm.and %arg1, %2  : i12
    %6 = llvm.add %5, %1  : i12
    %7 = llvm.uitofp %4 : i12 to f16
    %8 = llvm.sitofp %6 : i12 to f16
    %9 = llvm.fmul %7, %8  : f16
    llvm.return %9 : f16
  }]

def test_ui_add_with_signed_constant_before := [llvmfunc|
  llvm.func @test_ui_add_with_signed_constant(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-1.638300e+04 : f32) : f32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.uitofp %2 : i32 to f32
    %4 = llvm.fadd %3, %1  : f32
    llvm.return %4 : f32
  }]

def missed_nonzero_check_on_constant_for_si_fmul_before := [llvmfunc|
  llvm.func @missed_nonzero_check_on_constant_for_si_fmul(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.sitofp %4 : i16 to f32
    %6 = llvm.fmul %5, %2  : f32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %6 : f32
  }]

def missed_nonzero_check_on_constant_for_si_fmul_vec_before := [llvmfunc|
  llvm.func @missed_nonzero_check_on_constant_for_si_fmul_vec(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.poison : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %6 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %7 = llvm.select %arg0, %0, %1 : i1, i32
    %8 = llvm.trunc %7 : i32 to i16
    %9 = llvm.insertelement %8, %2[%3 : i64] : vector<2xi16>
    %10 = llvm.insertelement %8, %9[%4 : i64] : vector<2xi16>
    %11 = llvm.sitofp %10 : vector<2xi16> to vector<2xf32>
    %12 = llvm.fmul %11, %6  : vector<2xf32>
    llvm.store %7, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %12 : vector<2xf32>
  }]

def negzero_check_on_constant_for_si_fmul_before := [llvmfunc|
  llvm.func @negzero_check_on_constant_for_si_fmul(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.sitofp %4 : i16 to f32
    %6 = llvm.fmul %5, %2  : f32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %6 : f32
  }]

def nonzero_check_on_constant_for_si_fmul_vec_w_poison_before := [llvmfunc|
  llvm.func @nonzero_check_on_constant_for_si_fmul_vec_w_poison(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.poison : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %6 = llvm.mlir.poison : f32
    %7 = llvm.mlir.undef : vector<2xf32>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %6, %7[%8 : i32] : vector<2xf32>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %5, %9[%10 : i32] : vector<2xf32>
    %12 = llvm.select %arg0, %0, %1 : i1, i32
    %13 = llvm.trunc %12 : i32 to i16
    %14 = llvm.insertelement %13, %2[%3 : i64] : vector<2xi16>
    %15 = llvm.insertelement %13, %14[%4 : i64] : vector<2xi16>
    %16 = llvm.sitofp %15 : vector<2xi16> to vector<2xf32>
    %17 = llvm.fmul %16, %11  : vector<2xf32>
    llvm.store %12, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %17 : vector<2xf32>
  }]

def nonzero_check_on_constant_for_si_fmul_nz_vec_w_poison_before := [llvmfunc|
  llvm.func @nonzero_check_on_constant_for_si_fmul_nz_vec_w_poison(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.poison : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %6 = llvm.mlir.poison : f32
    %7 = llvm.mlir.undef : vector<2xf32>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %6, %7[%8 : i32] : vector<2xf32>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %5, %9[%10 : i32] : vector<2xf32>
    %12 = llvm.select %arg0, %0, %1 : i1, i32
    %13 = llvm.trunc %12 : i32 to i16
    %14 = llvm.insertelement %13, %2[%3 : i64] : vector<2xi16>
    %15 = llvm.insertelement %13, %14[%4 : i64] : vector<2xi16>
    %16 = llvm.sitofp %15 : vector<2xi16> to vector<2xf32>
    %17 = llvm.fmul %16, %11  : vector<2xf32>
    llvm.store %12, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %17 : vector<2xf32>
  }]

def nonzero_check_on_constant_for_si_fmul_negz_vec_w_poison_before := [llvmfunc|
  llvm.func @nonzero_check_on_constant_for_si_fmul_negz_vec_w_poison(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.poison : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %6 = llvm.mlir.poison : f32
    %7 = llvm.mlir.undef : vector<2xf32>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %6, %7[%8 : i32] : vector<2xf32>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %5, %9[%10 : i32] : vector<2xf32>
    %12 = llvm.select %arg0, %0, %1 : i1, i32
    %13 = llvm.trunc %12 : i32 to i16
    %14 = llvm.insertelement %13, %2[%3 : i64] : vector<2xi16>
    %15 = llvm.insertelement %13, %14[%4 : i64] : vector<2xi16>
    %16 = llvm.sitofp %15 : vector<2xi16> to vector<2xf32>
    %17 = llvm.fmul %16, %11  : vector<2xf32>
    llvm.store %12, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %17 : vector<2xf32>
  }]

def test_ui_ui_i8_add_combined := [llvmfunc|
  llvm.func @test_ui_ui_i8_add(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.uitofp %1 : i8 to f16
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

theorem inst_combine_test_ui_ui_i8_add   : test_ui_ui_i8_add_before  ⊑  test_ui_ui_i8_add_combined := by
  unfold test_ui_ui_i8_add_before test_ui_ui_i8_add_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i8_add_fail_overflow_combined := [llvmfunc|
  llvm.func @test_ui_ui_i8_add_fail_overflow(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.uitofp %3 : i8 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_ui_ui_i8_add_fail_overflow   : test_ui_ui_i8_add_fail_overflow_before  ⊑  test_ui_ui_i8_add_fail_overflow_combined := by
  unfold test_ui_ui_i8_add_fail_overflow_before test_ui_ui_i8_add_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i8_add_C_combined := [llvmfunc|
  llvm.func @test_ui_ui_i8_add_C(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(1.280000e+02 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_ui_ui_i8_add_C   : test_ui_ui_i8_add_C_before  ⊑  test_ui_ui_i8_add_C_combined := by
  unfold test_ui_ui_i8_add_C_before test_ui_ui_i8_add_C_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i8_add_C_fail_no_repr_combined := [llvmfunc|
  llvm.func @test_ui_ui_i8_add_C_fail_no_repr(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(1.275000e+02 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_ui_ui_i8_add_C_fail_no_repr   : test_ui_ui_i8_add_C_fail_no_repr_before  ⊑  test_ui_ui_i8_add_C_fail_no_repr_combined := by
  unfold test_ui_ui_i8_add_C_fail_no_repr_before test_ui_ui_i8_add_C_fail_no_repr_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i8_add_C_fail_overflow_combined := [llvmfunc|
  llvm.func @test_ui_ui_i8_add_C_fail_overflow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(1.290000e+02 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_ui_ui_i8_add_C_fail_overflow   : test_ui_ui_i8_add_C_fail_overflow_before  ⊑  test_ui_ui_i8_add_C_fail_overflow_combined := by
  unfold test_ui_ui_i8_add_C_fail_overflow_before test_ui_ui_i8_add_C_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_si_si_i8_add_combined := [llvmfunc|
  llvm.func @test_si_si_i8_add(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.add %1, %2 overflow<nsw>  : i8
    %4 = llvm.sitofp %3 : i8 to f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_si_si_i8_add   : test_si_si_i8_add_before  ⊑  test_si_si_i8_add_combined := by
  unfold test_si_si_i8_add_before test_si_si_i8_add_combined
  simp_alive_peephole
  sorry
def test_si_si_i8_add_fail_overflow_combined := [llvmfunc|
  llvm.func @test_si_si_i8_add_fail_overflow(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(-65 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_si_si_i8_add_fail_overflow   : test_si_si_i8_add_fail_overflow_before  ⊑  test_si_si_i8_add_fail_overflow_combined := by
  unfold test_si_si_i8_add_fail_overflow_before test_si_si_i8_add_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_ui_si_i8_add_combined := [llvmfunc|
  llvm.func @test_ui_si_i8_add(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.sitofp %1 : i8 to f16
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

theorem inst_combine_test_ui_si_i8_add   : test_ui_si_i8_add_before  ⊑  test_ui_si_i8_add_combined := by
  unfold test_ui_si_i8_add_before test_ui_si_i8_add_combined
  simp_alive_peephole
  sorry
def test_ui_si_i8_add_overflow_combined := [llvmfunc|
  llvm.func @test_ui_si_i8_add_overflow(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(65 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.uitofp %3 : i8 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_ui_si_i8_add_overflow   : test_ui_si_i8_add_overflow_before  ⊑  test_ui_si_i8_add_overflow_combined := by
  unfold test_ui_si_i8_add_overflow_before test_ui_si_i8_add_overflow_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i8_sub_C_combined := [llvmfunc|
  llvm.func @test_ui_ui_i8_sub_C(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-1.280000e+02 : f16) : f16
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_ui_ui_i8_sub_C   : test_ui_ui_i8_sub_C_before  ⊑  test_ui_ui_i8_sub_C_combined := by
  unfold test_ui_ui_i8_sub_C_before test_ui_ui_i8_sub_C_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i8_sub_C_fail_overflow_combined := [llvmfunc|
  llvm.func @test_ui_ui_i8_sub_C_fail_overflow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-1.280000e+02 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_ui_ui_i8_sub_C_fail_overflow   : test_ui_ui_i8_sub_C_fail_overflow_before  ⊑  test_ui_ui_i8_sub_C_fail_overflow_combined := by
  unfold test_ui_ui_i8_sub_C_fail_overflow_before test_ui_ui_i8_sub_C_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_si_si_i8_sub_combined := [llvmfunc|
  llvm.func @test_si_si_i8_sub(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_si_si_i8_sub   : test_si_si_i8_sub_before  ⊑  test_si_si_i8_sub_combined := by
  unfold test_si_si_i8_sub_before test_si_si_i8_sub_combined
  simp_alive_peephole
  sorry
def test_si_si_i8_sub_fail_overflow_combined := [llvmfunc|
  llvm.func @test_si_si_i8_sub_fail_overflow(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(-65 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_si_si_i8_sub_fail_overflow   : test_si_si_i8_sub_fail_overflow_before  ⊑  test_si_si_i8_sub_fail_overflow_combined := by
  unfold test_si_si_i8_sub_fail_overflow_before test_si_si_i8_sub_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_si_si_i8_sub_C_combined := [llvmfunc|
  llvm.func @test_si_si_i8_sub_C(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    %4 = llvm.sitofp %3 : i8 to f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_si_si_i8_sub_C   : test_si_si_i8_sub_C_before  ⊑  test_si_si_i8_sub_C_combined := by
  unfold test_si_si_i8_sub_C_before test_si_si_i8_sub_C_combined
  simp_alive_peephole
  sorry
def test_si_si_i8_sub_C_fail_overflow_combined := [llvmfunc|
  llvm.func @test_si_si_i8_sub_C_fail_overflow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(65 : i8) : i8
    %1 = llvm.mlir.constant(6.400000e+01 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sitofp %2 : i8 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_si_si_i8_sub_C_fail_overflow   : test_si_si_i8_sub_C_fail_overflow_before  ⊑  test_si_si_i8_sub_C_fail_overflow_combined := by
  unfold test_si_si_i8_sub_C_fail_overflow_before test_si_si_i8_sub_C_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_ui_si_i8_sub_combined := [llvmfunc|
  llvm.func @test_ui_si_i8_sub(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.uitofp %3 : i8 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_ui_si_i8_sub   : test_ui_si_i8_sub_before  ⊑  test_ui_si_i8_sub_combined := by
  unfold test_ui_si_i8_sub_before test_ui_si_i8_sub_combined
  simp_alive_peephole
  sorry
def test_ui_si_i8_sub_fail_maybe_sign_combined := [llvmfunc|
  llvm.func @test_ui_si_i8_sub_fail_maybe_sign(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_ui_si_i8_sub_fail_maybe_sign   : test_ui_si_i8_sub_fail_maybe_sign_before  ⊑  test_ui_si_i8_sub_fail_maybe_sign_combined := by
  unfold test_ui_si_i8_sub_fail_maybe_sign_before test_ui_si_i8_sub_fail_maybe_sign_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i8_mul_combined := [llvmfunc|
  llvm.func @test_ui_ui_i8_mul(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.uitofp %1 : i8 to f16
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.fmul %3, %4  : f16
    llvm.return %5 : f16
  }]

theorem inst_combine_test_ui_ui_i8_mul   : test_ui_ui_i8_mul_before  ⊑  test_ui_ui_i8_mul_combined := by
  unfold test_ui_ui_i8_mul_before test_ui_ui_i8_mul_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i8_mul_C_combined := [llvmfunc|
  llvm.func @test_ui_ui_i8_mul_C(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(1.600000e+01 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_ui_ui_i8_mul_C   : test_ui_ui_i8_mul_C_before  ⊑  test_ui_ui_i8_mul_C_combined := by
  unfold test_ui_ui_i8_mul_C_before test_ui_ui_i8_mul_C_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i8_mul_C_fail_overlow_combined := [llvmfunc|
  llvm.func @test_ui_ui_i8_mul_C_fail_overlow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(14 : i8) : i8
    %1 = llvm.mlir.constant(1.900000e+01 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_ui_ui_i8_mul_C_fail_overlow   : test_ui_ui_i8_mul_C_fail_overlow_before  ⊑  test_ui_ui_i8_mul_C_fail_overlow_combined := by
  unfold test_ui_ui_i8_mul_C_fail_overlow_before test_ui_ui_i8_mul_C_fail_overlow_combined
  simp_alive_peephole
  sorry
def test_si_si_i8_mul_combined := [llvmfunc|
  llvm.func @test_si_si_i8_mul(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.or %arg1, %2  : i8
    %6 = llvm.sitofp %4 : i8 to f16
    %7 = llvm.sitofp %5 : i8 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

theorem inst_combine_test_si_si_i8_mul   : test_si_si_i8_mul_before  ⊑  test_si_si_i8_mul_combined := by
  unfold test_si_si_i8_mul_before test_si_si_i8_mul_combined
  simp_alive_peephole
  sorry
def test_si_si_i8_mul_fail_maybe_zero_combined := [llvmfunc|
  llvm.func @test_si_si_i8_mul_fail_maybe_zero(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fmul %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_si_si_i8_mul_fail_maybe_zero   : test_si_si_i8_mul_fail_maybe_zero_before  ⊑  test_si_si_i8_mul_fail_maybe_zero_combined := by
  unfold test_si_si_i8_mul_fail_maybe_zero_before test_si_si_i8_mul_fail_maybe_zero_combined
  simp_alive_peephole
  sorry
def test_si_si_i8_mul_C_fail_no_repr_combined := [llvmfunc|
  llvm.func @test_si_si_i8_mul_C_fail_no_repr(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-7.500000e+00 : f16) : f16
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.sitofp %4 : i8 to f16
    %6 = llvm.fmul %5, %2  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_si_si_i8_mul_C_fail_no_repr   : test_si_si_i8_mul_C_fail_no_repr_before  ⊑  test_si_si_i8_mul_C_fail_no_repr_combined := by
  unfold test_si_si_i8_mul_C_fail_no_repr_before test_si_si_i8_mul_C_fail_no_repr_combined
  simp_alive_peephole
  sorry
def test_si_si_i8_mul_C_fail_overflow_combined := [llvmfunc|
  llvm.func @test_si_si_i8_mul_C_fail_overflow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-1.900000e+01 : f16) : f16
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.sitofp %4 : i8 to f16
    %6 = llvm.fmul %5, %2  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_si_si_i8_mul_C_fail_overflow   : test_si_si_i8_mul_C_fail_overflow_before  ⊑  test_si_si_i8_mul_C_fail_overflow_combined := by
  unfold test_si_si_i8_mul_C_fail_overflow_before test_si_si_i8_mul_C_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_ui_si_i8_mul_combined := [llvmfunc|
  llvm.func @test_ui_si_i8_mul(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.add %5, %1 overflow<nsw, nuw>  : i8
    %7 = llvm.sitofp %4 : i8 to f16
    %8 = llvm.uitofp %6 : i8 to f16
    %9 = llvm.fmul %7, %8  : f16
    llvm.return %9 : f16
  }]

theorem inst_combine_test_ui_si_i8_mul   : test_ui_si_i8_mul_before  ⊑  test_ui_si_i8_mul_combined := by
  unfold test_ui_si_i8_mul_before test_ui_si_i8_mul_combined
  simp_alive_peephole
  sorry
def test_ui_si_i8_mul_fail_maybe_zero_combined := [llvmfunc|
  llvm.func @test_ui_si_i8_mul_fail_maybe_zero(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i8
    %4 = llvm.and %arg1, %0  : i8
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.uitofp %4 : i8 to f16
    %7 = llvm.fmul %5, %6  : f16
    llvm.return %7 : f16
  }]

theorem inst_combine_test_ui_si_i8_mul_fail_maybe_zero   : test_ui_si_i8_mul_fail_maybe_zero_before  ⊑  test_ui_si_i8_mul_fail_maybe_zero_combined := by
  unfold test_ui_si_i8_mul_fail_maybe_zero_before test_ui_si_i8_mul_fail_maybe_zero_combined
  simp_alive_peephole
  sorry
def test_ui_si_i8_mul_fail_signed_combined := [llvmfunc|
  llvm.func @test_ui_si_i8_mul_fail_signed(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-4 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i8
    %5 = llvm.or %arg1, %2  : i8
    %6 = llvm.sitofp %4 : i8 to f16
    %7 = llvm.uitofp %5 : i8 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

theorem inst_combine_test_ui_si_i8_mul_fail_signed   : test_ui_si_i8_mul_fail_signed_before  ⊑  test_ui_si_i8_mul_fail_signed_combined := by
  unfold test_ui_si_i8_mul_fail_signed_before test_ui_si_i8_mul_fail_signed_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i16_add_combined := [llvmfunc|
  llvm.func @test_ui_ui_i16_add(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.uitofp %1 : i16 to f16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

theorem inst_combine_test_ui_ui_i16_add   : test_ui_ui_i16_add_before  ⊑  test_ui_ui_i16_add_combined := by
  unfold test_ui_ui_i16_add_before test_ui_ui_i16_add_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i16_add_fail_not_promotable_combined := [llvmfunc|
  llvm.func @test_ui_ui_i16_add_fail_not_promotable(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2049 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.uitofp %3 : i16 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_ui_ui_i16_add_fail_not_promotable   : test_ui_ui_i16_add_fail_not_promotable_before  ⊑  test_ui_ui_i16_add_fail_not_promotable_combined := by
  unfold test_ui_ui_i16_add_fail_not_promotable_before test_ui_ui_i16_add_fail_not_promotable_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i16_add_C_combined := [llvmfunc|
  llvm.func @test_ui_ui_i16_add_C(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(6.348800e+04 : f16) : f16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.uitofp %2 : i16 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_ui_ui_i16_add_C   : test_ui_ui_i16_add_C_before  ⊑  test_ui_ui_i16_add_C_combined := by
  unfold test_ui_ui_i16_add_C_before test_ui_ui_i16_add_C_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i16_add_C_fail_overflow_combined := [llvmfunc|
  llvm.func @test_ui_ui_i16_add_C_fail_overflow(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(6.400000e+04 : f16) : f16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.uitofp %2 : i16 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_ui_ui_i16_add_C_fail_overflow   : test_ui_ui_i16_add_C_fail_overflow_before  ⊑  test_ui_ui_i16_add_C_fail_overflow_combined := by
  unfold test_ui_ui_i16_add_C_fail_overflow_before test_ui_ui_i16_add_C_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_si_si_i16_add_combined := [llvmfunc|
  llvm.func @test_si_si_i16_add(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.or %arg0, %0  : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.sitofp %1 : i16 to f16
    %4 = llvm.sitofp %2 : i16 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

theorem inst_combine_test_si_si_i16_add   : test_si_si_i16_add_before  ⊑  test_si_si_i16_add_combined := by
  unfold test_si_si_i16_add_before test_si_si_i16_add_combined
  simp_alive_peephole
  sorry
def test_si_si_i16_add_fail_no_promotion_combined := [llvmfunc|
  llvm.func @test_si_si_i16_add_fail_no_promotion(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.add %2, %1 overflow<nsw>  : i16
    %4 = llvm.or %arg1, %0  : i16
    %5 = llvm.sitofp %3 : i16 to f16
    %6 = llvm.sitofp %4 : i16 to f16
    %7 = llvm.fadd %5, %6  : f16
    llvm.return %7 : f16
  }]

theorem inst_combine_test_si_si_i16_add_fail_no_promotion   : test_si_si_i16_add_fail_no_promotion_before  ⊑  test_si_si_i16_add_fail_no_promotion_combined := by
  unfold test_si_si_i16_add_fail_no_promotion_before test_si_si_i16_add_fail_no_promotion_combined
  simp_alive_peephole
  sorry
def test_si_si_i16_add_C_overflow_combined := [llvmfunc|
  llvm.func @test_si_si_i16_add_C_overflow(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(3.481600e+04 : f16) : f16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.sitofp %2 : i16 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_si_si_i16_add_C_overflow   : test_si_si_i16_add_C_overflow_before  ⊑  test_si_si_i16_add_C_overflow_combined := by
  unfold test_si_si_i16_add_C_overflow_before test_si_si_i16_add_C_overflow_combined
  simp_alive_peephole
  sorry
def test_si_si_i16_sub_combined := [llvmfunc|
  llvm.func @test_si_si_i16_sub(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.sitofp %2 : i16 to f16
    %5 = llvm.sitofp %3 : i16 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_si_si_i16_sub   : test_si_si_i16_sub_before  ⊑  test_si_si_i16_sub_combined := by
  unfold test_si_si_i16_sub_before test_si_si_i16_sub_combined
  simp_alive_peephole
  sorry
def test_si_si_i16_sub_fail_no_promotion_combined := [llvmfunc|
  llvm.func @test_si_si_i16_sub_fail_no_promotion(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2049 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.or %arg1, %1  : i16
    %4 = llvm.sitofp %2 : i16 to f16
    %5 = llvm.sitofp %3 : i16 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_si_si_i16_sub_fail_no_promotion   : test_si_si_i16_sub_fail_no_promotion_before  ⊑  test_si_si_i16_sub_fail_no_promotion_combined := by
  unfold test_si_si_i16_sub_fail_no_promotion_before test_si_si_i16_sub_fail_no_promotion_combined
  simp_alive_peephole
  sorry
def test_ui_si_i16_sub_combined := [llvmfunc|
  llvm.func @test_ui_si_i16_sub(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.uitofp %1 : i16 to f16
    %4 = llvm.sitofp %2 : i16 to f16
    %5 = llvm.fsub %3, %4  : f16
    llvm.return %5 : f16
  }]

theorem inst_combine_test_ui_si_i16_sub   : test_ui_si_i16_sub_before  ⊑  test_ui_si_i16_sub_combined := by
  unfold test_ui_si_i16_sub_before test_ui_si_i16_sub_combined
  simp_alive_peephole
  sorry
def test_ui_si_i16_sub_fail_maybe_signed_combined := [llvmfunc|
  llvm.func @test_ui_si_i16_sub_fail_maybe_signed(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.sitofp %3 : i16 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_ui_si_i16_sub_fail_maybe_signed   : test_ui_si_i16_sub_fail_maybe_signed_before  ⊑  test_ui_si_i16_sub_fail_maybe_signed_combined := by
  unfold test_ui_si_i16_sub_fail_maybe_signed_before test_ui_si_i16_sub_fail_maybe_signed_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i16_mul_combined := [llvmfunc|
  llvm.func @test_ui_ui_i16_mul(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.uitofp %1 : i16 to f16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.fmul %3, %4  : f16
    llvm.return %5 : f16
  }]

theorem inst_combine_test_ui_ui_i16_mul   : test_ui_ui_i16_mul_before  ⊑  test_ui_ui_i16_mul_combined := by
  unfold test_ui_ui_i16_mul_before test_ui_ui_i16_mul_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i16_mul_fail_no_promotion_combined := [llvmfunc|
  llvm.func @test_ui_ui_i16_mul_fail_no_promotion(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(4095 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.uitofp %3 : i16 to f16
    %6 = llvm.fmul %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_ui_ui_i16_mul_fail_no_promotion   : test_ui_ui_i16_mul_fail_no_promotion_before  ⊑  test_ui_ui_i16_mul_fail_no_promotion_combined := by
  unfold test_ui_ui_i16_mul_fail_no_promotion_before test_ui_ui_i16_mul_fail_no_promotion_combined
  simp_alive_peephole
  sorry
def test_si_si_i16_mul_combined := [llvmfunc|
  llvm.func @test_si_si_i16_mul(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(126 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.mlir.constant(-255 : i16) : i16
    %3 = llvm.and %arg0, %0  : i16
    %4 = llvm.or %3, %1  : i16
    %5 = llvm.or %arg1, %2  : i16
    %6 = llvm.sitofp %4 : i16 to f16
    %7 = llvm.sitofp %5 : i16 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

theorem inst_combine_test_si_si_i16_mul   : test_si_si_i16_mul_before  ⊑  test_si_si_i16_mul_combined := by
  unfold test_si_si_i16_mul_before test_si_si_i16_mul_combined
  simp_alive_peephole
  sorry
def test_si_si_i16_mul_fail_overflow_combined := [llvmfunc|
  llvm.func @test_si_si_i16_mul_fail_overflow(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(126 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.mlir.constant(-257 : i16) : i16
    %3 = llvm.and %arg0, %0  : i16
    %4 = llvm.or %3, %1  : i16
    %5 = llvm.or %arg1, %2  : i16
    %6 = llvm.sitofp %4 : i16 to f16
    %7 = llvm.sitofp %5 : i16 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

theorem inst_combine_test_si_si_i16_mul_fail_overflow   : test_si_si_i16_mul_fail_overflow_before  ⊑  test_si_si_i16_mul_fail_overflow_combined := by
  unfold test_si_si_i16_mul_fail_overflow_before test_si_si_i16_mul_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_si_si_i16_mul_C_fail_overflow_combined := [llvmfunc|
  llvm.func @test_si_si_i16_mul_C_fail_overflow(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-129 : i16) : i16
    %1 = llvm.mlir.constant(1.280000e+02 : f16) : f16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.sitofp %2 : i16 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_si_si_i16_mul_C_fail_overflow   : test_si_si_i16_mul_C_fail_overflow_before  ⊑  test_si_si_i16_mul_C_fail_overflow_combined := by
  unfold test_si_si_i16_mul_C_fail_overflow_before test_si_si_i16_mul_C_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_si_si_i16_mul_C_fail_no_promotion_combined := [llvmfunc|
  llvm.func @test_si_si_i16_mul_C_fail_no_promotion(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-4097 : i16) : i16
    %1 = llvm.mlir.constant(5.000000e+00 : f16) : f16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.sitofp %2 : i16 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_si_si_i16_mul_C_fail_no_promotion   : test_si_si_i16_mul_C_fail_no_promotion_before  ⊑  test_si_si_i16_mul_C_fail_no_promotion_combined := by
  unfold test_si_si_i16_mul_C_fail_no_promotion_before test_si_si_i16_mul_C_fail_no_promotion_combined
  simp_alive_peephole
  sorry
def test_ui_si_i16_mul_combined := [llvmfunc|
  llvm.func @test_ui_si_i16_mul(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(126 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.or %2, %1  : i16
    %4 = llvm.and %arg1, %0  : i16
    %5 = llvm.or %4, %1  : i16
    %6 = llvm.sitofp %3 : i16 to f16
    %7 = llvm.uitofp %5 : i16 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

theorem inst_combine_test_ui_si_i16_mul   : test_ui_si_i16_mul_before  ⊑  test_ui_si_i16_mul_combined := by
  unfold test_ui_si_i16_mul_before test_ui_si_i16_mul_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i12_add_combined := [llvmfunc|
  llvm.func @test_ui_ui_i12_add(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i12) : i12
    %1 = llvm.and %arg0, %0  : i12
    %2 = llvm.and %arg1, %0  : i12
    %3 = llvm.uitofp %1 : i12 to f16
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

theorem inst_combine_test_ui_ui_i12_add   : test_ui_ui_i12_add_before  ⊑  test_ui_ui_i12_add_combined := by
  unfold test_ui_ui_i12_add_before test_ui_ui_i12_add_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i12_add_fail_overflow_combined := [llvmfunc|
  llvm.func @test_ui_ui_i12_add_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i12) : i12
    %1 = llvm.mlir.constant(-2047 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.and %arg1, %1  : i12
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.uitofp %3 : i12 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_ui_ui_i12_add_fail_overflow   : test_ui_ui_i12_add_fail_overflow_before  ⊑  test_ui_ui_i12_add_fail_overflow_combined := by
  unfold test_ui_ui_i12_add_fail_overflow_before test_ui_ui_i12_add_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_si_si_i12_add_combined := [llvmfunc|
  llvm.func @test_si_si_i12_add(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-1024 : i12) : i12
    %1 = llvm.or %arg0, %0  : i12
    %2 = llvm.or %arg1, %0  : i12
    %3 = llvm.sitofp %1 : i12 to f16
    %4 = llvm.sitofp %2 : i12 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

theorem inst_combine_test_si_si_i12_add   : test_si_si_i12_add_before  ⊑  test_si_si_i12_add_combined := by
  unfold test_si_si_i12_add_before test_si_si_i12_add_combined
  simp_alive_peephole
  sorry
def test_si_si_i12_add_fail_overflow_combined := [llvmfunc|
  llvm.func @test_si_si_i12_add_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-1025 : i12) : i12
    %1 = llvm.or %arg0, %0  : i12
    %2 = llvm.or %arg1, %0  : i12
    %3 = llvm.sitofp %1 : i12 to f16
    %4 = llvm.sitofp %2 : i12 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }]

theorem inst_combine_test_si_si_i12_add_fail_overflow   : test_si_si_i12_add_fail_overflow_before  ⊑  test_si_si_i12_add_fail_overflow_combined := by
  unfold test_si_si_i12_add_fail_overflow_before test_si_si_i12_add_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_si_si_i12_add_C_fail_overflow_combined := [llvmfunc|
  llvm.func @test_si_si_i12_add_C_fail_overflow(%arg0: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i12) : i12
    %1 = llvm.mlir.constant(-1.000000e+00 : f16) : f16
    %2 = llvm.or %arg0, %0  : i12
    %3 = llvm.sitofp %2 : i12 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_si_si_i12_add_C_fail_overflow   : test_si_si_i12_add_C_fail_overflow_before  ⊑  test_si_si_i12_add_C_fail_overflow_combined := by
  unfold test_si_si_i12_add_C_fail_overflow_before test_si_si_i12_add_C_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i12_sub_combined := [llvmfunc|
  llvm.func @test_ui_ui_i12_sub(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(1023 : i12) : i12
    %1 = llvm.and %arg0, %0  : i12
    %2 = llvm.and %arg1, %0  : i12
    %3 = llvm.uitofp %1 : i12 to f16
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.fsub %3, %4  : f16
    llvm.return %5 : f16
  }]

theorem inst_combine_test_ui_ui_i12_sub   : test_ui_ui_i12_sub_before  ⊑  test_ui_ui_i12_sub_combined := by
  unfold test_ui_ui_i12_sub_before test_ui_ui_i12_sub_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i12_sub_fail_overflow_combined := [llvmfunc|
  llvm.func @test_ui_ui_i12_sub_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(1023 : i12) : i12
    %1 = llvm.mlir.constant(2047 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.and %arg1, %1  : i12
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.uitofp %3 : i12 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_ui_ui_i12_sub_fail_overflow   : test_ui_ui_i12_sub_fail_overflow_before  ⊑  test_ui_ui_i12_sub_fail_overflow_combined := by
  unfold test_ui_ui_i12_sub_fail_overflow_before test_ui_ui_i12_sub_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_si_si_i12_sub_combined := [llvmfunc|
  llvm.func @test_si_si_i12_sub(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(1023 : i12) : i12
    %1 = llvm.mlir.constant(-1024 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.or %arg1, %1  : i12
    %4 = llvm.sitofp %2 : i12 to f16
    %5 = llvm.sitofp %3 : i12 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_si_si_i12_sub   : test_si_si_i12_sub_before  ⊑  test_si_si_i12_sub_combined := by
  unfold test_si_si_i12_sub_before test_si_si_i12_sub_combined
  simp_alive_peephole
  sorry
def test_si_si_i12_sub_fail_overflow_combined := [llvmfunc|
  llvm.func @test_si_si_i12_sub_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.sitofp %arg0 : i12 to f16
    %1 = llvm.sitofp %arg1 : i12 to f16
    %2 = llvm.fsub %0, %1  : f16
    llvm.return %2 : f16
  }]

theorem inst_combine_test_si_si_i12_sub_fail_overflow   : test_si_si_i12_sub_fail_overflow_before  ⊑  test_si_si_i12_sub_fail_overflow_combined := by
  unfold test_si_si_i12_sub_fail_overflow_before test_si_si_i12_sub_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i12_mul_combined := [llvmfunc|
  llvm.func @test_ui_ui_i12_mul(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(31 : i12) : i12
    %1 = llvm.mlir.constant(63 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.and %arg1, %1  : i12
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.uitofp %3 : i12 to f16
    %6 = llvm.fmul %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_ui_ui_i12_mul   : test_ui_ui_i12_mul_before  ⊑  test_ui_ui_i12_mul_combined := by
  unfold test_ui_ui_i12_mul_before test_ui_ui_i12_mul_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i12_mul_fail_overflow_combined := [llvmfunc|
  llvm.func @test_ui_ui_i12_mul_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(31 : i12) : i12
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.mlir.constant(63 : i12) : i12
    %3 = llvm.and %arg0, %0  : i12
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i12
    %5 = llvm.and %arg1, %2  : i12
    %6 = llvm.uitofp %4 : i12 to f16
    %7 = llvm.uitofp %5 : i12 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

theorem inst_combine_test_ui_ui_i12_mul_fail_overflow   : test_ui_ui_i12_mul_fail_overflow_before  ⊑  test_ui_ui_i12_mul_fail_overflow_combined := by
  unfold test_ui_ui_i12_mul_fail_overflow_before test_ui_ui_i12_mul_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_ui_ui_i12_mul_C_combined := [llvmfunc|
  llvm.func @test_ui_ui_i12_mul_C(%arg0: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(31 : i12) : i12
    %1 = llvm.mlir.constant(6.400000e+01 : f16) : f16
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.uitofp %2 : i12 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_ui_ui_i12_mul_C   : test_ui_ui_i12_mul_C_before  ⊑  test_ui_ui_i12_mul_C_combined := by
  unfold test_ui_ui_i12_mul_C_before test_ui_ui_i12_mul_C_combined
  simp_alive_peephole
  sorry
def test_si_si_i12_mul_combined := [llvmfunc|
  llvm.func @test_si_si_i12_mul(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(30 : i12) : i12
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.mlir.constant(-64 : i12) : i12
    %3 = llvm.and %arg0, %0  : i12
    %4 = llvm.or %3, %1  : i12
    %5 = llvm.or %arg1, %2  : i12
    %6 = llvm.sitofp %4 : i12 to f16
    %7 = llvm.sitofp %5 : i12 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

theorem inst_combine_test_si_si_i12_mul   : test_si_si_i12_mul_before  ⊑  test_si_si_i12_mul_combined := by
  unfold test_si_si_i12_mul_before test_si_si_i12_mul_combined
  simp_alive_peephole
  sorry
def test_si_si_i12_mul_fail_overflow_combined := [llvmfunc|
  llvm.func @test_si_si_i12_mul_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(30 : i12) : i12
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.mlir.constant(-128 : i12) : i12
    %3 = llvm.and %arg0, %0  : i12
    %4 = llvm.or %3, %1  : i12
    %5 = llvm.or %arg1, %2  : i12
    %6 = llvm.sitofp %4 : i12 to f16
    %7 = llvm.sitofp %5 : i12 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }]

theorem inst_combine_test_si_si_i12_mul_fail_overflow   : test_si_si_i12_mul_fail_overflow_before  ⊑  test_si_si_i12_mul_fail_overflow_combined := by
  unfold test_si_si_i12_mul_fail_overflow_before test_si_si_i12_mul_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_si_si_i12_mul_fail_maybe_non_zero_combined := [llvmfunc|
  llvm.func @test_si_si_i12_mul_fail_maybe_non_zero(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(30 : i12) : i12
    %1 = llvm.mlir.constant(-128 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.or %arg1, %1  : i12
    %4 = llvm.sitofp %2 : i12 to f16
    %5 = llvm.sitofp %3 : i12 to f16
    %6 = llvm.fmul %4, %5  : f16
    llvm.return %6 : f16
  }]

theorem inst_combine_test_si_si_i12_mul_fail_maybe_non_zero   : test_si_si_i12_mul_fail_maybe_non_zero_before  ⊑  test_si_si_i12_mul_fail_maybe_non_zero_combined := by
  unfold test_si_si_i12_mul_fail_maybe_non_zero_before test_si_si_i12_mul_fail_maybe_non_zero_combined
  simp_alive_peephole
  sorry
def test_si_si_i12_mul_C_combined := [llvmfunc|
  llvm.func @test_si_si_i12_mul_C(%arg0: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-64 : i12) : i12
    %1 = llvm.mlir.constant(-1.600000e+01 : f16) : f16
    %2 = llvm.or %arg0, %0  : i12
    %3 = llvm.sitofp %2 : i12 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_si_si_i12_mul_C   : test_si_si_i12_mul_C_before  ⊑  test_si_si_i12_mul_C_combined := by
  unfold test_si_si_i12_mul_C_before test_si_si_i12_mul_C_combined
  simp_alive_peephole
  sorry
def test_si_si_i12_mul_C_fail_overflow_combined := [llvmfunc|
  llvm.func @test_si_si_i12_mul_C_fail_overflow(%arg0: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-64 : i12) : i12
    %1 = llvm.mlir.constant(-6.400000e+01 : f16) : f16
    %2 = llvm.or %arg0, %0  : i12
    %3 = llvm.sitofp %2 : i12 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }]

theorem inst_combine_test_si_si_i12_mul_C_fail_overflow   : test_si_si_i12_mul_C_fail_overflow_before  ⊑  test_si_si_i12_mul_C_fail_overflow_combined := by
  unfold test_si_si_i12_mul_C_fail_overflow_before test_si_si_i12_mul_C_fail_overflow_combined
  simp_alive_peephole
  sorry
def test_ui_si_i12_mul_nsw_combined := [llvmfunc|
  llvm.func @test_ui_si_i12_mul_nsw(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(31 : i12) : i12
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.mlir.constant(30 : i12) : i12
    %3 = llvm.and %arg0, %0  : i12
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i12
    %5 = llvm.and %arg1, %2  : i12
    %6 = llvm.or %5, %1  : i12
    %7 = llvm.uitofp %4 : i12 to f16
    %8 = llvm.sitofp %6 : i12 to f16
    %9 = llvm.fmul %7, %8  : f16
    llvm.return %9 : f16
  }]

theorem inst_combine_test_ui_si_i12_mul_nsw   : test_ui_si_i12_mul_nsw_before  ⊑  test_ui_si_i12_mul_nsw_combined := by
  unfold test_ui_si_i12_mul_nsw_before test_ui_si_i12_mul_nsw_combined
  simp_alive_peephole
  sorry
def test_ui_add_with_signed_constant_combined := [llvmfunc|
  llvm.func @test_ui_add_with_signed_constant(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-1.638300e+04 : f32) : f32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.uitofp %2 : i32 to f32
    %4 = llvm.fadd %3, %1  : f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_ui_add_with_signed_constant   : test_ui_add_with_signed_constant_before  ⊑  test_ui_add_with_signed_constant_combined := by
  unfold test_ui_add_with_signed_constant_before test_ui_add_with_signed_constant_combined
  simp_alive_peephole
  sorry
def missed_nonzero_check_on_constant_for_si_fmul_combined := [llvmfunc|
  llvm.func @missed_nonzero_check_on_constant_for_si_fmul(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.sitofp %4 : i16 to f32
    %6 = llvm.fmul %5, %2  : f32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %6 : f32
  }]

theorem inst_combine_missed_nonzero_check_on_constant_for_si_fmul   : missed_nonzero_check_on_constant_for_si_fmul_before  ⊑  missed_nonzero_check_on_constant_for_si_fmul_combined := by
  unfold missed_nonzero_check_on_constant_for_si_fmul_before missed_nonzero_check_on_constant_for_si_fmul_combined
  simp_alive_peephole
  sorry
def missed_nonzero_check_on_constant_for_si_fmul_vec_combined := [llvmfunc|
  llvm.func @missed_nonzero_check_on_constant_for_si_fmul_vec(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.poison : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %5 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %6 = llvm.select %arg0, %0, %1 : i1, i32
    %7 = llvm.trunc %6 : i32 to i16
    %8 = llvm.insertelement %7, %2[%3 : i64] : vector<2xi16>
    %9 = llvm.shufflevector %8, %2 [0, 0] : vector<2xi16> 
    %10 = llvm.sitofp %9 : vector<2xi16> to vector<2xf32>
    %11 = llvm.fmul %10, %5  : vector<2xf32>
    llvm.store %6, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %11 : vector<2xf32>
  }]

theorem inst_combine_missed_nonzero_check_on_constant_for_si_fmul_vec   : missed_nonzero_check_on_constant_for_si_fmul_vec_before  ⊑  missed_nonzero_check_on_constant_for_si_fmul_vec_combined := by
  unfold missed_nonzero_check_on_constant_for_si_fmul_vec_before missed_nonzero_check_on_constant_for_si_fmul_vec_combined
  simp_alive_peephole
  sorry
def negzero_check_on_constant_for_si_fmul_combined := [llvmfunc|
  llvm.func @negzero_check_on_constant_for_si_fmul(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.sitofp %4 : i16 to f32
    %6 = llvm.fmul %5, %2  : f32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %6 : f32
  }]

theorem inst_combine_negzero_check_on_constant_for_si_fmul   : negzero_check_on_constant_for_si_fmul_before  ⊑  negzero_check_on_constant_for_si_fmul_combined := by
  unfold negzero_check_on_constant_for_si_fmul_before negzero_check_on_constant_for_si_fmul_combined
  simp_alive_peephole
  sorry
def nonzero_check_on_constant_for_si_fmul_vec_w_poison_combined := [llvmfunc|
  llvm.func @nonzero_check_on_constant_for_si_fmul_vec_w_poison(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.poison : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %5 = llvm.mlir.poison : f32
    %6 = llvm.mlir.undef : vector<2xf32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %4, %8[%9 : i32] : vector<2xf32>
    %11 = llvm.select %arg0, %0, %1 : i1, i32
    %12 = llvm.trunc %11 : i32 to i16
    %13 = llvm.insertelement %12, %2[%3 : i64] : vector<2xi16>
    %14 = llvm.shufflevector %13, %2 [0, 0] : vector<2xi16> 
    %15 = llvm.sitofp %14 : vector<2xi16> to vector<2xf32>
    %16 = llvm.fmul %15, %10  : vector<2xf32>
    llvm.store %11, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %16 : vector<2xf32>
  }]

theorem inst_combine_nonzero_check_on_constant_for_si_fmul_vec_w_poison   : nonzero_check_on_constant_for_si_fmul_vec_w_poison_before  ⊑  nonzero_check_on_constant_for_si_fmul_vec_w_poison_combined := by
  unfold nonzero_check_on_constant_for_si_fmul_vec_w_poison_before nonzero_check_on_constant_for_si_fmul_vec_w_poison_combined
  simp_alive_peephole
  sorry
def nonzero_check_on_constant_for_si_fmul_nz_vec_w_poison_combined := [llvmfunc|
  llvm.func @nonzero_check_on_constant_for_si_fmul_nz_vec_w_poison(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.poison : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %5 = llvm.mlir.poison : f32
    %6 = llvm.mlir.undef : vector<2xf32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %4, %8[%9 : i32] : vector<2xf32>
    %11 = llvm.select %arg0, %0, %1 : i1, i32
    %12 = llvm.trunc %11 : i32 to i16
    %13 = llvm.insertelement %12, %2[%3 : i64] : vector<2xi16>
    %14 = llvm.shufflevector %13, %2 [0, 0] : vector<2xi16> 
    %15 = llvm.sitofp %14 : vector<2xi16> to vector<2xf32>
    %16 = llvm.fmul %15, %10  : vector<2xf32>
    llvm.store %11, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %16 : vector<2xf32>
  }]

theorem inst_combine_nonzero_check_on_constant_for_si_fmul_nz_vec_w_poison   : nonzero_check_on_constant_for_si_fmul_nz_vec_w_poison_before  ⊑  nonzero_check_on_constant_for_si_fmul_nz_vec_w_poison_combined := by
  unfold nonzero_check_on_constant_for_si_fmul_nz_vec_w_poison_before nonzero_check_on_constant_for_si_fmul_nz_vec_w_poison_combined
  simp_alive_peephole
  sorry
def nonzero_check_on_constant_for_si_fmul_negz_vec_w_poison_combined := [llvmfunc|
  llvm.func @nonzero_check_on_constant_for_si_fmul_negz_vec_w_poison(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.poison : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %5 = llvm.mlir.poison : f32
    %6 = llvm.mlir.undef : vector<2xf32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %4, %8[%9 : i32] : vector<2xf32>
    %11 = llvm.select %arg0, %0, %1 : i1, i32
    %12 = llvm.trunc %11 : i32 to i16
    %13 = llvm.insertelement %12, %2[%3 : i64] : vector<2xi16>
    %14 = llvm.shufflevector %13, %2 [0, 0] : vector<2xi16> 
    %15 = llvm.sitofp %14 : vector<2xi16> to vector<2xf32>
    %16 = llvm.fmul %15, %10  : vector<2xf32>
    llvm.store %11, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %16 : vector<2xf32>
  }]

theorem inst_combine_nonzero_check_on_constant_for_si_fmul_negz_vec_w_poison   : nonzero_check_on_constant_for_si_fmul_negz_vec_w_poison_before  ⊑  nonzero_check_on_constant_for_si_fmul_negz_vec_w_poison_combined := by
  unfold nonzero_check_on_constant_for_si_fmul_negz_vec_w_poison_before nonzero_check_on_constant_for_si_fmul_negz_vec_w_poison_combined
  simp_alive_peephole
  sorry
