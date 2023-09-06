module  {
  llvm.mlir.global private constant @hello("helloworld\00")
  llvm.mlir.global private constant @NoNulTerminator("helloworld")
  llvm.mlir.global private constant @StopCharAfterNulTerminator("helloworld\00x")
  llvm.mlir.global external constant @StringWithEOF("helloworld\FFab\00")
  llvm.func @memccpy(!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
  llvm.func @memccpy_to_memcpy(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mlir.constant(114 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_memcpy2(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(114 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_memcpy3(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(111 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return
  }
  llvm.func @memccpy_to_memcpy3_tail(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(111 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return
  }
  llvm.func @memccpy_to_memcpy3_musttail(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32, %arg3: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(111 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_memcpy4(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return
  }
  llvm.func @memccpy_to_memcpy5(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(114 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_memcpy5_tail(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(114 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_memcpy5_musttail(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32, %arg3: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(114 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_memcpy6(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.mlir.constant(114 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_memcpy7(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(115 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_memcpy8(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(11 : i64) : i64
    %1 = llvm.mlir.constant(115 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_memcpy9(%arg0: !llvm.ptr<i8>, %arg1: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.mlir.constant(120 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @StopCharAfterNulTerminator : !llvm.ptr<array<12 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<12 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_memcpy10(%arg0: !llvm.ptr<i8>, %arg1: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @StringWithEOF : !llvm.ptr<array<14 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<14 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_memcpy11(%arg0: !llvm.ptr<i8>, %arg1: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @StringWithEOF : !llvm.ptr<array<14 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<14 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_memcpy12(%arg0: !llvm.ptr<i8>, %arg1: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.mlir.constant(1023 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @StringWithEOF : !llvm.ptr<array<14 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<14 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_null(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @memccpy(%arg0, %arg1, %arg2, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_dst_src_same_retval_unused(%arg0: !llvm.ptr<i8>, %arg1: i32, %arg2: i64) {
    %0 = llvm.call @memccpy(%arg0, %arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return
  }
  llvm.func @unknown_src(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mlir.constant(114 : i32) : i32
    %2 = llvm.call @memccpy(%arg0, %arg1, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %2 : !llvm.ptr<i8>
  }
  llvm.func @unknown_stop_char(%arg0: !llvm.ptr<i8>, %arg1: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @memccpy(%arg0, %3, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @unknown_size_n(%arg0: !llvm.ptr<i8>, %arg1: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(114 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @memccpy(%arg0, %3, %0, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @no_nul_terminator(%arg0: !llvm.ptr<i8>, %arg1: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(120 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @StopCharAfterNulTerminator : !llvm.ptr<array<12 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<12 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @memccpy(%arg0, %3, %0, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @possibly_valid_data_after_array(%arg0: !llvm.ptr<i8>, %arg1: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(115 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @NoNulTerminator : !llvm.ptr<array<10 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<10 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @memccpy(%arg0, %3, %0, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @possibly_valid_data_after_array2(%arg0: !llvm.ptr<i8>, %arg1: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(115 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @memccpy(%arg0, %3, %0, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @possibly_valid_data_after_array3(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mlir.constant(115 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_dst_src_same_retval_used(%arg0: !llvm.ptr<i8>, %arg1: i32, %arg2: i64) -> !llvm.ptr<i8> {
    %0 = llvm.call @memccpy(%arg0, %arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_memcpy_musttail(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32, %arg3: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mlir.constant(114 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @memccpy_to_memcpy2_musttail(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32, %arg3: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(114 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memccpy(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
}
