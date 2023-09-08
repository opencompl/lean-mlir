"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 2 : i64, sym_name = "g1", type = i32, value = 1 : i32} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 8 : i64, sym_name = "g2", type = i32, value = 2 : i32} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 9 : i64, sym_name = "g3", type = i32, value = 3 : i32} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 1 : i64, sym_name = "g4", type = i32, value = 4 : i32} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @g4} : () -> !llvm.ptr<i32>
    %1 = "llvm.mlir.addressof"() {global_name = @g3} : () -> !llvm.ptr<i32>
    %2 = "llvm.mlir.addressof"() {global_name = @g2} : () -> !llvm.ptr<i32>
    %3 = "llvm.mlir.addressof"() {global_name = @g1} : () -> !llvm.ptr<i32>
    %4 = "llvm.load"(%3) : (!llvm.ptr<i32>) -> i32
    %5 = "llvm.load"(%2) : (!llvm.ptr<i32>) -> i32
    %6 = "llvm.load"(%1) : (!llvm.ptr<i32>) -> i32
    %7 = "llvm.load"(%0) : (!llvm.ptr<i32>) -> i32
    %8 = "llvm.add"(%4, %5) : (i32, i32) -> i32
    %9 = "llvm.add"(%8, %6) : (i32, i32) -> i32
    %10 = "llvm.add"(%9, %7) : (i32, i32) -> i32
    "llvm.return"(%10) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
