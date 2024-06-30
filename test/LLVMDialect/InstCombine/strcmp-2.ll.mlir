"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "hello", type = !llvm.array<6 x i8>, value = "hello\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "hell", type = !llvm.array<5 x i8>, value = "hell\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strcmp", type = !llvm.func<i16 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<6 x i8>>
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @hell} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.getelementptr"(%0, %1, %1) : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%3, %4) {callee = @strcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i16
    "llvm.return"(%5) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "test_nosimplify", type = !llvm.func<i16 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
