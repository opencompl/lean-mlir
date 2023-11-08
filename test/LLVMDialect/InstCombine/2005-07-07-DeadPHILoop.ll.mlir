"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    "llvm.return"() : () -> ()
  ^bb1(%1: i32):  // pred: ^bb1
    %2 = "llvm.sdiv"(%1, %0) : (i32, i32) -> i32
    "llvm.store"(%2, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"(%2)[^bb1] : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
