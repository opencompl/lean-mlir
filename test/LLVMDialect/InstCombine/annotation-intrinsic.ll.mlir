"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.annotation.i32", type = !llvm.func<i32 (i32, ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.undef"() : () -> !llvm.ptr<i8>
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %3 = "llvm.call"(%2, %1, %1, %0) {callee = @llvm.annotation.i32, fastmathFlags = #llvm.fastmath<>} : (i32, !llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    %4 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %5 = "llvm.add"(%3, %4) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "annotated", type = !llvm.func<i32 (ptr<i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
