import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  matrix-multiplication-negation
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_negation_move_to_result_before := [llvmfunc|
  llvm.func @test_negation_move_to_result(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<6xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>]

    llvm.return %4 : vector<2xf64>
  }]

def test_negation_move_to_result_with_fastflags_before := [llvmfunc|
  llvm.func @test_negation_move_to_result_with_fastflags(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<6xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>]

    llvm.return %4 : vector<2xf64>
  }]

def test_negation_move_to_result_with_nnan_flag_before := [llvmfunc|
  llvm.func @test_negation_move_to_result_with_nnan_flag(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<6xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>]

    llvm.return %4 : vector<2xf64>
  }]

def test_negation_move_to_result_with_nsz_flag_before := [llvmfunc|
  llvm.func @test_negation_move_to_result_with_nsz_flag(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<6xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>]

    llvm.return %4 : vector<2xf64>
  }]

def test_negation_move_to_result_with_fastflag_on_negation_before := [llvmfunc|
  llvm.func @test_negation_move_to_result_with_fastflag_on_negation(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<6xf64>]

    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>]

    llvm.return %4 : vector<2xf64>
  }]

def test_move_negation_to_second_operand_before := [llvmfunc|
  llvm.func @test_move_negation_to_second_operand(%arg0: vector<27xf64>, %arg1: vector<3xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<27xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>]

    llvm.return %4 : vector<9xf64>
  }]

def test_move_negation_to_second_operand_with_fast_flags_before := [llvmfunc|
  llvm.func @test_move_negation_to_second_operand_with_fast_flags(%arg0: vector<27xf64>, %arg1: vector<3xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<27xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>]

    llvm.return %4 : vector<9xf64>
  }]

def test_negation_move_to_result_from_second_operand_before := [llvmfunc|
  llvm.func @test_negation_move_to_result_from_second_operand(%arg0: vector<3xf64>, %arg1: vector<6xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.fneg %arg1  : vector<6xf64>
    %4 = llvm.intr.matrix.multiply %arg0, %3 {lhs_columns = 3 : i32, lhs_rows = 1 : i32, rhs_columns = 2 : i32} : (vector<3xf64>, vector<6xf64>) -> vector<2xf64>]

    llvm.return %4 : vector<2xf64>
  }]

def test_move_negation_to_first_operand_before := [llvmfunc|
  llvm.func @test_move_negation_to_first_operand(%arg0: vector<3xf64>, %arg1: vector<27xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.fneg %arg1  : vector<27xf64>
    %4 = llvm.intr.matrix.multiply %arg0, %3 {lhs_columns = 3 : i32, lhs_rows = 1 : i32, rhs_columns = 9 : i32} : (vector<3xf64>, vector<27xf64>) -> vector<9xf64>]

    llvm.return %4 : vector<9xf64>
  }]

def test_negation_not_moved_before := [llvmfunc|
  llvm.func @test_negation_not_moved(%arg0: vector<3xf64>, %arg1: vector<5xf64>) -> vector<15xf64> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<3xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 1 : i32, lhs_rows = 3 : i32, rhs_columns = 5 : i32} : (vector<3xf64>, vector<5xf64>) -> vector<15xf64>]

    llvm.return %4 : vector<15xf64>
  }]

def test_negation_not_moved_second_operand_before := [llvmfunc|
  llvm.func @test_negation_not_moved_second_operand(%arg0: vector<5xf64>, %arg1: vector<3xf64>) -> vector<15xf64> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.fneg %arg1  : vector<3xf64>
    %4 = llvm.intr.matrix.multiply %arg0, %3 {lhs_columns = 1 : i32, lhs_rows = 5 : i32, rhs_columns = 3 : i32} : (vector<5xf64>, vector<3xf64>) -> vector<15xf64>]

    llvm.return %4 : vector<15xf64>
  }]

def test_negation_on_result_before := [llvmfunc|
  llvm.func @test_negation_on_result(%arg0: vector<3xf64>, %arg1: vector<5xf64>) -> vector<15xf64> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 1 : i32, lhs_rows = 3 : i32, rhs_columns = 5 : i32} : (vector<3xf64>, vector<5xf64>) -> vector<15xf64>]

    %4 = llvm.fneg %3  : vector<15xf64>
    llvm.return %4 : vector<15xf64>
  }]

def test_with_two_operands_negated1_before := [llvmfunc|
  llvm.func @test_with_two_operands_negated1(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<6xf64>
    %4 = llvm.fneg %arg1  : vector<3xf64>
    %5 = llvm.intr.matrix.multiply %3, %4 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>]

    llvm.return %5 : vector<2xf64>
  }]

def test_with_two_operands_negated2_before := [llvmfunc|
  llvm.func @test_with_two_operands_negated2(%arg0: vector<27xf64>, %arg1: vector<3xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<27xf64>
    %4 = llvm.fneg %arg1  : vector<3xf64>
    %5 = llvm.intr.matrix.multiply %3, %4 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>]

    llvm.return %5 : vector<9xf64>
  }]

