"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 1 : i64, sym_name = ".str", type = !llvm.array<4 x i8>, value = "%d\0A\00"} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @".str"} : () -> !llvm.ptr<array<4 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %1) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "main", type = !llvm.func<i32 (i32, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "printf", type = !llvm.func<i32 (ptr<i8>, ...)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
