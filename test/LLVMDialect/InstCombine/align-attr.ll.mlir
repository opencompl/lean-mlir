"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "foo1", type = !llvm.func<i32 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @func1, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i32>) -> !llvm.ptr<i32>
    %1 = "llvm.load"(%0) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "foo2", type = !llvm.func<i32 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "func1", type = !llvm.func<ptr<i32> (ptr<i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
