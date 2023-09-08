"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 9 : i64, sym_name = "real_init", type = !llvm.array<2 x i8>, value = "y\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 4 : i64, sym_name = "fake_init", type = !llvm.array<2 x i8>, value = "y\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = ".str", type = !llvm.array<2 x i8>, value = "y\00"} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @".str"} : () -> !llvm.ptr<array<2 x i8>>
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @fake_init} : () -> !llvm.ptr<array<2 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<2 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.getelementptr"(%0, %1, %1) : (!llvm.ptr<array<2 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%3, %4) {callee = @strcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @".str"} : () -> !llvm.ptr<array<2 x i8>>
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @real_init} : () -> !llvm.ptr<array<2 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<2 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.getelementptr"(%0, %1, %1) : (!llvm.ptr<array<2 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%3, %4) {callee = @strcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strcmp", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