def test_with_two_operands_negated_with_fastflags_before := [llvmfunc|
  llvm.func @test_with_two_operands_negated_with_fastflags(%arg0: vector<27xf64>, %arg1: vector<3xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<27xf64>
    %4 = llvm.fneg %arg1  : vector<3xf64>
    %5 = llvm.intr.matrix.multiply %3, %4 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>]

    llvm.return %5 : vector<9xf64>
  }]

def test_with_two_operands_negated2_commute_before := [llvmfunc|
  llvm.func @test_with_two_operands_negated2_commute(%arg0: vector<3xf64>, %arg1: vector<27xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<3xf64>
    %4 = llvm.fneg %arg1  : vector<27xf64>
    %5 = llvm.intr.matrix.multiply %3, %4 {lhs_columns = 3 : i32, lhs_rows = 1 : i32, rhs_columns = 9 : i32} : (vector<3xf64>, vector<27xf64>) -> vector<9xf64>]

    llvm.return %5 : vector<9xf64>
  }]

def matrix_multiply_two_operands_negated_with_same_size_before := [llvmfunc|
  llvm.func @matrix_multiply_two_operands_negated_with_same_size(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.fneg %arg0  : vector<2xf64>
    %3 = llvm.fneg %arg1  : vector<2xf64>
    %4 = llvm.intr.matrix.multiply %2, %3 {lhs_columns = 1 : i32, lhs_rows = 2 : i32, rhs_columns = 2 : i32} : (vector<2xf64>, vector<2xf64>) -> vector<4xf64>]

    llvm.return %4 : vector<4xf64>
  }]

def matrix_multiply_two_operands_with_multiple_uses_before := [llvmfunc|
  llvm.func @matrix_multiply_two_operands_with_multiple_uses(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.undef : vector<6xf64>
    %4 = llvm.fneg %arg0  : vector<6xf64>
    %5 = llvm.fneg %arg1  : vector<3xf64>
    %6 = llvm.intr.matrix.multiply %4, %5 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>]

    %7 = llvm.shufflevector %4, %3 [0, 1] : vector<6xf64> 
    %8 = llvm.fadd %7, %6  : vector<2xf64>
    llvm.return %8 : vector<2xf64>
  }]

def matrix_multiply_two_operands_with_multiple_uses2_before := [llvmfunc|
  llvm.func @matrix_multiply_two_operands_with_multiple_uses2(%arg0: vector<27xf64>, %arg1: vector<3xf64>, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<27xf64>
    %4 = llvm.fneg %arg1  : vector<3xf64>
    %5 = llvm.intr.matrix.multiply %3, %4 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>]

    llvm.store %3, %arg2 {alignment = 256 : i64} : vector<27xf64>, !llvm.ptr]

    llvm.store %4, %arg3 {alignment = 32 : i64} : vector<3xf64>, !llvm.ptr]

    llvm.return %5 : vector<9xf64>
  }]

def fneg_with_multiple_uses_before := [llvmfunc|
  llvm.func @fneg_with_multiple_uses(%arg0: vector<15xf64>, %arg1: vector<20xf64>) -> vector<12xf64> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.undef : vector<15xf64>
    %4 = llvm.fneg %arg0  : vector<15xf64>
    %5 = llvm.intr.matrix.multiply %4, %arg1 {lhs_columns = 5 : i32, lhs_rows = 3 : i32, rhs_columns = 4 : i32} : (vector<15xf64>, vector<20xf64>) -> vector<12xf64>]

    %6 = llvm.shufflevector %4, %3 [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] : vector<15xf64> 
    %7 = llvm.fadd %6, %5  : vector<12xf64>
    llvm.return %7 : vector<12xf64>
  }]

def fneg_with_multiple_uses_2_before := [llvmfunc|
  llvm.func @fneg_with_multiple_uses_2(%arg0: vector<15xf64>, %arg1: vector<20xf64>, %arg2: !llvm.ptr) -> vector<12xf64> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<15xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 5 : i32, lhs_rows = 3 : i32, rhs_columns = 4 : i32} : (vector<15xf64>, vector<20xf64>) -> vector<12xf64>]

    llvm.store %3, %arg2 {alignment = 128 : i64} : vector<15xf64>, !llvm.ptr]

    llvm.return %4 : vector<12xf64>
  }]

def chain_of_matrix_mutliplies_before := [llvmfunc|
  llvm.func @chain_of_matrix_mutliplies(%arg0: vector<27xf64>, %arg1: vector<3xf64>, %arg2: vector<8xf64>) -> vector<72xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.fneg %arg0  : vector<27xf64>
    %5 = llvm.intr.matrix.multiply %4, %arg1 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>]

    %6 = llvm.intr.matrix.multiply %5, %arg2 {lhs_columns = 1 : i32, lhs_rows = 9 : i32, rhs_columns = 8 : i32} : (vector<9xf64>, vector<8xf64>) -> vector<72xf64>]

    llvm.return %6 : vector<72xf64>
  }]

