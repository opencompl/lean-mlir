"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.ptrtoint"(%arg0) : (!llvm.ptr<i32>) -> i32
    %1 = "llvm.inttoptr"(%0) : (i32) -> !llvm.ptr<i32>
    "llvm.return"(%1) : (!llvm.ptr<i32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<ptr<i32> (ptr<i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
