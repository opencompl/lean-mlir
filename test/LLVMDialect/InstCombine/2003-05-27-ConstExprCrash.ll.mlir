"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "X", type = i32, value = 5 : i32} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @X} : () -> !llvm.ptr<i32>
    %1 = "llvm.ptrtoint"(%0) : (!llvm.ptr<i32>) -> i64
    %2 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %4 = "llvm.add"(%3, %2) : (i64, i64) -> i64
    %5 = "llvm.add"(%1, %4) : (i64, i64) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i64 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
