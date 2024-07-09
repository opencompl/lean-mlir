module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @memcpy_nonconst_n(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.call @mempcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @memcpy_nonconst_n_copy_attrs(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.call @mempcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @memcpy_nonconst_n_unused_retval(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) {
    %0 = llvm.call @mempcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @memcpy_small_const_n(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.call @mempcpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @memcpy_big_const_n(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1024 : i64) : i64
    %1 = llvm.call @mempcpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @PR48810() -> i32 {
    %0 = llvm.mlir.undef : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.undef : i64
    %3 = llvm.mlir.undef : i32
    %4 = llvm.call @mempcpy(%0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %3 : i32
  }
  llvm.func @memcpy_no_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.call @mempcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @mempcpy(!llvm.ptr, !llvm.ptr {llvm.nocapture, llvm.readonly}, i64) -> !llvm.ptr
}
