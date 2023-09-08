"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i32>
    %4 = "llvm.getelementptr"(%3, %1) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    %5 = "llvm.getelementptr"(%3, %0) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%arg0, %4) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%1, %5) : (i32, !llvm.ptr<i32>) -> ()
    %6 = "llvm.load"(%4) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
