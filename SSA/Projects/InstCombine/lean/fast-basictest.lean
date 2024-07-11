import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fast-basictest
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def test1_minimal_before := [llvmfunc|
  llvm.func @test1_minimal(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %3 : f32
  }]

def test1_reassoc_before := [llvmfunc|
  llvm.func @test1_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %3 : f32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-3.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+01 : f32) : f32
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fadd %2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fadd %3, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def test2_no_FMF_before := [llvmfunc|
  llvm.func @test2_no_FMF(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-3.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+01 : f32) : f32
    %2 = llvm.fadd %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fadd %3, %1  : f32
    llvm.return %4 : f32
  }]

def test2_reassoc_before := [llvmfunc|
  llvm.func @test2_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-3.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+01 : f32) : f32
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %3 = llvm.fadd %2, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %4 = llvm.fadd %3, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %4 : f32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fadd %2, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def test7_unary_fneg_before := [llvmfunc|
  llvm.func @test7_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fmul %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fadd %1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def test7_reassoc_nsz_before := [llvmfunc|
  llvm.func @test7_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %3 = llvm.fadd %2, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %3 : f32
  }]

def test7_reassoc_before := [llvmfunc|
  llvm.func @test7_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %3 = llvm.fadd %2, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %3 : f32
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def test8_reassoc_nsz_before := [llvmfunc|
  llvm.func @test8_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %2 : f32
  }]

def test8_reassoc_before := [llvmfunc|
  llvm.func @test8_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %2 : f32
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def test9_reassoc_nsz_before := [llvmfunc|
  llvm.func @test9_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %1 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %2 : f32
  }]

def test9_reassoc_before := [llvmfunc|
  llvm.func @test9_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %1 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %2 : f32
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.270000e+02 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def test10_reassoc_nsz_before := [llvmfunc|
  llvm.func @test10_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.270000e+02 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %3 : f32
  }]

def test10_reassoc_before := [llvmfunc|
  llvm.func @test10_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.270000e+02 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %3 : f32
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %3 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.fsub %2, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %6 = llvm.fadd %3, %4  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %7 = llvm.fadd %6, %5  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %7 : f32
  }]

def test11_reassoc_nsz_before := [llvmfunc|
  llvm.func @test11_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %3 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %4 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %5 = llvm.fsub %2, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %6 = llvm.fadd %3, %4  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %7 = llvm.fadd %6, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %7 : f32
  }]

def test11_reassoc_before := [llvmfunc|
  llvm.func @test11_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %3 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %4 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %5 = llvm.fsub %2, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %6 = llvm.fadd %3, %4  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %7 = llvm.fadd %6, %5  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %7 : f32
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def test12_unary_fneg_before := [llvmfunc|
  llvm.func @test12_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fmul %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def test12_reassoc_nsz_before := [llvmfunc|
  llvm.func @test12_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %3 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %4 : f32
  }]

def test12_reassoc_before := [llvmfunc|
  llvm.func @test12_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %3 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %4 : f32
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-4.700000e+01 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fmul %arg1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def test13_reassoc_nsz_before := [llvmfunc|
  llvm.func @test13_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-4.700000e+01 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %3 = llvm.fmul %arg1, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %4 : f32
  }]

def test13_reassoc_before := [llvmfunc|
  llvm.func @test13_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-4.700000e+01 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %3 = llvm.fmul %arg1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %4 : f32
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def test14_reassoc_before := [llvmfunc|
  llvm.func @test14_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %2 : f32
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.234000e+03 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fadd %arg0, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.fadd %3, %4  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %5 : f32
  }]

def test15_unary_fneg_before := [llvmfunc|
  llvm.func @test15_unary_fneg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.234000e+03 : f32) : f32
    %1 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fneg %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def test15_reassoc_nsz_before := [llvmfunc|
  llvm.func @test15_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.234000e+03 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %3 = llvm.fadd %arg0, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %4 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %5 = llvm.fadd %3, %4  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %5 : f32
  }]

