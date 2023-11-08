"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.bitcast"(%arg0) : (!llvm.ptr<i8>) -> !llvm.ptr<struct<"struct.NSRect", (array<4 x f32>)>>
    "llvm.call"(%0, %1) {callee = @bar, fastmathFlags = #llvm.fastmath<>} : (i32, !llvm.ptr<struct<"struct.NSRect", (array<4 x f32>)>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<void (i32, ...)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
