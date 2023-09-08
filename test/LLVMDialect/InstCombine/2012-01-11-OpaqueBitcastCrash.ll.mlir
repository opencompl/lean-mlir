"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "G", type = !llvm.array<0 x struct<"opaque_struct", opaque>>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void (ptr<struct<"opaque_struct", opaque>>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @G} : () -> !llvm.ptr<array<0 x struct<"opaque_struct", opaque>>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<array<0 x struct<"opaque_struct", opaque>>>) -> !llvm.ptr<struct<"opaque_struct", opaque>>
    "llvm.call"(%1) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"opaque_struct", opaque>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