def chain_of_matrix_mutliplies_with_two_negations_before := [llvmfunc|
  llvm.func @chain_of_matrix_mutliplies_with_two_negations(%arg0: vector<3xf64>, %arg1: vector<5xf64>, %arg2: vector<10xf64>) -> vector<6xf64> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.fneg %arg1  : vector<5xf64>
    %5 = llvm.intr.matrix.multiply %arg0, %4 {lhs_columns = 1 : i32, lhs_rows = 3 : i32, rhs_columns = 5 : i32} : (vector<3xf64>, vector<5xf64>) -> vector<15xf64>]

    %6 = llvm.fneg %5  : vector<15xf64>
    %7 = llvm.intr.matrix.multiply %6, %arg2 {lhs_columns = 5 : i32, lhs_rows = 3 : i32, rhs_columns = 2 : i32} : (vector<15xf64>, vector<10xf64>) -> vector<6xf64>]

    llvm.return %7 : vector<6xf64>
  }]

def chain_of_matrix_mutliplies_propagation_before := [llvmfunc|
  llvm.func @chain_of_matrix_mutliplies_propagation(%arg0: vector<15xf64>, %arg1: vector<20xf64>, %arg2: vector<8xf64>) -> vector<6xf64> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.fneg %arg0  : vector<15xf64>
    %5 = llvm.intr.matrix.multiply %4, %arg1 {lhs_columns = 5 : i32, lhs_rows = 3 : i32, rhs_columns = 4 : i32} : (vector<15xf64>, vector<20xf64>) -> vector<12xf64>]

    %6 = llvm.intr.matrix.multiply %5, %arg2 {lhs_columns = 4 : i32, lhs_rows = 3 : i32, rhs_columns = 2 : i32} : (vector<12xf64>, vector<8xf64>) -> vector<6xf64>]

    llvm.return %6 : vector<6xf64>
  }]

def test_negation_move_to_result_combined := [llvmfunc|
  llvm.func @test_negation_move_to_result(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>]

theorem inst_combine_test_negation_move_to_result   : test_negation_move_to_result_before  ⊑  test_negation_move_to_result_combined := by
  unfold test_negation_move_to_result_before test_negation_move_to_result_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fneg %3  : vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }]

theorem inst_combine_test_negation_move_to_result   : test_negation_move_to_result_before  ⊑  test_negation_move_to_result_combined := by
  unfold test_negation_move_to_result_before test_negation_move_to_result_combined
  simp_alive_peephole
  sorry
def test_negation_move_to_result_with_fastflags_combined := [llvmfunc|
  llvm.func @test_negation_move_to_result_with_fastflags(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>]

theorem inst_combine_test_negation_move_to_result_with_fastflags   : test_negation_move_to_result_with_fastflags_before  ⊑  test_negation_move_to_result_with_fastflags_combined := by
  unfold test_negation_move_to_result_with_fastflags_before test_negation_move_to_result_with_fastflags_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fneg %3  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf64>]

theorem inst_combine_test_negation_move_to_result_with_fastflags   : test_negation_move_to_result_with_fastflags_before  ⊑  test_negation_move_to_result_with_fastflags_combined := by
  unfold test_negation_move_to_result_with_fastflags_before test_negation_move_to_result_with_fastflags_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<2xf64>
  }]

theorem inst_combine_test_negation_move_to_result_with_fastflags   : test_negation_move_to_result_with_fastflags_before  ⊑  test_negation_move_to_result_with_fastflags_combined := by
  unfold test_negation_move_to_result_with_fastflags_before test_negation_move_to_result_with_fastflags_combined
  simp_alive_peephole
  sorry
def test_negation_move_to_result_with_nnan_flag_combined := [llvmfunc|
  llvm.func @test_negation_move_to_result_with_nnan_flag(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>]

theorem inst_combine_test_negation_move_to_result_with_nnan_flag   : test_negation_move_to_result_with_nnan_flag_before  ⊑  test_negation_move_to_result_with_nnan_flag_combined := by
  unfold test_negation_move_to_result_with_nnan_flag_before test_negation_move_to_result_with_nnan_flag_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fneg %3  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf64>]

theorem inst_combine_test_negation_move_to_result_with_nnan_flag   : test_negation_move_to_result_with_nnan_flag_before  ⊑  test_negation_move_to_result_with_nnan_flag_combined := by
  unfold test_negation_move_to_result_with_nnan_flag_before test_negation_move_to_result_with_nnan_flag_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<2xf64>
  }]

theorem inst_combine_test_negation_move_to_result_with_nnan_flag   : test_negation_move_to_result_with_nnan_flag_before  ⊑  test_negation_move_to_result_with_nnan_flag_combined := by
  unfold test_negation_move_to_result_with_nnan_flag_before test_negation_move_to_result_with_nnan_flag_combined
  simp_alive_peephole
  sorry
