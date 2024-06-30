"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @mempcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"(%0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memcpy_nonconst_n", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @mempcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"(%0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memcpy_nonconst_n_copy_attrs", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @mempcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "memcpy_nonconst_n_unused_retval", type = !llvm.func<void (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @mempcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"(%1) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memcpy_small_const_n", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1024 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @mempcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"(%1) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memcpy_big_const_n", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.undef"() : () -> i64
    %2 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    %3 = "llvm.mlir.undef"() : () -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %2, %1) {callee = @mempcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "PR48810", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @mempcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"(%0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "memcpy_no_simplify1", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "mempcpy", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
