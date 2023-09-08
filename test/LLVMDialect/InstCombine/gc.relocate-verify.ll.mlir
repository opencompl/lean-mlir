"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.undef"() : () -> !llvm.metadata
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.return"(%2) : (i32) -> ()
  ^bb1:  // no predecessors
    %3 = "llvm.call"(%1, %2, %2) {callee = @llvm.experimental.gc.relocate.p1i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.metadata, i32, i32) -> !llvm.ptr<i32, 1>
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "check_verify_undef_token", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.experimental.gc.relocate.p1i32", type = !llvm.func<ptr<i32, 1> (metadata, i32, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
