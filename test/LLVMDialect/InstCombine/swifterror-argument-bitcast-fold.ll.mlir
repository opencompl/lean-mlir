"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i32>>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @widget} : () -> !llvm.ptr<func<void (ptr<ptr<i64>>)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<void (ptr<ptr<i64>>)>>) -> !llvm.ptr<func<void (ptr<ptr<i32>>)>>
    "llvm.call"(%1, %arg0) : (!llvm.ptr<func<void (ptr<ptr<i32>>)>>, !llvm.ptr<ptr<i32>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "spam", type = !llvm.func<void (ptr<ptr<i32>>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "widget", type = !llvm.func<void (ptr<ptr<i64>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
