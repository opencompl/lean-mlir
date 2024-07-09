module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use64(i64)
  llvm.func @useptr(!llvm.ptr)
  llvm.func @test_zero(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_nonzero(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_or_disjoint(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.or %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_zero_multiuse_index(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_zero_multiuse_ptr(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @useptr(%2) : (!llvm.ptr) -> ()
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_zero_sext_add_nsw(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1 overflow<nsw>  : i32
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_zero_trunc_add(%arg0: !llvm.ptr, %arg1: i128) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i128) : i128
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i128
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i128) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_non_i8(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_non_const(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.add %arg1, %0  : i64
    %3 = llvm.getelementptr %1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @test_too_many_indices(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.add %arg1, %0  : i64
    %3 = llvm.getelementptr %1[%0, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i32>
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @test_wrong_op(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.xor %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_sext_add_without_nsw(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i32
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_or_without_disjoint(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.or %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_smul_overflow(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(9223372036854775806 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_sadd_overflow(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(9223372036854775804 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_nonzero_multiuse_index(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_nonzero_multiuse_ptr(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @useptr(%2) : (!llvm.ptr) -> ()
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_scalable(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    llvm.return %4 : !llvm.ptr
  }
}
