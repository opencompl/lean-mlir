"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 1 : i64, sym_name = ".str", type = !llvm.array<4 x i8>, value = "xyz\00"} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @".str"} : () -> !llvm.ptr<array<4 x i8>>
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.alloca"(%4) : (i32) -> !llvm.ptr<ptr<i8>>
    "llvm.store"(%arg0, %5) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %6 = "llvm.load"(%5) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    %7 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    "llvm.call"(%6, %7, %1, %0) {callee = @llvm.memcpy.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memcpy.p0i8.p0i8.i32", type = !llvm.func<void (ptr<i8>, ptr<i8>, i32, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
