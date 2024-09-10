module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global private constant @hello("helloworld\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private constant @NoNulTerminator("helloworld") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private constant @StopCharAfterNulTerminator("helloworld\00x") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global external constant @StringWithEOF("helloworld\FFab\00") {addr_space = 0 : i32, alignment = 1 : i64}
  llvm.func @memccpy(!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
  llvm.func @memccpy_to_memcpy(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(12 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_to_memcpy2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(8 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_to_memcpy3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(111 : i32) : i32
    %3 = llvm.mlir.constant(10 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @memccpy_to_memcpy3_tail(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(111 : i32) : i32
    %3 = llvm.mlir.constant(10 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @memccpy_to_memcpy3_musttail(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(111 : i32) : i32
    %3 = llvm.mlir.constant(10 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_to_memcpy4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(12 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @memccpy_to_memcpy5(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(7 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_to_memcpy5_tail(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(7 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_to_memcpy5_musttail(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(7 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_to_memcpy6(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_to_memcpy7(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(115 : i32) : i32
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_to_memcpy8(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(115 : i32) : i32
    %3 = llvm.mlir.constant(11 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_to_memcpy9(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00x") : !llvm.array<12 x i8>
    %1 = llvm.mlir.addressof @StopCharAfterNulTerminator : !llvm.ptr
    %2 = llvm.mlir.constant(120 : i32) : i32
    %3 = llvm.mlir.constant(15 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_to_memcpy10(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\FFab\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @StringWithEOF : !llvm.ptr
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(15 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_to_memcpy11(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\FFab\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @StringWithEOF : !llvm.ptr
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(15 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_to_memcpy12(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\FFab\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @StringWithEOF : !llvm.ptr
    %2 = llvm.mlir.constant(1023 : i32) : i32
    %3 = llvm.mlir.constant(15 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_to_null(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @memccpy(%arg0, %arg1, %arg2, %0) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @memccpy_dst_src_same_retval_unused(%arg0: !llvm.ptr, %arg1: i32, %arg2: i64) {
    %0 = llvm.call @memccpy(%arg0, %arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @unknown_src(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(114 : i32) : i32
    %1 = llvm.mlir.constant(12 : i64) : i64
    %2 = llvm.call @memccpy(%arg0, %arg1, %0, %1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @unknown_stop_char(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i64) : i64
    %3 = llvm.call @memccpy(%arg0, %1, %arg1, %2) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @unknown_size_n(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.call @memccpy(%arg0, %1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @no_nul_terminator(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00x") : !llvm.array<12 x i8>
    %1 = llvm.mlir.addressof @StopCharAfterNulTerminator : !llvm.ptr
    %2 = llvm.mlir.constant(120 : i32) : i32
    %3 = llvm.call @memccpy(%arg0, %1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @possibly_valid_data_after_array(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @NoNulTerminator : !llvm.ptr
    %2 = llvm.mlir.constant(115 : i32) : i32
    %3 = llvm.call @memccpy(%arg0, %1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @possibly_valid_data_after_array2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(115 : i32) : i32
    %3 = llvm.call @memccpy(%arg0, %1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @possibly_valid_data_after_array3(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(115 : i32) : i32
    %3 = llvm.mlir.constant(12 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_dst_src_same_retval_used(%arg0: !llvm.ptr, %arg1: i32, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.call @memccpy(%arg0, %arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @memccpy_to_memcpy_musttail(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(12 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memccpy_to_memcpy2_musttail(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(8 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
}
