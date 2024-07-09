module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_negation_move_to_result(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<6xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }
  llvm.func @test_negation_move_to_result_with_fastflags(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<6xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }
  llvm.func @test_negation_move_to_result_with_nnan_flag(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<6xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }
  llvm.func @test_negation_move_to_result_with_nsz_flag(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<6xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }
  llvm.func @test_negation_move_to_result_with_fastflag_on_negation(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<6xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }
  llvm.func @test_move_negation_to_second_operand(%arg0: vector<27xf64>, %arg1: vector<3xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<27xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>
    llvm.return %4 : vector<9xf64>
  }
  llvm.func @test_move_negation_to_second_operand_with_fast_flags(%arg0: vector<27xf64>, %arg1: vector<3xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<27xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>
    llvm.return %4 : vector<9xf64>
  }
  llvm.func @test_negation_move_to_result_from_second_operand(%arg0: vector<3xf64>, %arg1: vector<6xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.fneg %arg1  : vector<6xf64>
    %4 = llvm.intr.matrix.multiply %arg0, %3 {lhs_columns = 3 : i32, lhs_rows = 1 : i32, rhs_columns = 2 : i32} : (vector<3xf64>, vector<6xf64>) -> vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }
  llvm.func @test_move_negation_to_first_operand(%arg0: vector<3xf64>, %arg1: vector<27xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.fneg %arg1  : vector<27xf64>
    %4 = llvm.intr.matrix.multiply %arg0, %3 {lhs_columns = 3 : i32, lhs_rows = 1 : i32, rhs_columns = 9 : i32} : (vector<3xf64>, vector<27xf64>) -> vector<9xf64>
    llvm.return %4 : vector<9xf64>
  }
  llvm.func @test_negation_not_moved(%arg0: vector<3xf64>, %arg1: vector<5xf64>) -> vector<15xf64> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<3xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 1 : i32, lhs_rows = 3 : i32, rhs_columns = 5 : i32} : (vector<3xf64>, vector<5xf64>) -> vector<15xf64>
    llvm.return %4 : vector<15xf64>
  }
  llvm.func @test_negation_not_moved_second_operand(%arg0: vector<5xf64>, %arg1: vector<3xf64>) -> vector<15xf64> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.fneg %arg1  : vector<3xf64>
    %4 = llvm.intr.matrix.multiply %arg0, %3 {lhs_columns = 1 : i32, lhs_rows = 5 : i32, rhs_columns = 3 : i32} : (vector<5xf64>, vector<3xf64>) -> vector<15xf64>
    llvm.return %4 : vector<15xf64>
  }
  llvm.func @test_negation_on_result(%arg0: vector<3xf64>, %arg1: vector<5xf64>) -> vector<15xf64> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.intr.matrix.multiply %arg0, %arg1 {lhs_columns = 1 : i32, lhs_rows = 3 : i32, rhs_columns = 5 : i32} : (vector<3xf64>, vector<5xf64>) -> vector<15xf64>
    %4 = llvm.fneg %3  : vector<15xf64>
    llvm.return %4 : vector<15xf64>
  }
  llvm.func @test_with_two_operands_negated1(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<6xf64>
    %4 = llvm.fneg %arg1  : vector<3xf64>
    %5 = llvm.intr.matrix.multiply %3, %4 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>
    llvm.return %5 : vector<2xf64>
  }
  llvm.func @test_with_two_operands_negated2(%arg0: vector<27xf64>, %arg1: vector<3xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<27xf64>
    %4 = llvm.fneg %arg1  : vector<3xf64>
    %5 = llvm.intr.matrix.multiply %3, %4 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>
    llvm.return %5 : vector<9xf64>
  }
  llvm.func @test_with_two_operands_negated_with_fastflags(%arg0: vector<27xf64>, %arg1: vector<3xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<27xf64>
    %4 = llvm.fneg %arg1  : vector<3xf64>
    %5 = llvm.intr.matrix.multiply %3, %4 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>
    llvm.return %5 : vector<9xf64>
  }
  llvm.func @test_with_two_operands_negated2_commute(%arg0: vector<3xf64>, %arg1: vector<27xf64>) -> vector<9xf64> {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<3xf64>
    %4 = llvm.fneg %arg1  : vector<27xf64>
    %5 = llvm.intr.matrix.multiply %3, %4 {lhs_columns = 3 : i32, lhs_rows = 1 : i32, rhs_columns = 9 : i32} : (vector<3xf64>, vector<27xf64>) -> vector<9xf64>
    llvm.return %5 : vector<9xf64>
  }
  llvm.func @matrix_multiply_two_operands_negated_with_same_size(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.fneg %arg0  : vector<2xf64>
    %3 = llvm.fneg %arg1  : vector<2xf64>
    %4 = llvm.intr.matrix.multiply %2, %3 {lhs_columns = 1 : i32, lhs_rows = 2 : i32, rhs_columns = 2 : i32} : (vector<2xf64>, vector<2xf64>) -> vector<4xf64>
    llvm.return %4 : vector<4xf64>
  }
  llvm.func @matrix_multiply_two_operands_with_multiple_uses(%arg0: vector<6xf64>, %arg1: vector<3xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.undef : vector<6xf64>
    %4 = llvm.fneg %arg0  : vector<6xf64>
    %5 = llvm.fneg %arg1  : vector<3xf64>
    %6 = llvm.intr.matrix.multiply %4, %5 {lhs_columns = 3 : i32, lhs_rows = 2 : i32, rhs_columns = 1 : i32} : (vector<6xf64>, vector<3xf64>) -> vector<2xf64>
    %7 = llvm.shufflevector %4, %3 [0, 1] : vector<6xf64> 
    %8 = llvm.fadd %7, %6  : vector<2xf64>
    llvm.return %8 : vector<2xf64>
  }
  llvm.func @matrix_multiply_two_operands_with_multiple_uses2(%arg0: vector<27xf64>, %arg1: vector<3xf64>, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> vector<9xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<27xf64>
    %4 = llvm.fneg %arg1  : vector<3xf64>
    %5 = llvm.intr.matrix.multiply %3, %4 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>
    llvm.store %3, %arg2 {alignment = 256 : i64} : vector<27xf64>, !llvm.ptr
    llvm.store %4, %arg3 {alignment = 32 : i64} : vector<3xf64>, !llvm.ptr
    llvm.return %5 : vector<9xf64>
  }
  llvm.func @fneg_with_multiple_uses(%arg0: vector<15xf64>, %arg1: vector<20xf64>) -> vector<12xf64> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.undef : vector<15xf64>
    %4 = llvm.fneg %arg0  : vector<15xf64>
    %5 = llvm.intr.matrix.multiply %4, %arg1 {lhs_columns = 5 : i32, lhs_rows = 3 : i32, rhs_columns = 4 : i32} : (vector<15xf64>, vector<20xf64>) -> vector<12xf64>
    %6 = llvm.shufflevector %4, %3 [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] : vector<15xf64> 
    %7 = llvm.fadd %6, %5  : vector<12xf64>
    llvm.return %7 : vector<12xf64>
  }
  llvm.func @fneg_with_multiple_uses_2(%arg0: vector<15xf64>, %arg1: vector<20xf64>, %arg2: !llvm.ptr) -> vector<12xf64> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.fneg %arg0  : vector<15xf64>
    %4 = llvm.intr.matrix.multiply %3, %arg1 {lhs_columns = 5 : i32, lhs_rows = 3 : i32, rhs_columns = 4 : i32} : (vector<15xf64>, vector<20xf64>) -> vector<12xf64>
    llvm.store %3, %arg2 {alignment = 128 : i64} : vector<15xf64>, !llvm.ptr
    llvm.return %4 : vector<12xf64>
  }
  llvm.func @chain_of_matrix_mutliplies(%arg0: vector<27xf64>, %arg1: vector<3xf64>, %arg2: vector<8xf64>) -> vector<72xf64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.fneg %arg0  : vector<27xf64>
    %5 = llvm.intr.matrix.multiply %4, %arg1 {lhs_columns = 3 : i32, lhs_rows = 9 : i32, rhs_columns = 1 : i32} : (vector<27xf64>, vector<3xf64>) -> vector<9xf64>
    %6 = llvm.intr.matrix.multiply %5, %arg2 {lhs_columns = 1 : i32, lhs_rows = 9 : i32, rhs_columns = 8 : i32} : (vector<9xf64>, vector<8xf64>) -> vector<72xf64>
    llvm.return %6 : vector<72xf64>
  }
  llvm.func @chain_of_matrix_mutliplies_with_two_negations(%arg0: vector<3xf64>, %arg1: vector<5xf64>, %arg2: vector<10xf64>) -> vector<6xf64> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.fneg %arg1  : vector<5xf64>
    %5 = llvm.intr.matrix.multiply %arg0, %4 {lhs_columns = 1 : i32, lhs_rows = 3 : i32, rhs_columns = 5 : i32} : (vector<3xf64>, vector<5xf64>) -> vector<15xf64>
    %6 = llvm.fneg %5  : vector<15xf64>
    %7 = llvm.intr.matrix.multiply %6, %arg2 {lhs_columns = 5 : i32, lhs_rows = 3 : i32, rhs_columns = 2 : i32} : (vector<15xf64>, vector<10xf64>) -> vector<6xf64>
    llvm.return %7 : vector<6xf64>
  }
  llvm.func @chain_of_matrix_mutliplies_propagation(%arg0: vector<15xf64>, %arg1: vector<20xf64>, %arg2: vector<8xf64>) -> vector<6xf64> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.fneg %arg0  : vector<15xf64>
    %5 = llvm.intr.matrix.multiply %4, %arg1 {lhs_columns = 5 : i32, lhs_rows = 3 : i32, rhs_columns = 4 : i32} : (vector<15xf64>, vector<20xf64>) -> vector<12xf64>
    %6 = llvm.intr.matrix.multiply %5, %arg2 {lhs_columns = 4 : i32, lhs_rows = 3 : i32, rhs_columns = 2 : i32} : (vector<12xf64>, vector<8xf64>) -> vector<6xf64>
    llvm.return %6 : vector<6xf64>
  }
}
