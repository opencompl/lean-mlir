"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.addrspacecast"(%arg0) : (!llvm.ptr<i32>) -> !llvm.ptr<i32, 1>
    "llvm.store"(%0, %1) : (i32, !llvm.ptr<i32, 1>) -> ()
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 (ptr<i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
