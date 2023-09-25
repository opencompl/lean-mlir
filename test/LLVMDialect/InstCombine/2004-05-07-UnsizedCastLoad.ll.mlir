"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"Ty", opaque>>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<struct<"Ty", opaque>>) -> !llvm.ptr<i32>
    %1 = "llvm.load"(%0) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 (ptr<struct<"Ty", opaque>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
