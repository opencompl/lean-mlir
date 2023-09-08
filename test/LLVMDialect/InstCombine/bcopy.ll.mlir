"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bcopy", type = !llvm.func<void (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    "llvm.call"(%arg0, %arg1, %0) {callee = @bcopy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bcopy_memmove", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32):  // no predecessors
    "llvm.call"(%arg0, %arg1, %arg2) {callee = @bcopy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bcopy_memmove2", type = !llvm.func<void (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
