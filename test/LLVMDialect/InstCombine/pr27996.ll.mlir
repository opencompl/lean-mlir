"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "i", type = i32, value = 1 : i32} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "f", type = f32, value = 1.100000e+00 : f32} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 5 : i64, sym_name = "cmp", type = i32, value = 0 : i32} : () -> ()
  "llvm.mlir.global"() ( {
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<f32>
    "llvm.return"(%0) : (!llvm.ptr<f32>) -> ()
  }) {linkage = 5 : i64, sym_name = "resf", type = !llvm.ptr<f32>} : () -> ()
  "llvm.mlir.global"() ( {
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<i32>
    "llvm.return"(%0) : (!llvm.ptr<i32>) -> ()
  }) {linkage = 5 : i64, sym_name = "resi", type = !llvm.ptr<i32>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @resi} : () -> !llvm.ptr<ptr<i32>>
    %1 = "llvm.mlir.addressof"() {global_name = @resf} : () -> !llvm.ptr<ptr<f32>>
    %2 = "llvm.mlir.addressof"() {global_name = @f} : () -> !llvm.ptr<f32>
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr<f32>) -> !llvm.ptr<i32>
    %4 = "llvm.mlir.addressof"() {global_name = @i} : () -> !llvm.ptr<i32>
    %5 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %6 = "llvm.mlir.addressof"() {global_name = @cmp} : () -> !llvm.ptr<i32>
    %7 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %8 = "llvm.mlir.addressof"() {global_name = @cmp} : () -> !llvm.ptr<i32>
    %9 = "llvm.mlir.null"() : () -> !llvm.ptr<i32>
    "llvm.br"(%9)[^bb1] : (!llvm.ptr<i32>) -> ()
  ^bb1(%10: !llvm.ptr<i32>):  // 3 preds: ^bb0, ^bb3, ^bb4
    %11 = "llvm.load"(%8) : (!llvm.ptr<i32>) -> i32
    %12 = "llvm.ashr"(%11, %7) : (i32, i32) -> i32
    "llvm.store"(%12, %6) : (i32, !llvm.ptr<i32>) -> ()
    %13 = "llvm.icmp"(%12, %5) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%13)[^bb2, ^bb5] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %14 = "llvm.and"(%12, %7) : (i32, i32) -> i32
    %15 = "llvm.icmp"(%14, %5) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%15)[^bb3, ^bb4] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "llvm.br"(%4)[^bb1] : (!llvm.ptr<i32>) -> ()
  ^bb4:  // pred: ^bb2
    "llvm.br"(%3)[^bb1] : (!llvm.ptr<i32>) -> ()
  ^bb5:  // pred: ^bb1
    %16 = "llvm.bitcast"(%10) : (!llvm.ptr<i32>) -> !llvm.ptr<f32>
    "llvm.store"(%16, %1) : (!llvm.ptr<f32>, !llvm.ptr<ptr<f32>>) -> ()
    "llvm.store"(%10, %0) : (!llvm.ptr<i32>, !llvm.ptr<ptr<i32>>) -> ()
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
