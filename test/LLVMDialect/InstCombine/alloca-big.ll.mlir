"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = -4294967296 : i864} : () -> i864
    %2 = "llvm.alloca"(%1) : (i864) -> !llvm.ptr<i8>
    %3 = "llvm.getelementptr"(%2, %0) : (!llvm.ptr<i8>, i1) -> !llvm.ptr<i8>
    "llvm.store"(%3, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_bigalloc", type = !llvm.func<void (ptr<ptr<i8>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
