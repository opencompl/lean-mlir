"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"Foo", packed (i8, f80)>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.getelementptr"(%arg0, %0, %0) : (!llvm.ptr<struct<"Foo", packed (i8, f80)>>, i32, i32) -> !llvm.ptr<i8>
    %2 = "llvm.load"(%1) : (!llvm.ptr<i8>) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t", type = !llvm.func<i8 (ptr<struct<"Foo", packed (i8, f80)>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
