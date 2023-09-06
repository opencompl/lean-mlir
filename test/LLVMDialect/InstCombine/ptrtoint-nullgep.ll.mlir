module  {
  llvm.func @use_i64(i64)
  llvm.func @use_ptr(!llvm.ptr<i8, 1>)
  llvm.func @constant_fold_ptrtoint_gep_zero() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }
  llvm.func @constant_fold_ptrtoint_gep_nonzero() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.null : !llvm.ptr<i32>
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    %4 = llvm.ptrtoint %3 : !llvm.ptr<i32> to i64
    %5 = llvm.mul %4, %0  : i64
    llvm.return %5 : i64
  }
  llvm.func @constant_fold_ptrtoint_gep_zero_inbounds() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }
  llvm.func @constant_fold_ptrtoint_gep_nonzero_inbounds() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.null : !llvm.ptr<i32>
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    %4 = llvm.ptrtoint %3 : !llvm.ptr<i32> to i64
    %5 = llvm.mul %4, %0  : i64
    llvm.return %5 : i64
  }
  llvm.func @constant_fold_ptrtoint_of_gep_of_nullgep() {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1234 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.null : !llvm.ptr<i8>
    %4 = llvm.getelementptr %3[%2] : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    %5 = llvm.ptrtoint %4 : !llvm.ptr<i8> to i64
    %6 = llvm.mul %5, %1  : i64
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%0) : (i64) -> ()
    llvm.call @use_i64(%0) : (i64) -> ()
    llvm.call @use_i64(%0) : (i64) -> ()
    llvm.call @use_i64(%0) : (i64) -> ()
    llvm.return
  }
  llvm.func @fold_ptrtoint_nullgep_zero() -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<i8, 1>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.add %1, %1  : i64
    %3 = llvm.getelementptr %0[%2] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %4 = llvm.ptrtoint %3 : !llvm.ptr<i8, 1> to i64
    llvm.return %4 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_zero_inbounds() -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<i8, 1>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.add %1, %1  : i64
    %3 = llvm.getelementptr %0[%2] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %4 = llvm.ptrtoint %3 : !llvm.ptr<i8, 1> to i64
    llvm.return %4 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_nonzero() -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<i8, 1>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1234 : i64) : i64
    %3 = llvm.add %2, %1  : i64
    %4 = llvm.getelementptr %0[%3] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %5 = llvm.ptrtoint %4 : !llvm.ptr<i8, 1> to i64
    llvm.return %5 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_nonzero_inbounds() -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<i8, 1>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1234 : i64) : i64
    %3 = llvm.add %2, %1  : i64
    %4 = llvm.getelementptr %0[%3] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %5 = llvm.ptrtoint %4 : !llvm.ptr<i8, 1> to i64
    llvm.return %5 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_variable(%arg0: i64) -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<i8, 1>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<i8, 1> to i64
    llvm.return %2 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_variable_known_nonzero(%arg0: i64) -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<i8, 1>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.or %arg0, %1  : i64
    %3 = llvm.getelementptr %0[%2] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %4 = llvm.ptrtoint %3 : !llvm.ptr<i8, 1> to i64
    llvm.return %4 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_variable_inbounds(%arg0: i64) -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<i8, 1>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<i8, 1> to i64
    llvm.return %2 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_variable_known_nonzero_inbounds(%arg0: i64) -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<i8, 1>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.or %arg0, %1  : i64
    %3 = llvm.getelementptr %0[%2] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %4 = llvm.ptrtoint %3 : !llvm.ptr<i8, 1> to i64
    llvm.return %4 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_multiple_indices(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<array<2 x i8>, 1>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.or %arg0, %2  : i64
    %4 = llvm.getelementptr %1[%3, %0] : (!llvm.ptr<array<2 x i8>, 1>, i64, i32) -> !llvm.ptr<i8, 1>
    %5 = llvm.ptrtoint %4 : !llvm.ptr<i8, 1> to i64
    llvm.return %5 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_i32_variable(%arg0: i64) -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<i32, 1>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<i32, 1> to i64
    llvm.return %2 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_variable_trunc(%arg0: i64) -> i32 {
    %0 = llvm.mlir.null : !llvm.ptr<i8, 1>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<i8, 1> to i32
    llvm.return %2 : i32
  }
  llvm.func @fold_ptrtoint_zero_nullgep_of_nonzero_inbounds_nullgep() -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<i8, 1>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1234 : i64) : i64
    %3 = llvm.add %2, %1  : i64
    %4 = llvm.sub %3, %2  : i64
    %5 = llvm.getelementptr %0[%3] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %6 = llvm.getelementptr %5[%4] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %7 = llvm.ptrtoint %6 : !llvm.ptr<i8, 1> to i64
    llvm.return %7 : i64
  }
  llvm.func @fold_ptrtoint_nonzero_inbounds_nullgep_of_zero_noninbounds_nullgep() -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<i8, 1>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1234 : i64) : i64
    %3 = llvm.add %2, %1  : i64
    %4 = llvm.sub %3, %2  : i64
    %5 = llvm.getelementptr %0[%4] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %6 = llvm.getelementptr %5[%3] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %7 = llvm.ptrtoint %6 : !llvm.ptr<i8, 1> to i64
    llvm.return %7 : i64
  }
  llvm.func @fold_complex_index_last_nonzero(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.null : !llvm.ptr<struct<"struct.S", (array<2 x struct<"struct.K", (array<32 x i8>)>>)>, 1>
    %3 = llvm.getelementptr %2[%1, %0, %1, %0, %arg0] : (!llvm.ptr<struct<"struct.S", (array<2 x struct<"struct.K", (array<32 x i8>)>>)>, 1>, i64, i32, i64, i32, i64) -> !llvm.ptr<i8, 1>
    %4 = llvm.ptrtoint %3 : !llvm.ptr<i8, 1> to i64
    llvm.return %4 : i64
  }
  llvm.func @fold_complex_index_multiple_nonzero(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.null : !llvm.ptr<struct<"struct.S", (array<2 x struct<"struct.K", (array<32 x i8>)>>)>, 1>
    %3 = llvm.getelementptr %2[%1, %0, %1, %0, %arg0] : (!llvm.ptr<struct<"struct.S", (array<2 x struct<"struct.K", (array<32 x i8>)>>)>, 1>, i64, i32, i64, i32, i64) -> !llvm.ptr<i8, 1>
    %4 = llvm.ptrtoint %3 : !llvm.ptr<i8, 1> to i64
    llvm.return %4 : i64
  }
  llvm.func @fold_ptrtoint_inbounds_nullgep_of_nonzero_inbounds_nullgep() -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<i8, 1>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1234 : i64) : i64
    %3 = llvm.add %2, %1  : i64
    %4 = llvm.sub %3, %2  : i64
    %5 = llvm.getelementptr %0[%3] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %6 = llvm.getelementptr %5[%4] : (!llvm.ptr<i8, 1>, i64) -> !llvm.ptr<i8, 1>
    %7 = llvm.ptrtoint %6 : !llvm.ptr<i8, 1> to i64
    llvm.return %7 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_array_one_var_1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.null : !llvm.ptr<array<2 x i16>, 1>
    %2 = llvm.getelementptr %1[%arg0, %0] : (!llvm.ptr<array<2 x i16>, 1>, i64, i64) -> !llvm.ptr<i16, 1>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<i16, 1> to i64
    llvm.return %3 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_array_one_var_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.null : !llvm.ptr<array<2 x i16>, 1>
    %2 = llvm.getelementptr %1[%0, %arg0] : (!llvm.ptr<array<2 x i16>, 1>, i64, i64) -> !llvm.ptr<i16, 1>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<i16, 1> to i64
    llvm.return %3 : i64
  }
  llvm.func @fold_ptrtoint_nested_array_two_vars(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<array<2 x i16>, 1>
    %1 = llvm.getelementptr %0[%arg0, %arg1] : (!llvm.ptr<array<2 x i16>, 1>, i64, i64) -> !llvm.ptr<i16, 1>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<i16, 1> to i64
    llvm.return %2 : i64
  }
  llvm.func @fold_ptrtoint_nested_array_two_vars_plus_zero(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.null : !llvm.ptr<array<2 x array<2 x i16>>, 1>
    %2 = llvm.getelementptr %1[%arg0, %arg1, %0] : (!llvm.ptr<array<2 x array<2 x i16>>, 1>, i64, i64, i64) -> !llvm.ptr<i16, 1>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<i16, 1> to i64
    llvm.return %3 : i64
  }
  llvm.func @fold_ptrtoint_nested_array_two_vars_plus_const(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.null : !llvm.ptr<array<2 x array<2 x i16>>, 1>
    %2 = llvm.getelementptr %1[%arg0, %arg1, %0] : (!llvm.ptr<array<2 x array<2 x i16>>, 1>, i64, i64, i64) -> !llvm.ptr<i16, 1>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<i16, 1> to i64
    llvm.return %3 : i64
  }
  llvm.func @fold_ptrtoint_nested_nullgep_array_variable_multiple_uses(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<array<2 x i16>, 1>
    %1 = llvm.getelementptr %0[%arg0, %arg1] : (!llvm.ptr<array<2 x i16>, 1>, i64, i64) -> !llvm.ptr<i16, 1>
    %2 = llvm.bitcast %1 : !llvm.ptr<i16, 1> to !llvm.ptr<i8, 1>
    llvm.call @use_ptr(%2) : (!llvm.ptr<i8, 1>) -> ()
    %3 = llvm.ptrtoint %1 : !llvm.ptr<i16, 1> to i64
    llvm.return %3 : i64
  }
}
