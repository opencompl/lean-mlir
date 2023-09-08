"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 1 : i64, sym_name = ".str1", type = !llvm.array<4 x i8>, value = "\B5%8\00"} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @".str1"} : () -> !llvm.ptr<array<4 x i8>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<array<4 x i8>>) -> !llvm.ptr<i32>
    %2 = "llvm.load"(%1) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
