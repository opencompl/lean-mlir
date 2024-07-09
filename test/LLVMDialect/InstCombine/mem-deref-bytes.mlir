module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @memcmp(!llvm.ptr {llvm.nocapture}, !llvm.ptr {llvm.nocapture}, i64) -> i32
  llvm.func @memcpy(!llvm.ptr {llvm.nocapture}, !llvm.ptr {llvm.nocapture}, i64) -> !llvm.ptr
  llvm.func @memmove(!llvm.ptr {llvm.nocapture}, !llvm.ptr {llvm.nocapture}, i64) -> !llvm.ptr
  llvm.func @memset(!llvm.ptr {llvm.nocapture}, i32, i64) -> !llvm.ptr
  llvm.func @memchr(!llvm.ptr {llvm.nocapture}, i32, i64) -> !llvm.ptr
  llvm.func @memcmp_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_update_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_update_deref2(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_update_deref3(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_update_deref4(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_update_deref5(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_update_deref6(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_update_deref7(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_no_update_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_nonconst_size(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) -> i32 {
    %0 = llvm.call @memcmp(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %0 : i32
  }
  llvm.func @memcpy_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.call @memcpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @memmove_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.call @memmove(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @memset_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.call @memset(%arg0, %arg1, %0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @memchr_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.call @memchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @llvm_memcpy_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %arg0 : !llvm.ptr
  }
  llvm.func @llvm_memmove_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memmove"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %arg0 : !llvm.ptr
  }
  llvm.func @llvm_memset_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i8) -> !llvm.ptr {
    %0 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    llvm.return %arg0 : !llvm.ptr
  }
}
