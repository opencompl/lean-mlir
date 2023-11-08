"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 1 : i64, sym_name = "str", type = !llvm.array<6 x i8>, value = "%llx\0A\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "printf", type = !llvm.func<i32 (ptr<i8>, ...)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @str} : () -> !llvm.ptr<array<6 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %0) : (!llvm.ptr<array<6 x i8>>, i32, i64) -> !llvm.ptr<i8>
    %4 = "llvm.load"(%arg1) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    %5 = "llvm.ptrtoint"(%4) : (!llvm.ptr<i8>) -> i32
    %6 = "llvm.zext"(%5) : (i32) -> i64
    %7 = "llvm.call"(%3, %6) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "main", type = !llvm.func<i32 (i32, ptr<ptr<i8>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
