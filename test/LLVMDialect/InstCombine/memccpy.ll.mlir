"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = "hello", type = !llvm.array<11 x i8>, value = "helloworld\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = "NoNulTerminator", type = !llvm.array<10 x i8>, value = "helloworld"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = "StopCharAfterNulTerminator", type = !llvm.array<12 x i8>, value = "helloworld\00x"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "StringWithEOF", type = !llvm.array<14 x i8>, value = "helloworld\FFab\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memccpy", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i32, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 12 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 114 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 114 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy2", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 111 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy3", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 111 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy3_tail", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32, %arg3: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 111 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy3_musttail", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i32, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 12 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy4", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 114 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy5", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 114 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy5_tail", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32, %arg3: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 114 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy5_musttail", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i32, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 114 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy6", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 115 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy7", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 11 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 115 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy8", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 15 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 120 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @StopCharAfterNulTerminator} : () -> !llvm.ptr<array<12 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<12 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy9", type = !llvm.func<ptr<i8> (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 15 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 255 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @StringWithEOF} : () -> !llvm.ptr<array<14 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<14 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy10", type = !llvm.func<ptr<i8> (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 15 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @StringWithEOF} : () -> !llvm.ptr<array<14 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<14 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy11", type = !llvm.func<ptr<i8> (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 15 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1023 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @StringWithEOF} : () -> !llvm.ptr<array<14 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<14 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy12", type = !llvm.func<ptr<i8> (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %arg2, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%1) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_null", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32, %arg2: i64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg0, %arg1, %arg2) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_dst_src_same_retval_unused", type = !llvm.func<void (ptr<i8>, i32, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 12 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 114 : i32} : () -> i32
    %2 = "llvm.call"(%arg0, %arg1, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%2) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "unknown_src", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 12 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3, %arg1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "unknown_stop_char", type = !llvm.func<ptr<i8> (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 114 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3, %0, %arg1) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "unknown_size_n", type = !llvm.func<ptr<i8> (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 120 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @StopCharAfterNulTerminator} : () -> !llvm.ptr<array<12 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<12 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3, %0, %arg1) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "no_nul_terminator", type = !llvm.func<ptr<i8> (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 115 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @NoNulTerminator} : () -> !llvm.ptr<array<10 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<10 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3, %0, %arg1) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "possibly_valid_data_after_array", type = !llvm.func<ptr<i8> (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 115 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3, %0, %arg1) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "possibly_valid_data_after_array2", type = !llvm.func<ptr<i8> (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 12 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 115 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "possibly_valid_data_after_array3", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32, %arg2: i64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg0, %arg1, %arg2) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_dst_src_same_retval_used", type = !llvm.func<ptr<i8> (ptr<i8>, i32, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32, %arg3: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 12 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 114 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy_musttail", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i32, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32, %arg3: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 114 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1, %0) {callee = @memccpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memccpy_to_memcpy2_musttail", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i32, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