def test15_reassoc_before := [llvmfunc|
  llvm.func @test15_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.234000e+03 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %3 = llvm.fadd %arg0, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %4 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %5 = llvm.fadd %3, %4  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %5 : f32
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.234500e+04 : f32) : f32
    %2 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fmul %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.fmul %4, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %6 = llvm.fsub %0, %5  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %6 : f32
  }]

def test16_unary_fneg_before := [llvmfunc|
  llvm.func @test16_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.234500e+04 : f32) : f32
    %1 = llvm.fneg %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fmul %1, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fmul %3, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.fneg %4  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %5 : f32
  }]

def test16_reassoc_nsz_before := [llvmfunc|
  llvm.func @test16_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.234500e+04 : f32) : f32
    %2 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %3 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %4 = llvm.fmul %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %5 = llvm.fmul %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %6 = llvm.fsub %0, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def test16_reassoc_before := [llvmfunc|
  llvm.func @test16_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.234500e+04 : f32) : f32
    %2 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %3 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %4 = llvm.fmul %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %5 = llvm.fmul %4, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %6 = llvm.fsub %0, %5  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %6 : f32
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fsub %1, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fmul %arg0, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.fsub %1, %4  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %5 : f32
  }]

def test17_unary_fneg_before := [llvmfunc|
  llvm.func @test17_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fneg %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fmul %arg0, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fneg %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def test17_reassoc_nsz_before := [llvmfunc|
  llvm.func @test17_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %3 = llvm.fsub %1, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %4 = llvm.fmul %arg0, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %5 = llvm.fsub %1, %4  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %5 : f32
  }]

def test17_reassoc_before := [llvmfunc|
  llvm.func @test17_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %3 = llvm.fsub %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %4 = llvm.fmul %arg0, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %5 = llvm.fsub %1, %4  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %5 : f32
  }]

def test17_unary_fneg_no_FMF_before := [llvmfunc|
  llvm.func @test17_unary_fneg_no_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.fmul %arg2, %0  : f32
    %2 = llvm.fneg %1  : f32
    %3 = llvm.fmul %arg0, %2  : f32
    %4 = llvm.fneg %3  : f32
    llvm.return %4 : f32
  }]