def test_negation_move_to_result_with_nsz_flag_combined := [llvmfunc|
  llvm.func @test_negation_move_to_result_with_nsz_flag(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>]

theorem inst_combine_test_negation_move_to_result_with_nsz_flag   : test_negation_move_to_result_with_nsz_flag_before  ⊑  test_negation_move_to_result_with_nsz_flag_combined := by
  unfold test_negation_move_to_result_with_nsz_flag_before test_negation_move_to_result_with_nsz_flag_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fneg %3  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf64>]

theorem inst_combine_test_negation_move_to_result_with_nsz_flag   : test_negation_move_to_result_with_nsz_flag_before  ⊑  test_negation_move_to_result_with_nsz_flag_combined := by
  unfold test_negation_move_to_result_with_nsz_flag_before test_negation_move_to_result_with_nsz_flag_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<2xf64>
  }]

theorem inst_combine_test_negation_move_to_result_with_nsz_flag   : test_negation_move_to_result_with_nsz_flag_before  ⊑  test_negation_move_to_result_with_nsz_flag_combined := by
  unfold test_negation_move_to_result_with_nsz_flag_before test_negation_move_to_result_with_nsz_flag_combined
  simp_alive_peephole
  sorry
def test_negation_move_to_result_with_fastflag_on_negation_combined := [llvmfunc|
  llvm.func @test_negation_move_to_result_with_fastflag_on_negation(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>]

theorem inst_combine_test_negation_move_to_result_with_fastflag_on_negation   : test_negation_move_to_result_with_fastflag_on_negation_before  ⊑  test_negation_move_to_result_with_fastflag_on_negation_combined := by
  unfold test_negation_move_to_result_with_fastflag_on_negation_before test_negation_move_to_result_with_fastflag_on_negation_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fneg %3  : vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }]

theorem inst_combine_test_negation_move_to_result_with_fastflag_on_negation   : test_negation_move_to_result_with_fastflag_on_negation_before  ⊑  test_negation_move_to_result_with_fastflag_on_negation_combined := by
  unfold test_negation_move_to_result_with_fastflag_on_negation_before test_negation_move_to_result_with_fastflag_on_negation_combined
  simp_alive_peephole
  sorry
def test_move_negation_to_second_operand_combined := [llvmfunc|
  llvm.func @test_move_negation_to_second_operand(%arg0: vector<27xf64>, %arg1: vector<3xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.fneg %arg1  : vector<3xf64>
    %4 = llvm.intr.matrix.multiply %arg0, %3 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>]

theorem inst_combine_test_move_negation_to_second_operand   : test_move_negation_to_second_operand_before  ⊑  test_move_negation_to_second_operand_combined := by
  unfold test_move_negation_to_second_operand_before test_move_negation_to_second_operand_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<9xf64>
  }]

theorem inst_combine_test_move_negation_to_second_operand   : test_move_negation_to_second_operand_before  ⊑  test_move_negation_to_second_operand_combined := by
  unfold test_move_negation_to_second_operand_before test_move_negation_to_second_operand_combined
  simp_alive_peephole
  sorry
def test_move_negation_to_second_operand_with_fast_flags_combined := [llvmfunc|
  llvm.func @test_move_negation_to_second_operand_with_fast_flags(%arg0: vector<27xf64>, %arg1: vector<3xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.fneg %arg1  : vector<3xf64>
    %4 = llvm.intr.matrix.multiply %arg0, %3 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>]

theorem inst_combine_test_move_negation_to_second_operand_with_fast_flags   : test_move_negation_to_second_operand_with_fast_flags_before  ⊑  test_move_negation_to_second_operand_with_fast_flags_combined := by
  unfold test_move_negation_to_second_operand_with_fast_flags_before test_move_negation_to_second_operand_with_fast_flags_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<9xf64>
  }]

theorem inst_combine_test_move_negation_to_second_operand_with_fast_flags   : test_move_negation_to_second_operand_with_fast_flags_before  ⊑  test_move_negation_to_second_operand_with_fast_flags_combined := by
  unfold test_move_negation_to_second_operand_with_fast_flags_before test_move_negation_to_second_operand_with_fast_flags_combined
  simp_alive_peephole
  sorry
def test_negation_move_to_result_from_second_operand_combined := [llvmfunc|
  llvm.func @test_negation_move_to_result_from_second_operand(%arg0: vector<3xf64>, %arg1: vector<6xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 3 : i32, lhs_rows = 1 : i32, rhs_columns = 2 : i32} : (vector<3xf64>, vector<6xf64>) -> vector<2xf64>]

theorem inst_combine_test_negation_move_to_result_from_second_operand   : test_negation_move_to_result_from_second_operand_before  ⊑  test_negation_move_to_result_from_second_operand_combined := by
  unfold test_negation_move_to_result_from_second_operand_before test_negation_move_to_result_from_second_operand_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fneg %3  : vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }]

theorem inst_combine_test_negation_move_to_result_from_second_operand   : test_negation_move_to_result_from_second_operand_before  ⊑  test_negation_move_to_result_from_second_operand_combined := by
  unfold test_negation_move_to_result_from_second_operand_before test_negation_move_to_result_from_second_operand_combined
  simp_alive_peephole
  sorry
