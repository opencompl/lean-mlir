"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"struct.CGPoint", (f32, f32)>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<struct<"struct.CGPoint", (f32, f32)>>
    %2 = "llvm.bitcast"(%arg0) : (!llvm.ptr<struct<"struct.CGPoint", (f32, f32)>>) -> !llvm.ptr<i64>
    %3 = "llvm.bitcast"(%1) : (!llvm.ptr<struct<"struct.CGPoint", (f32, f32)>>) -> !llvm.ptr<i64>
    %4 = "llvm.load"(%2) : (!llvm.ptr<i64>) -> i64
    "llvm.store"(%4, %3) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.call"(%3) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "t", type = !llvm.func<void (ptr<struct<"struct.CGPoint", (f32, f32)>>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void (ptr<i64>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