def test17_reassoc_unary_fneg_before := [llvmfunc|
  llvm.func @test17_reassoc_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %2 = llvm.fneg %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %3 = llvm.fmul %arg0, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %4 = llvm.fneg %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %4 : f32
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %2 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fsub %2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fadd %3, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def test18_reassoc_before := [llvmfunc|
  llvm.func @test18_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %2 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %3 = llvm.fsub %2, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %4 = llvm.fadd %3, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %4 : f32
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def test19_reassoc_nsz_before := [llvmfunc|
  llvm.func @test19_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %2 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %2 : f32
  }]

def test19_reassoc_before := [llvmfunc|
  llvm.func @test19_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %2 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %2 : f32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1_minimal_combined := [llvmfunc|
  llvm.func @test1_minimal(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test1_minimal   : test1_minimal_before  ⊑  test1_minimal_combined := by
  unfold test1_minimal_before test1_minimal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f32
  }]

theorem inst_combine_test1_minimal   : test1_minimal_before  ⊑  test1_minimal_combined := by
  unfold test1_minimal_before test1_minimal_combined
  simp_alive_peephole
  sorry
def test1_reassoc_combined := [llvmfunc|
  llvm.func @test1_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test1_reassoc   : test1_reassoc_before  ⊑  test1_reassoc_combined := by
  unfold test1_reassoc_before test1_reassoc_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test1_reassoc   : test1_reassoc_before  ⊑  test1_reassoc_combined := by
  unfold test1_reassoc_before test1_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f32
  }]

theorem inst_combine_test1_reassoc   : test1_reassoc_before  ⊑  test1_reassoc_combined := by
  unfold test1_reassoc_before test1_reassoc_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-3.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+01 : f32) : f32
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fadd %2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %3, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test2_no_FMF_combined := [llvmfunc|
  llvm.func @test2_no_FMF(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-3.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+01 : f32) : f32
    %2 = llvm.fadd %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fadd %3, %1  : f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test2_no_FMF   : test2_no_FMF_before  ⊑  test2_no_FMF_combined := by
  unfold test2_no_FMF_before test2_no_FMF_combined
  simp_alive_peephole
  sorry
def test2_reassoc_combined := [llvmfunc|
  llvm.func @test2_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-3.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+01 : f32) : f32
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test2_reassoc   : test2_reassoc_before  ⊑  test2_reassoc_combined := by
  unfold test2_reassoc_before test2_reassoc_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fadd %2, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test2_reassoc   : test2_reassoc_before  ⊑  test2_reassoc_combined := by
  unfold test2_reassoc_before test2_reassoc_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %3, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test2_reassoc   : test2_reassoc_before  ⊑  test2_reassoc_combined := by
  unfold test2_reassoc_before test2_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_test2_reassoc   : test2_reassoc_before  ⊑  test2_reassoc_combined := by
  unfold test2_reassoc_before test2_reassoc_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fsub %arg2, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test7_unary_fneg_combined := [llvmfunc|
  llvm.func @test7_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test7_unary_fneg   : test7_unary_fneg_before  ⊑  test7_unary_fneg_combined := by
  unfold test7_unary_fneg_before test7_unary_fneg_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fsub %arg2, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test7_unary_fneg   : test7_unary_fneg_before  ⊑  test7_unary_fneg_combined := by
  unfold test7_unary_fneg_before test7_unary_fneg_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test7_unary_fneg   : test7_unary_fneg_before  ⊑  test7_unary_fneg_combined := by
  unfold test7_unary_fneg_before test7_unary_fneg_combined
  simp_alive_peephole
  sorry
def test7_reassoc_nsz_combined := [llvmfunc|
  llvm.func @test7_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test7_reassoc_nsz   : test7_reassoc_nsz_before  ⊑  test7_reassoc_nsz_combined := by
  unfold test7_reassoc_nsz_before test7_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fsub %arg2, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test7_reassoc_nsz   : test7_reassoc_nsz_before  ⊑  test7_reassoc_nsz_combined := by
  unfold test7_reassoc_nsz_before test7_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test7_reassoc_nsz   : test7_reassoc_nsz_before  ⊑  test7_reassoc_nsz_combined := by
  unfold test7_reassoc_nsz_before test7_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def test7_reassoc_combined := [llvmfunc|
  llvm.func @test7_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test7_reassoc   : test7_reassoc_before  ⊑  test7_reassoc_combined := by
  unfold test7_reassoc_before test7_reassoc_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test7_reassoc   : test7_reassoc_before  ⊑  test7_reassoc_combined := by
  unfold test7_reassoc_before test7_reassoc_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fadd %2, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test7_reassoc   : test7_reassoc_before  ⊑  test7_reassoc_combined := by
  unfold test7_reassoc_before test7_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f32
  }]

theorem inst_combine_test7_reassoc   : test7_reassoc_before  ⊑  test7_reassoc_combined := by
  unfold test7_reassoc_before test7_reassoc_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(9.400000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test8_reassoc_nsz_combined := [llvmfunc|
  llvm.func @test8_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(9.400000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test8_reassoc_nsz   : test8_reassoc_nsz_before  ⊑  test8_reassoc_nsz_combined := by
  unfold test8_reassoc_nsz_before test8_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test8_reassoc_nsz   : test8_reassoc_nsz_before  ⊑  test8_reassoc_nsz_combined := by
  unfold test8_reassoc_nsz_before test8_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def test8_reassoc_combined := [llvmfunc|
  llvm.func @test8_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test8_reassoc   : test8_reassoc_before  ⊑  test8_reassoc_combined := by
  unfold test8_reassoc_before test8_reassoc_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test8_reassoc   : test8_reassoc_before  ⊑  test8_reassoc_combined := by
  unfold test8_reassoc_before test8_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_test8_reassoc   : test8_reassoc_before  ⊑  test8_reassoc_combined := by
  unfold test8_reassoc_before test8_reassoc_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test9_reassoc_nsz_combined := [llvmfunc|
  llvm.func @test9_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test9_reassoc_nsz   : test9_reassoc_nsz_before  ⊑  test9_reassoc_nsz_combined := by
  unfold test9_reassoc_nsz_before test9_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test9_reassoc_nsz   : test9_reassoc_nsz_before  ⊑  test9_reassoc_nsz_combined := by
  unfold test9_reassoc_nsz_before test9_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def test9_reassoc_combined := [llvmfunc|
  llvm.func @test9_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test9_reassoc   : test9_reassoc_before  ⊑  test9_reassoc_combined := by
  unfold test9_reassoc_before test9_reassoc_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test9_reassoc   : test9_reassoc_before  ⊑  test9_reassoc_combined := by
  unfold test9_reassoc_before test9_reassoc_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test9_reassoc   : test9_reassoc_before  ⊑  test9_reassoc_combined := by
  unfold test9_reassoc_before test9_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_test9_reassoc   : test9_reassoc_before  ⊑  test9_reassoc_combined := by
  unfold test9_reassoc_before test9_reassoc_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.810000e+02 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test10_reassoc_nsz_combined := [llvmfunc|
  llvm.func @test10_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.810000e+02 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test10_reassoc_nsz   : test10_reassoc_nsz_before  ⊑  test10_reassoc_nsz_combined := by
  unfold test10_reassoc_nsz_before test10_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test10_reassoc_nsz   : test10_reassoc_nsz_before  ⊑  test10_reassoc_nsz_combined := by
  unfold test10_reassoc_nsz_before test10_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def test10_reassoc_combined := [llvmfunc|
  llvm.func @test10_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.270000e+02 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test10_reassoc   : test10_reassoc_before  ⊑  test10_reassoc_combined := by
  unfold test10_reassoc_before test10_reassoc_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test10_reassoc   : test10_reassoc_before  ⊑  test10_reassoc_combined := by
  unfold test10_reassoc_before test10_reassoc_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test10_reassoc   : test10_reassoc_before  ⊑  test10_reassoc_combined := by
  unfold test10_reassoc_before test10_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f32
  }]

theorem inst_combine_test10_reassoc   : test10_reassoc_before  ⊑  test10_reassoc_combined := by
  unfold test10_reassoc_before test10_reassoc_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fsub %1, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f32
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test11_reassoc_nsz_combined := [llvmfunc|
  llvm.func @test11_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test11_reassoc_nsz   : test11_reassoc_nsz_before  ⊑  test11_reassoc_nsz_combined := by
  unfold test11_reassoc_nsz_before test11_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fsub %1, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test11_reassoc_nsz   : test11_reassoc_nsz_before  ⊑  test11_reassoc_nsz_combined := by
  unfold test11_reassoc_nsz_before test11_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f32
  }]

theorem inst_combine_test11_reassoc_nsz   : test11_reassoc_nsz_before  ⊑  test11_reassoc_nsz_combined := by
  unfold test11_reassoc_nsz_before test11_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def test11_reassoc_combined := [llvmfunc|
  llvm.func @test11_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %3 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test11_reassoc   : test11_reassoc_before  ⊑  test11_reassoc_combined := by
  unfold test11_reassoc_before test11_reassoc_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test11_reassoc   : test11_reassoc_before  ⊑  test11_reassoc_combined := by
  unfold test11_reassoc_before test11_reassoc_combined
  simp_alive_peephole
  sorry
    %5 = llvm.fsub %2, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test11_reassoc   : test11_reassoc_before  ⊑  test11_reassoc_combined := by
  unfold test11_reassoc_before test11_reassoc_combined
  simp_alive_peephole
  sorry
    %6 = llvm.fadd %3, %4  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test11_reassoc   : test11_reassoc_before  ⊑  test11_reassoc_combined := by
  unfold test11_reassoc_before test11_reassoc_combined
  simp_alive_peephole
  sorry
    %7 = llvm.fadd %6, %5  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test11_reassoc   : test11_reassoc_before  ⊑  test11_reassoc_combined := by
  unfold test11_reassoc_before test11_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %7 : f32
  }]

theorem inst_combine_test11_reassoc   : test11_reassoc_before  ⊑  test11_reassoc_combined := by
  unfold test11_reassoc_before test11_reassoc_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test12_unary_fneg_combined := [llvmfunc|
  llvm.func @test12_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test12_unary_fneg   : test12_unary_fneg_before  ⊑  test12_unary_fneg_combined := by
  unfold test12_unary_fneg_before test12_unary_fneg_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test12_unary_fneg   : test12_unary_fneg_before  ⊑  test12_unary_fneg_combined := by
  unfold test12_unary_fneg_before test12_unary_fneg_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test12_unary_fneg   : test12_unary_fneg_before  ⊑  test12_unary_fneg_combined := by
  unfold test12_unary_fneg_before test12_unary_fneg_combined
  simp_alive_peephole
  sorry
def test12_reassoc_nsz_combined := [llvmfunc|
  llvm.func @test12_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg2, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test12_reassoc_nsz   : test12_reassoc_nsz_before  ⊑  test12_reassoc_nsz_combined := by
  unfold test12_reassoc_nsz_before test12_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test12_reassoc_nsz   : test12_reassoc_nsz_before  ⊑  test12_reassoc_nsz_combined := by
  unfold test12_reassoc_nsz_before test12_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test12_reassoc_nsz   : test12_reassoc_nsz_before  ⊑  test12_reassoc_nsz_combined := by
  unfold test12_reassoc_nsz_before test12_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def test12_reassoc_combined := [llvmfunc|
  llvm.func @test12_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test12_reassoc   : test12_reassoc_before  ⊑  test12_reassoc_combined := by
  unfold test12_reassoc_before test12_reassoc_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test12_reassoc   : test12_reassoc_before  ⊑  test12_reassoc_combined := by
  unfold test12_reassoc_before test12_reassoc_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test12_reassoc   : test12_reassoc_before  ⊑  test12_reassoc_combined := by
  unfold test12_reassoc_before test12_reassoc_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test12_reassoc   : test12_reassoc_before  ⊑  test12_reassoc_combined := by
  unfold test12_reassoc_before test12_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_test12_reassoc   : test12_reassoc_before  ⊑  test12_reassoc_combined := by
  unfold test12_reassoc_before test12_reassoc_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-4.700000e+01 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fmul %arg1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test13_reassoc_nsz_combined := [llvmfunc|
  llvm.func @test13_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-4.700000e+01 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test13_reassoc_nsz   : test13_reassoc_nsz_before  ⊑  test13_reassoc_nsz_combined := by
  unfold test13_reassoc_nsz_before test13_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fmul %arg1, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test13_reassoc_nsz   : test13_reassoc_nsz_before  ⊑  test13_reassoc_nsz_combined := by
  unfold test13_reassoc_nsz_before test13_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test13_reassoc_nsz   : test13_reassoc_nsz_before  ⊑  test13_reassoc_nsz_combined := by
  unfold test13_reassoc_nsz_before test13_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_test13_reassoc_nsz   : test13_reassoc_nsz_before  ⊑  test13_reassoc_nsz_combined := by
  unfold test13_reassoc_nsz_before test13_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def test13_reassoc_combined := [llvmfunc|
  llvm.func @test13_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-4.700000e+01 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test13_reassoc   : test13_reassoc_before  ⊑  test13_reassoc_combined := by
  unfold test13_reassoc_before test13_reassoc_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fmul %arg1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test13_reassoc   : test13_reassoc_before  ⊑  test13_reassoc_combined := by
  unfold test13_reassoc_before test13_reassoc_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test13_reassoc   : test13_reassoc_before  ⊑  test13_reassoc_combined := by
  unfold test13_reassoc_before test13_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_test13_reassoc   : test13_reassoc_before  ⊑  test13_reassoc_combined := by
  unfold test13_reassoc_before test13_reassoc_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.440000e+02 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test14_reassoc_combined := [llvmfunc|
  llvm.func @test14_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.440000e+02 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test14_reassoc   : test14_reassoc_before  ⊑  test14_reassoc_combined := by
  unfold test14_reassoc_before test14_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test14_reassoc   : test14_reassoc_before  ⊑  test14_reassoc_combined := by
  unfold test14_reassoc_before test14_reassoc_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.234000e+03 : f32) : f32
    %1 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fsub %2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f32
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test15_unary_fneg_combined := [llvmfunc|
  llvm.func @test15_unary_fneg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.234000e+03 : f32) : f32
    %1 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test15_unary_fneg   : test15_unary_fneg_before  ⊑  test15_unary_fneg_combined := by
  unfold test15_unary_fneg_before test15_unary_fneg_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test15_unary_fneg   : test15_unary_fneg_before  ⊑  test15_unary_fneg_combined := by
  unfold test15_unary_fneg_before test15_unary_fneg_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fsub %2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test15_unary_fneg   : test15_unary_fneg_before  ⊑  test15_unary_fneg_combined := by
  unfold test15_unary_fneg_before test15_unary_fneg_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f32
  }]

theorem inst_combine_test15_unary_fneg   : test15_unary_fneg_before  ⊑  test15_unary_fneg_combined := by
  unfold test15_unary_fneg_before test15_unary_fneg_combined
  simp_alive_peephole
  sorry
def test15_reassoc_nsz_combined := [llvmfunc|
  llvm.func @test15_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.234000e+03 : f32) : f32
    %1 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test15_reassoc_nsz   : test15_reassoc_nsz_before  ⊑  test15_reassoc_nsz_combined := by
  unfold test15_reassoc_nsz_before test15_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test15_reassoc_nsz   : test15_reassoc_nsz_before  ⊑  test15_reassoc_nsz_combined := by
  unfold test15_reassoc_nsz_before test15_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fsub %2, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test15_reassoc_nsz   : test15_reassoc_nsz_before  ⊑  test15_reassoc_nsz_combined := by
  unfold test15_reassoc_nsz_before test15_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f32
  }]

theorem inst_combine_test15_reassoc_nsz   : test15_reassoc_nsz_before  ⊑  test15_reassoc_nsz_combined := by
  unfold test15_reassoc_nsz_before test15_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def test15_reassoc_combined := [llvmfunc|
  llvm.func @test15_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.234000e+03 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test15_reassoc   : test15_reassoc_before  ⊑  test15_reassoc_combined := by
  unfold test15_reassoc_before test15_reassoc_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fadd %2, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test15_reassoc   : test15_reassoc_before  ⊑  test15_reassoc_combined := by
  unfold test15_reassoc_before test15_reassoc_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test15_reassoc   : test15_reassoc_before  ⊑  test15_reassoc_combined := by
  unfold test15_reassoc_before test15_reassoc_combined
  simp_alive_peephole
  sorry
    %5 = llvm.fadd %3, %4  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test15_reassoc   : test15_reassoc_before  ⊑  test15_reassoc_combined := by
  unfold test15_reassoc_before test15_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : f32
  }]

theorem inst_combine_test15_reassoc   : test15_reassoc_before  ⊑  test15_reassoc_combined := by
  unfold test15_reassoc_before test15_reassoc_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.234500e+04 : f32) : f32
    %1 = llvm.fneg %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fmul %3, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test16_unary_fneg_combined := [llvmfunc|
  llvm.func @test16_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.234500e+04 : f32) : f32
    %1 = llvm.fneg %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test16_unary_fneg   : test16_unary_fneg_before  ⊑  test16_unary_fneg_combined := by
  unfold test16_unary_fneg_before test16_unary_fneg_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test16_unary_fneg   : test16_unary_fneg_before  ⊑  test16_unary_fneg_combined := by
  unfold test16_unary_fneg_before test16_unary_fneg_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test16_unary_fneg   : test16_unary_fneg_before  ⊑  test16_unary_fneg_combined := by
  unfold test16_unary_fneg_before test16_unary_fneg_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fmul %3, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test16_unary_fneg   : test16_unary_fneg_before  ⊑  test16_unary_fneg_combined := by
  unfold test16_unary_fneg_before test16_unary_fneg_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_test16_unary_fneg   : test16_unary_fneg_before  ⊑  test16_unary_fneg_combined := by
  unfold test16_unary_fneg_before test16_unary_fneg_combined
  simp_alive_peephole
  sorry
def test16_reassoc_nsz_combined := [llvmfunc|
  llvm.func @test16_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.234500e+04 : f32) : f32
    %1 = llvm.fneg %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test16_reassoc_nsz   : test16_reassoc_nsz_before  ⊑  test16_reassoc_nsz_combined := by
  unfold test16_reassoc_nsz_before test16_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test16_reassoc_nsz   : test16_reassoc_nsz_before  ⊑  test16_reassoc_nsz_combined := by
  unfold test16_reassoc_nsz_before test16_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test16_reassoc_nsz   : test16_reassoc_nsz_before  ⊑  test16_reassoc_nsz_combined := by
  unfold test16_reassoc_nsz_before test16_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fmul %3, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test16_reassoc_nsz   : test16_reassoc_nsz_before  ⊑  test16_reassoc_nsz_combined := by
  unfold test16_reassoc_nsz_before test16_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_test16_reassoc_nsz   : test16_reassoc_nsz_before  ⊑  test16_reassoc_nsz_combined := by
  unfold test16_reassoc_nsz_before test16_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def test16_reassoc_combined := [llvmfunc|
  llvm.func @test16_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.234500e+04 : f32) : f32
    %2 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test16_reassoc   : test16_reassoc_before  ⊑  test16_reassoc_combined := by
  unfold test16_reassoc_before test16_reassoc_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test16_reassoc   : test16_reassoc_before  ⊑  test16_reassoc_combined := by
  unfold test16_reassoc_before test16_reassoc_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fmul %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test16_reassoc   : test16_reassoc_before  ⊑  test16_reassoc_combined := by
  unfold test16_reassoc_before test16_reassoc_combined
  simp_alive_peephole
  sorry
    %5 = llvm.fmul %4, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test16_reassoc   : test16_reassoc_before  ⊑  test16_reassoc_combined := by
  unfold test16_reassoc_before test16_reassoc_combined
  simp_alive_peephole
  sorry
    %6 = llvm.fsub %0, %5  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test16_reassoc   : test16_reassoc_before  ⊑  test16_reassoc_combined := by
  unfold test16_reassoc_before test16_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %6 : f32
  }]

theorem inst_combine_test16_reassoc   : test16_reassoc_before  ⊑  test16_reassoc_combined := by
  unfold test16_reassoc_before test16_reassoc_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test17_unary_fneg_combined := [llvmfunc|
  llvm.func @test17_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test17_unary_fneg   : test17_unary_fneg_before  ⊑  test17_unary_fneg_combined := by
  unfold test17_unary_fneg_before test17_unary_fneg_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test17_unary_fneg   : test17_unary_fneg_before  ⊑  test17_unary_fneg_combined := by
  unfold test17_unary_fneg_before test17_unary_fneg_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_test17_unary_fneg   : test17_unary_fneg_before  ⊑  test17_unary_fneg_combined := by
  unfold test17_unary_fneg_before test17_unary_fneg_combined
  simp_alive_peephole
  sorry
def test17_reassoc_nsz_combined := [llvmfunc|
  llvm.func @test17_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test17_reassoc_nsz   : test17_reassoc_nsz_before  ⊑  test17_reassoc_nsz_combined := by
  unfold test17_reassoc_nsz_before test17_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test17_reassoc_nsz   : test17_reassoc_nsz_before  ⊑  test17_reassoc_nsz_combined := by
  unfold test17_reassoc_nsz_before test17_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_test17_reassoc_nsz   : test17_reassoc_nsz_before  ⊑  test17_reassoc_nsz_combined := by
  unfold test17_reassoc_nsz_before test17_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def test17_reassoc_combined := [llvmfunc|
  llvm.func @test17_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test17_reassoc   : test17_reassoc_before  ⊑  test17_reassoc_combined := by
  unfold test17_reassoc_before test17_reassoc_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fsub %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test17_reassoc   : test17_reassoc_before  ⊑  test17_reassoc_combined := by
  unfold test17_reassoc_before test17_reassoc_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fmul %3, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test17_reassoc   : test17_reassoc_before  ⊑  test17_reassoc_combined := by
  unfold test17_reassoc_before test17_reassoc_combined
  simp_alive_peephole
  sorry
    %5 = llvm.fsub %1, %4  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test17_reassoc   : test17_reassoc_before  ⊑  test17_reassoc_combined := by
  unfold test17_reassoc_before test17_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : f32
  }]

theorem inst_combine_test17_reassoc   : test17_reassoc_before  ⊑  test17_reassoc_combined := by
  unfold test17_reassoc_before test17_reassoc_combined
  simp_alive_peephole
  sorry
def test17_unary_fneg_no_FMF_combined := [llvmfunc|
  llvm.func @test17_unary_fneg_no_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.fmul %arg2, %0  : f32
    %2 = llvm.fmul %1, %arg0  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test17_unary_fneg_no_FMF   : test17_unary_fneg_no_FMF_before  ⊑  test17_unary_fneg_no_FMF_combined := by
  unfold test17_unary_fneg_no_FMF_before test17_unary_fneg_no_FMF_combined
  simp_alive_peephole
  sorry
def test17_reassoc_unary_fneg_combined := [llvmfunc|
  llvm.func @test17_reassoc_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test17_reassoc_unary_fneg   : test17_reassoc_unary_fneg_before  ⊑  test17_reassoc_unary_fneg_combined := by
  unfold test17_reassoc_unary_fneg_before test17_reassoc_unary_fneg_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test17_reassoc_unary_fneg   : test17_reassoc_unary_fneg_before  ⊑  test17_reassoc_unary_fneg_combined := by
  unfold test17_reassoc_unary_fneg_before test17_reassoc_unary_fneg_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_test17_reassoc_unary_fneg   : test17_reassoc_unary_fneg_before  ⊑  test17_reassoc_unary_fneg_combined := by
  unfold test17_reassoc_unary_fneg_before test17_reassoc_unary_fneg_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fsub %2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %3, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test18_reassoc_combined := [llvmfunc|
  llvm.func @test18_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test18_reassoc   : test18_reassoc_before  ⊑  test18_reassoc_combined := by
  unfold test18_reassoc_before test18_reassoc_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fsub %2, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test18_reassoc   : test18_reassoc_before  ⊑  test18_reassoc_combined := by
  unfold test18_reassoc_before test18_reassoc_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %3, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test18_reassoc   : test18_reassoc_before  ⊑  test18_reassoc_combined := by
  unfold test18_reassoc_before test18_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_test18_reassoc   : test18_reassoc_before  ⊑  test18_reassoc_combined := by
  unfold test18_reassoc_before test18_reassoc_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
def test19_reassoc_nsz_combined := [llvmfunc|
  llvm.func @test19_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test19_reassoc_nsz   : test19_reassoc_nsz_before  ⊑  test19_reassoc_nsz_combined := by
  unfold test19_reassoc_nsz_before test19_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_test19_reassoc_nsz   : test19_reassoc_nsz_before  ⊑  test19_reassoc_nsz_combined := by
  unfold test19_reassoc_nsz_before test19_reassoc_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test19_reassoc_nsz   : test19_reassoc_nsz_before  ⊑  test19_reassoc_nsz_combined := by
  unfold test19_reassoc_nsz_before test19_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def test19_reassoc_combined := [llvmfunc|
  llvm.func @test19_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test19_reassoc   : test19_reassoc_before  ⊑  test19_reassoc_combined := by
  unfold test19_reassoc_before test19_reassoc_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test19_reassoc   : test19_reassoc_before  ⊑  test19_reassoc_combined := by
  unfold test19_reassoc_before test19_reassoc_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_test19_reassoc   : test19_reassoc_before  ⊑  test19_reassoc_combined := by
  unfold test19_reassoc_before test19_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_test19_reassoc   : test19_reassoc_before  ⊑  test19_reassoc_combined := by
  unfold test19_reassoc_before test19_reassoc_combined
  simp_alive_peephole
  sorry
