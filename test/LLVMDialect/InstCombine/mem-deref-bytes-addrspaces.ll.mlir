"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memcmp", type = !llvm.func<i32 (ptr<i8, 1>, ptr<i8, 1>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8, 1>, %arg1: !llvm.ptr<i8, 1>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8, 1>, !llvm.ptr<i8, 1>, i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_const_size_update_deref", type = !llvm.func<i32 (ptr<i8, 1>, ptr<i8, 1>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8, 1>, %arg1: !llvm.ptr<i8, 1>, %arg2: i64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8, 1>, !llvm.ptr<i8, 1>, i64) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_nonconst_size_nonnnull", type = !llvm.func<i32 (ptr<i8, 1>, ptr<i8, 1>, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
