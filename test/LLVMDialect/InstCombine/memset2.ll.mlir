"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"struct.Moves", (array<9 x i8>, i8, i8, i8, array<5 x i8>)>, 1>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %3 = "llvm.mlir.constant"() {value = 9 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %6 = "llvm.getelementptr"(%arg0, %5, %4, %3) : (!llvm.ptr<struct<"struct.Moves", (array<9 x i8>, i8, i8, i8, array<5 x i8>)>, 1>, i32, i32, i32) -> !llvm.ptr<i8, 1>
    "llvm.call"(%6, %2, %1, %0) {callee = @llvm.memset.p1i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8, 1>, i8, i64, i1) -> ()
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 (ptr<struct<"struct.Moves", (array<9 x i8>, i8, i8, i8, array<5 x i8>)>, 1>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memset.p1i8.i64", type = !llvm.func<void (ptr<i8, 1>, i8, i64, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
