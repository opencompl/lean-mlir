"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memcmp", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memcpy", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memmove", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memset", type = !llvm.func<ptr<i8> (ptr<i8>, i32, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memchr", type = !llvm.func<ptr<i8> (ptr<i8>, i32, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memcpy.p0i8.p0i8.i64", type = !llvm.func<void (ptr<i8>, ptr<i8>, i64, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memmove.p0i8.p0i8.i64", type = !llvm.func<void (ptr<i8>, ptr<i8>, i64, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memset.p0i8.i64", type = !llvm.func<void (ptr<i8>, i8, i64, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_const_size_set_deref", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_const_size_update_deref", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_const_size_update_deref2", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_const_size_update_deref3", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_const_size_update_deref4", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_const_size_update_deref5", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_const_size_update_deref6", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_const_size_update_deref7", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_const_size_no_update_deref", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_nonconst_size", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 64 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"(%1) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memcpy_const_size_set_deref", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 64 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memmove, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"(%1) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memmove_const_size_set_deref", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 64 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memset, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%1) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memset_const_size_set_deref", type = !llvm.func<ptr<i8> (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 64 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%1) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memchr_const_size_set_deref", type = !llvm.func<ptr<i8> (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    "llvm.call"(%arg0, %arg1, %1, %0) {callee = @llvm.memcpy.p0i8.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    "llvm.return"(%arg0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "llvm_memcpy_const_size_set_deref", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    "llvm.call"(%arg0, %arg1, %1, %0) {callee = @llvm.memmove.p0i8.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    "llvm.return"(%arg0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "llvm_memmove_const_size_set_deref", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    "llvm.call"(%arg0, %arg1, %1, %0) {callee = @llvm.memset.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i64, i1) -> ()
    "llvm.return"(%arg0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "llvm_memset_const_size_set_deref", type = !llvm.func<ptr<i8> (ptr<i8>, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
