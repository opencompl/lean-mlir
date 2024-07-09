module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use_i64(i64)
  llvm.func @use_ptr(!llvm.ptr<1>)
  llvm.func @constant_fold_ptrtoint_gep_zero() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }
  llvm.func @constant_fold_ptrtoint_gep_nonzero() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }
  llvm.func @constant_fold_ptrtoint_gep_zero_inbounds() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }
  llvm.func @constant_fold_ptrtoint_gep_nonzero_inbounds() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }
  llvm.func @constant_fold_ptrtoint_of_gep_of_nullgep() {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    %4 = llvm.getelementptr %1[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %5 = llvm.ptrtoint %4 : !llvm.ptr<1> to i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    llvm.call @use_i64(%3) : (i64) -> ()
    llvm.call @use_i64(%5) : (i64) -> ()
    llvm.call @use_i64(%3) : (i64) -> ()
    llvm.call @use_i64(%5) : (i64) -> ()
    llvm.call @use_i64(%3) : (i64) -> ()
    llvm.call @use_i64(%3) : (i64) -> ()
    llvm.call @use_i64(%5) : (i64) -> ()
    llvm.call @use_i64(%5) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.return
  }
  llvm.func @fold_ptrtoint_nullgep_zero() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.add %0, %0  : i64
    %3 = llvm.getelementptr %1[%2] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i64
    llvm.return %4 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_zero_inbounds() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.add %0, %0  : i64
    %3 = llvm.getelementptr inbounds %1[%2] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i64
    llvm.return %4 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_nonzero() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %5 = llvm.ptrtoint %4 : !llvm.ptr<1> to i64
    llvm.return %5 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_nonzero_inbounds() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.getelementptr inbounds %2[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %5 = llvm.ptrtoint %4 : !llvm.ptr<1> to i64
    llvm.return %5 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_variable(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_variable_known_nonzero(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.getelementptr %1[%2] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i64
    llvm.return %4 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_variable_inbounds(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr inbounds %0[%arg0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_variable_known_nonzero_inbounds(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.getelementptr inbounds %1[%2] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i64
    llvm.return %4 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_multiple_indices(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.or %arg0, %0  : i64
    %4 = llvm.getelementptr inbounds %1[%3, %2] : (!llvm.ptr<1>, i64, i32) -> !llvm.ptr<1>, !llvm.array<2 x i8>
    %5 = llvm.ptrtoint %4 : !llvm.ptr<1> to i64
    llvm.return %5 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_i32_variable(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_variable_trunc(%arg0: i64) -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i32
    llvm.return %2 : i32
  }
  llvm.func @fold_ptrtoint_zero_nullgep_of_nonzero_inbounds_nullgep() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.sub %3, %0  : i64
    %5 = llvm.getelementptr inbounds %2[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %6 = llvm.getelementptr %5[%4] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %7 = llvm.ptrtoint %6 : !llvm.ptr<1> to i64
    llvm.return %7 : i64
  }
  llvm.func @fold_ptrtoint_nonzero_inbounds_nullgep_of_zero_noninbounds_nullgep() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.sub %3, %0  : i64
    %5 = llvm.getelementptr %2[%4] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %6 = llvm.getelementptr inbounds %5[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %7 = llvm.ptrtoint %6 : !llvm.ptr<1> to i64
    llvm.return %7 : i64
  }
  llvm.func local_unnamed_addr @fold_complex_index_last_nonzero(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %0[%1, 0, %1, 0, %arg0] : (!llvm.ptr<1>, i64, i64, i64) -> !llvm.ptr<1>, !llvm.struct<"struct.S", (array<2 x struct<"struct.K", (array<32 x i8>)>>)>
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i64
    llvm.return %4 : i64
  }
  llvm.func local_unnamed_addr @fold_complex_index_multiple_nonzero(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %0[%1, 0, %1, 0, %arg0] : (!llvm.ptr<1>, i64, i64, i64) -> !llvm.ptr<1>, !llvm.struct<"struct.S", (array<2 x struct<"struct.K", (array<32 x i8>)>>)>
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i64
    llvm.return %4 : i64
  }
  llvm.func @fold_ptrtoint_inbounds_nullgep_of_nonzero_inbounds_nullgep() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.sub %3, %0  : i64
    %5 = llvm.getelementptr inbounds %2[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %6 = llvm.getelementptr inbounds %5[%4] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %7 = llvm.ptrtoint %6 : !llvm.ptr<1> to i64
    llvm.return %7 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_array_one_var_1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.getelementptr %0[%arg0, %1] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x i16>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }
  llvm.func @fold_ptrtoint_nullgep_array_one_var_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.getelementptr %0[%1, %arg0] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x i16>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }
  llvm.func @fold_ptrtoint_nested_array_two_vars(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0, %arg1] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x i16>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }
  llvm.func @fold_ptrtoint_nested_array_two_vars_plus_zero(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.getelementptr %0[%arg0, %arg1, %1] : (!llvm.ptr<1>, i64, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x array<2 x i16>>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }
  llvm.func @fold_ptrtoint_nested_array_two_vars_plus_const(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %0[%arg0, %arg1, %1] : (!llvm.ptr<1>, i64, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x array<2 x i16>>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }
  llvm.func @fold_ptrtoint_nested_nullgep_array_variable_multiple_uses(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0, %arg1] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x i16>
    llvm.call @use_ptr(%1) : (!llvm.ptr<1>) -> ()
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }
}