def test_move_negation_to_first_operand_combined := [llvmfunc|
  llvm.func @test_move_negation_to_first_operand(%arg0: vector<3xf64>, %arg1: vector<27xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<3xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 1 : i32, rhs_columns = 9 : i32} : (vector<3xf64>, vector<27xf64>) -> vector<9xf64>]

theorem inst_combine_test_move_negation_to_first_operand   : test_move_negation_to_first_operand_before  ⊑  test_move_negation_to_first_operand_combined := by
  unfold test_move_negation_to_first_operand_before test_move_negation_to_first_operand_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<9xf64>
  }]

theorem inst_combine_test_move_negation_to_first_operand   : test_move_negation_to_first_operand_before  ⊑  test_move_negation_to_first_operand_combined := by
  unfold test_move_negation_to_first_operand_before test_move_negation_to_first_operand_combined
  simp_alive_peephole
  sorry
def test_negation_not_moved_combined := [llvmfunc|
  llvm.func @test_negation_not_moved(%arg0: vector<3xf64>, %arg1: vector<5xf64>) -> vector<15xf64> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<3xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 1 : i32, lhs_rows = 3 : i32, rhs_columns = 5 : i32} : (vector<3xf64>, vector<5xf64>) -> vector<15xf64>]

theorem inst_combine_test_negation_not_moved   : test_negation_not_moved_before  ⊑  test_negation_not_moved_combined := by
  unfold test_negation_not_moved_before test_negation_not_moved_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<15xf64>
  }]

theorem inst_combine_test_negation_not_moved   : test_negation_not_moved_before  ⊑  test_negation_not_moved_combined := by
  unfold test_negation_not_moved_before test_negation_not_moved_combined
  simp_alive_peephole
  sorry
def test_negation_not_moved_second_operand_combined := [llvmfunc|
  llvm.func @test_negation_not_moved_second_operand(%arg0: vector<5xf64>, %arg1: vector<3xf64>) -> vector<15xf64> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.fneg %arg1  : vector<3xf64>
    %4 = llvm.intr.matrix.multiply %arg0, %3 {lhs_columns = 1 : i32, lhs_rows = 5 : i32, rhs_columns = 3 : i32} : (vector<5xf64>, vector<3xf64>) -> vector<15xf64>]

theorem inst_combine_test_negation_not_moved_second_operand   : test_negation_not_moved_second_operand_before  ⊑  test_negation_not_moved_second_operand_combined := by
  unfold test_negation_not_moved_second_operand_before test_negation_not_moved_second_operand_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<15xf64>
  }]

theorem inst_combine_test_negation_not_moved_second_operand   : test_negation_not_moved_second_operand_before  ⊑  test_negation_not_moved_second_operand_combined := by
  unfold test_negation_not_moved_second_operand_before test_negation_not_moved_second_operand_combined
  simp_alive_peephole
  sorry
def test_negation_on_result_combined := [llvmfunc|
  llvm.func @test_negation_on_result(%arg0: vector<3xf64>, %arg1: vector<5xf64>) -> vector<15xf64> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 1 : i32, lhs_rows = 3 : i32, rhs_columns = 5 : i32} : (vector<3xf64>, vector<5xf64>) -> vector<15xf64>]

theorem inst_combine_test_negation_on_result   : test_negation_on_result_before  ⊑  test_negation_on_result_combined := by
  unfold test_negation_on_result_before test_negation_on_result_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fneg %3  : vector<15xf64>
    llvm.return %4 : vector<15xf64>
  }]

theorem inst_combine_test_negation_on_result   : test_negation_on_result_before  ⊑  test_negation_on_result_combined := by
  unfold test_negation_on_result_before test_negation_on_result_combined
  simp_alive_peephole
  sorry
def test_with_two_operands_negated1_combined := [llvmfunc|
  llvm.func @test_with_two_operands_negated1(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>]

theorem inst_combine_test_with_two_operands_negated1   : test_with_two_operands_negated1_before  ⊑  test_with_two_operands_negated1_combined := by
  unfold test_with_two_operands_negated1_before test_with_two_operands_negated1_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<2xf64>
  }]

theorem inst_combine_test_with_two_operands_negated1   : test_with_two_operands_negated1_before  ⊑  test_with_two_operands_negated1_combined := by
  unfold test_with_two_operands_negated1_before test_with_two_operands_negated1_combined
  simp_alive_peephole
  sorry
def test_with_two_operands_negated2_combined := [llvmfunc|
  llvm.func @test_with_two_operands_negated2(%arg0: vector<27xf64>, %arg1: vector<3xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>]

theorem inst_combine_test_with_two_operands_negated2   : test_with_two_operands_negated2_before  ⊑  test_with_two_operands_negated2_combined := by
  unfold test_with_two_operands_negated2_before test_with_two_operands_negated2_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<9xf64>
  }]

