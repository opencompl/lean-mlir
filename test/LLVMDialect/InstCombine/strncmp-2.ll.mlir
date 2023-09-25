"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "hello", type = !llvm.array<6 x i8>, value = "hello\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "hell", type = !llvm.array<5 x i8>, value = "hell\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strncmp", type = !llvm.func<i16 (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<6 x i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @hell} : () -> !llvm.ptr<array<5 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.getelementptr"(%1, %2, %2) : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%4, %5, %0) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i16
    "llvm.return"(%6) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "test_nosimplify", type = !llvm.func<i16 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
