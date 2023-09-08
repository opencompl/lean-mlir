"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void (i32)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @foo} : () -> !llvm.ptr<func<void (i32)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<void (i32)>>) -> !llvm.ptr<func<void ()>>
    "llvm.call"(%1) : (!llvm.ptr<func<void ()>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "g", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