theorem inst_combine_test_with_two_operands_negated2   : test_with_two_operands_negated2_before  ⊑  test_with_two_operands_negated2_combined := by
  unfold test_with_two_operands_negated2_before test_with_two_operands_negated2_combined
  simp_alive_peephole
  sorry
def test_with_two_operands_negated_with_fastflags_combined := [llvmfunc|
  llvm.func @test_with_two_operands_negated_with_fastflags(%arg0: vector<27xf64>, %arg1: vector<3xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>]

theorem inst_combine_test_with_two_operands_negated_with_fastflags   : test_with_two_operands_negated_with_fastflags_before  ⊑  test_with_two_operands_negated_with_fastflags_combined := by
  unfold test_with_two_operands_negated_with_fastflags_before test_with_two_operands_negated_with_fastflags_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<9xf64>
  }]

theorem inst_combine_test_with_two_operands_negated_with_fastflags   : test_with_two_operands_negated_with_fastflags_before  ⊑  test_with_two_operands_negated_with_fastflags_combined := by
  unfold test_with_two_operands_negated_with_fastflags_before test_with_two_operands_negated_with_fastflags_combined
  simp_alive_peephole
  sorry
def test_with_two_operands_negated2_commute_combined := [llvmfunc|
  llvm.func @test_with_two_operands_negated2_commute(%arg0: vector<3xf64>, %arg1: vector<27xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 3 : i32, lhs_rows = 1 : i32, rhs_columns = 9 : i32} : (vector<3xf64>, vector<27xf64>) -> vector<9xf64>]

theorem inst_combine_test_with_two_operands_negated2_commute   : test_with_two_operands_negated2_commute_before  ⊑  test_with_two_operands_negated2_commute_combined := by
  unfold test_with_two_operands_negated2_commute_before test_with_two_operands_negated2_commute_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<9xf64>
  }]

theorem inst_combine_test_with_two_operands_negated2_commute   : test_with_two_operands_negated2_commute_before  ⊑  test_with_two_operands_negated2_commute_combined := by
  unfold test_with_two_operands_negated2_commute_before test_with_two_operands_negated2_commute_combined
  simp_alive_peephole
  sorry
def matrix_multiply_two_operands_negated_with_same_size_combined := [llvmfunc|
  llvm.func @matrix_multiply_two_operands_negated_with_same_size(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 1 : i32, lhs_rows = 2 : i32, rhs_columns = 2 : i32} : (vector<2xf64>, vector<2xf64>) -> vector<4xf64>]

theorem inst_combine_matrix_multiply_two_operands_negated_with_same_size   : matrix_multiply_two_operands_negated_with_same_size_before  ⊑  matrix_multiply_two_operands_negated_with_same_size_combined := by
  unfold matrix_multiply_two_operands_negated_with_same_size_before matrix_multiply_two_operands_negated_with_same_size_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<4xf64>
  }]

theorem inst_combine_matrix_multiply_two_operands_negated_with_same_size   : matrix_multiply_two_operands_negated_with_same_size_before  ⊑  matrix_multiply_two_operands_negated_with_same_size_combined := by
  unfold matrix_multiply_two_operands_negated_with_same_size_before matrix_multiply_two_operands_negated_with_same_size_combined
  simp_alive_peephole
  sorry
def matrix_multiply_two_operands_with_multiple_uses_combined := [llvmfunc|
  llvm.func @matrix_multiply_two_operands_with_multiple_uses(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.poison : vector<6xf64>
    %4 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>]

theorem inst_combine_matrix_multiply_two_operands_with_multiple_uses   : matrix_multiply_two_operands_with_multiple_uses_before  ⊑  matrix_multiply_two_operands_with_multiple_uses_combined := by
  unfold matrix_multiply_two_operands_with_multiple_uses_before matrix_multiply_two_operands_with_multiple_uses_combined
  simp_alive_peephole
  sorry
    %5 = llvm.shufflevector %arg0, %3 [0, 1] : vector<6xf64> 
    %6 = llvm.fsub %4, %5  : vector<2xf64>
    llvm.return %6 : vector<2xf64>
  }]

theorem inst_combine_matrix_multiply_two_operands_with_multiple_uses   : matrix_multiply_two_operands_with_multiple_uses_before  ⊑  matrix_multiply_two_operands_with_multiple_uses_combined := by
  unfold matrix_multiply_two_operands_with_multiple_uses_before matrix_multiply_two_operands_with_multiple_uses_combined
  simp_alive_peephole
  sorry
def matrix_multiply_two_operands_with_multiple_uses2_combined := [llvmfunc|
  llvm.func @matrix_multiply_two_operands_with_multiple_uses2(%arg0: vector<27xf64>, %arg1: vector<3xf64>, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<27xf64>
    %4 = llvm.fneg %arg1  : vector<3xf64>
    %5 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>]

theorem inst_combine_matrix_multiply_two_operands_with_multiple_uses2   : matrix_multiply_two_operands_with_multiple_uses2_before  ⊑  matrix_multiply_two_operands_with_multiple_uses2_combined := by
  unfold matrix_multiply_two_operands_with_multiple_uses2_before matrix_multiply_two_operands_with_multiple_uses2_combined
  simp_alive_peephole
  sorry
    llvm.store %3, %arg2 {alignment = 256 : i64} : vector<27xf64>, !llvm.ptr]

