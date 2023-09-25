"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = ".str", type = !llvm.array<3 x i8>, value = "%c\00"} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 97 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @".str"} : () -> !llvm.ptr<array<3 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "printf", type = !llvm.func<i32 (ptr<i8>, ...)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
