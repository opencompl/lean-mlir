"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "d", type = i32, value = 15 : i32} : () -> ()
  "llvm.mlir.global"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @d} : () -> !llvm.ptr<i32>
    "llvm.return"(%0) : (!llvm.ptr<i32>) -> ()
  }) {linkage = 10 : i64, sym_name = "b", type = !llvm.ptr<i32>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 5 : i64, sym_name = "a", type = i32, value = 0 : i32} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<i32>
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2072 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %5 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<i32>
    %6 = "llvm.mlir.addressof"() {global_name = @b} : () -> !llvm.ptr<ptr<i32>>
    %7 = "llvm.load"(%6) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    %8 = "llvm.load"(%5) : (!llvm.ptr<i32>) -> i32
    %9 = "llvm.icmp"(%8, %4) {predicate = 0 : i64} : (i32, i32) -> i1
    %10 = "llvm.zext"(%9) : (i1) -> i32
    %11 = "llvm.lshr"(%3, %10) : (i32, i32) -> i32
    %12 = "llvm.lshr"(%11, %2) : (i32, i32) -> i32
    %13 = "llvm.and"(%12, %1) : (i32, i32) -> i32
    %14 = "llvm.load"(%7) : (!llvm.ptr<i32>) -> i32
    %15 = "llvm.or"(%13, %14) : (i32, i32) -> i32
    "llvm.store"(%15, %7) : (i32, !llvm.ptr<i32>) -> ()
    %16 = "llvm.load"(%0) : (!llvm.ptr<i32>) -> i32
    %17 = "llvm.icmp"(%16, %4) {predicate = 0 : i64} : (i32, i32) -> i1
    %18 = "llvm.zext"(%17) : (i1) -> i32
    %19 = "llvm.lshr"(%3, %18) : (i32, i32) -> i32
    %20 = "llvm.lshr"(%19, %2) : (i32, i32) -> i32
    %21 = "llvm.and"(%20, %1) : (i32, i32) -> i32
    %22 = "llvm.or"(%21, %15) : (i32, i32) -> i32
    "llvm.store"(%22, %7) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"(%22) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "main", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