theorem inst_combine_matrix_multiply_two_operands_with_multiple_uses2   : matrix_multiply_two_operands_with_multiple_uses2_before  ⊑  matrix_multiply_two_operands_with_multiple_uses2_combined := by
  unfold matrix_multiply_two_operands_with_multiple_uses2_before matrix_multiply_two_operands_with_multiple_uses2_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %arg3 {alignment = 32 : i64} : vector<3xf64>, !llvm.ptr]

theorem inst_combine_matrix_multiply_two_operands_with_multiple_uses2   : matrix_multiply_two_operands_with_multiple_uses2_before  ⊑  matrix_multiply_two_operands_with_multiple_uses2_combined := by
  unfold matrix_multiply_two_operands_with_multiple_uses2_before matrix_multiply_two_operands_with_multiple_uses2_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : vector<9xf64>
  }]

theorem inst_combine_matrix_multiply_two_operands_with_multiple_uses2   : matrix_multiply_two_operands_with_multiple_uses2_before  ⊑  matrix_multiply_two_operands_with_multiple_uses2_combined := by
  unfold matrix_multiply_two_operands_with_multiple_uses2_before matrix_multiply_two_operands_with_multiple_uses2_combined
  simp_alive_peephole
  sorry
def fneg_with_multiple_uses_combined := [llvmfunc|
  llvm.func @fneg_with_multiple_uses(%arg0: vector<15xf64>, %arg1: vector<20xf64>) -> vector<12xf64> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.poison : vector<15xf64>
    %4 = llvm.fneg %arg0  : vector<15xf64>
    %5 = llvm.intr.matrix.multiply %4, %arg1 {lhs_columns = 5 : i32, lhs_rows = 3 : i32, rhs_columns = 4 : i32} : (vector<15xf64>, vector<20xf64>) -> vector<12xf64>]

theorem inst_combine_fneg_with_multiple_uses   : fneg_with_multiple_uses_before  ⊑  fneg_with_multiple_uses_combined := by
  unfold fneg_with_multiple_uses_before fneg_with_multiple_uses_combined
  simp_alive_peephole
  sorry
    %6 = llvm.shufflevector %4, %3 [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] : vector<15xf64> 
    %7 = llvm.fadd %6, %5  : vector<12xf64>
    llvm.return %7 : vector<12xf64>
  }]

theorem inst_combine_fneg_with_multiple_uses   : fneg_with_multiple_uses_before  ⊑  fneg_with_multiple_uses_combined := by
  unfold fneg_with_multiple_uses_before fneg_with_multiple_uses_combined
  simp_alive_peephole
  sorry
def fneg_with_multiple_uses_2_combined := [llvmfunc|
  llvm.func @fneg_with_multiple_uses_2(%arg0: vector<15xf64>, %arg1: vector<20xf64>, %arg2: !llvm.ptr) -> vector<12xf64> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<15xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 5 : i32, lhs_rows = 3 : i32, rhs_columns = 4 : i32} : (vector<15xf64>, vector<20xf64>) -> vector<12xf64>]

theorem inst_combine_fneg_with_multiple_uses_2   : fneg_with_multiple_uses_2_before  ⊑  fneg_with_multiple_uses_2_combined := by
  unfold fneg_with_multiple_uses_2_before fneg_with_multiple_uses_2_combined
  simp_alive_peephole
  sorry
    llvm.store %3, %arg2 {alignment = 128 : i64} : vector<15xf64>, !llvm.ptr]

theorem inst_combine_fneg_with_multiple_uses_2   : fneg_with_multiple_uses_2_before  ⊑  fneg_with_multiple_uses_2_combined := by
  unfold fneg_with_multiple_uses_2_before fneg_with_multiple_uses_2_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<12xf64>
  }]

theorem inst_combine_fneg_with_multiple_uses_2   : fneg_with_multiple_uses_2_before  ⊑  fneg_with_multiple_uses_2_combined := by
  unfold fneg_with_multiple_uses_2_before fneg_with_multiple_uses_2_combined
  simp_alive_peephole
  sorry
def chain_of_matrix_mutliplies_combined := [llvmfunc|
  llvm.func @chain_of_matrix_mutliplies(%arg0: vector<27xf64>, %arg1: vector<3xf64>, %arg2: vector<8xf64>) -> vector<72xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.fneg %arg1  : vector<3xf64>
    %5 = llvm.intr.matrix.multiply %arg0, %4 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>]

