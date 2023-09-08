"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = ".str", type = !llvm.array<3 x i8>, value = "%s\00"} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"union.anon", (i32, array<4 x i8>)>>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @".str"} : () -> !llvm.ptr<array<3 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<3 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%arg1, %2, %arg0) {callee = @sprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, !llvm.ptr<struct<"union.anon", (i32, array<4 x i8>)>>) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "CopyEventArg", type = !llvm.func<void (ptr<struct<"union.anon", (i32, array<4 x i8>)>>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sprintf", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, ...)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