theorem inst_combine_chain_of_matrix_mutliplies   : chain_of_matrix_mutliplies_before  ⊑  chain_of_matrix_mutliplies_combined := by
  unfold chain_of_matrix_mutliplies_before chain_of_matrix_mutliplies_combined
  simp_alive_peephole
  sorry
    %6 = llvm.intr.matrix.multiply %5, %arg2 {lhs_columns = 1 : i32, lhs_rows = 9 : i32, rhs_columns = 8 : i32} : (vector<9xf64>, vector<8xf64>) -> vector<72xf64>]

theorem inst_combine_chain_of_matrix_mutliplies   : chain_of_matrix_mutliplies_before  ⊑  chain_of_matrix_mutliplies_combined := by
  unfold chain_of_matrix_mutliplies_before chain_of_matrix_mutliplies_combined
  simp_alive_peephole
  sorry
    llvm.return %6 : vector<72xf64>
  }]

theorem inst_combine_chain_of_matrix_mutliplies   : chain_of_matrix_mutliplies_before  ⊑  chain_of_matrix_mutliplies_combined := by
  unfold chain_of_matrix_mutliplies_before chain_of_matrix_mutliplies_combined
  simp_alive_peephole
  sorry
def chain_of_matrix_mutliplies_with_two_negations_combined := [llvmfunc|
  llvm.func @chain_of_matrix_mutliplies_with_two_negations(%arg0: vector<3xf64>, %arg1: vector<5xf64>, %arg2: vector<10xf64>) -> vector<6xf64> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.fneg %arg0  : vector<3xf64>
    %5 = llvm.intr.matrix.multiply %4, %arg1 {lhs_columns = 1 : i32, lhs_rows = 3 : i32, rhs_columns = 5 : i32} : (vector<3xf64>, vector<5xf64>) -> vector<15xf64>]

theorem inst_combine_chain_of_matrix_mutliplies_with_two_negations   : chain_of_matrix_mutliplies_with_two_negations_before  ⊑  chain_of_matrix_mutliplies_with_two_negations_combined := by
  unfold chain_of_matrix_mutliplies_with_two_negations_before chain_of_matrix_mutliplies_with_two_negations_combined
  simp_alive_peephole
  sorry
    %6 = llvm.intr.matrix.multiply %5, %arg2 {lhs_columns = 5 : i32, lhs_rows = 3 : i32, rhs_columns = 2 : i32} : (vector<15xf64>, vector<10xf64>) -> vector<6xf64>]

theorem inst_combine_chain_of_matrix_mutliplies_with_two_negations   : chain_of_matrix_mutliplies_with_two_negations_before  ⊑  chain_of_matrix_mutliplies_with_two_negations_combined := by
  unfold chain_of_matrix_mutliplies_with_two_negations_before chain_of_matrix_mutliplies_with_two_negations_combined
  simp_alive_peephole
  sorry
    %7 = llvm.fneg %6  : vector<6xf64>
    llvm.return %7 : vector<6xf64>
  }]

theorem inst_combine_chain_of_matrix_mutliplies_with_two_negations   : chain_of_matrix_mutliplies_with_two_negations_before  ⊑  chain_of_matrix_mutliplies_with_two_negations_combined := by
  unfold chain_of_matrix_mutliplies_with_two_negations_before chain_of_matrix_mutliplies_with_two_negations_combined
  simp_alive_peephole
  sorry
def chain_of_matrix_mutliplies_propagation_combined := [llvmfunc|
  llvm.func @chain_of_matrix_mutliplies_propagation(%arg0: vector<15xf64>, %arg1: vector<20xf64>, %arg2: vector<8xf64>) -> vector<6xf64> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 5 : i32, lhs_rows = 3 : i32, rhs_columns = 4 : i32} : (vector<15xf64>, vector<20xf64>) -> vector<12xf64>]

theorem inst_combine_chain_of_matrix_mutliplies_propagation   : chain_of_matrix_mutliplies_propagation_before  ⊑  chain_of_matrix_mutliplies_propagation_combined := by
  unfold chain_of_matrix_mutliplies_propagation_before chain_of_matrix_mutliplies_propagation_combined
  simp_alive_peephole
  sorry
    %5 = llvm.intr.matrix.multiply %4, %arg2 {lhs_columns = 4 : i32, lhs_rows = 3 : i32, rhs_columns = 2 : i32} : (vector<12xf64>, vector<8xf64>) -> vector<6xf64>]

theorem inst_combine_chain_of_matrix_mutliplies_propagation   : chain_of_matrix_mutliplies_propagation_before  ⊑  chain_of_matrix_mutliplies_propagation_combined := by
  unfold chain_of_matrix_mutliplies_propagation_before chain_of_matrix_mutliplies_propagation_combined
  simp_alive_peephole
  sorry
    %6 = llvm.fneg %5  : vector<6xf64>
    llvm.return %6 : vector<6xf64>
  }]

theorem inst_combine_chain_of_matrix_mutliplies_propagation   : chain_of_matrix_mutliplies_propagation_before  ⊑  chain_of_matrix_mutliplies_propagation_combined := by
  unfold chain_of_matrix_mutliplies_propagation_before chain_of_matrix_mutliplies_propagation_combined
  simp_alive_peephole
  sorry
