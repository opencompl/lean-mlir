"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "arg", type = !llvm.func<void (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: !llvm.ptr<f64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.br"(%1)[^bb1] : (i32) -> ()
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb8
    %3 = "llvm.sext"(%2) : (i32) -> i64
    %4 = "llvm.icmp"(%3, %arg0) {predicate = 2 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%4, %1)[^bb2, ^bb9] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb2(%5: i32):  // 2 preds: ^bb1, ^bb7
    %6 = "llvm.sext"(%5) : (i32) -> i64
    %7 = "llvm.icmp"(%6, %arg0) {predicate = 2 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%7, %1)[^bb3, ^bb8] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb3(%8: i32):  // 2 preds: ^bb2, ^bb6
    %9 = "llvm.sext"(%8) : (i32) -> i64
    %10 = "llvm.icmp"(%9, %arg0) {predicate = 2 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%10, %1)[^bb4, ^bb7] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb4(%11: i32):  // 2 preds: ^bb3, ^bb5
    %12 = "llvm.sext"(%11) : (i32) -> i64
    %13 = "llvm.icmp"(%12, %arg0) {predicate = 2 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%13)[^bb5, ^bb6] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb5:  // pred: ^bb4
    %14 = "llvm.add"(%2, %5) : (i32, i32) -> i32
    %15 = "llvm.add"(%14, %8) : (i32, i32) -> i32
    %16 = "llvm.add"(%15, %11) : (i32, i32) -> i32
    %17 = "llvm.sext"(%16) : (i32) -> i64
    %18 = "llvm.getelementptr"(%arg1, %17) : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %19 = "llvm.load"(%18) : (!llvm.ptr<f64>) -> f64
    %20 = "llvm.load"(%18) : (!llvm.ptr<f64>) -> f64
    %21 = "llvm.fadd"(%19, %20) : (f64, f64) -> f64
    "llvm.call"(%21) {callee = @arg, fastmathFlags = #llvm.fastmath<>} : (f64) -> ()
    %22 = "llvm.add"(%11, %0) : (i32, i32) -> i32
    "llvm.br"(%22)[^bb4] : (i32) -> ()
  ^bb6:  // pred: ^bb4
    %23 = "llvm.add"(%8, %0) : (i32, i32) -> i32
    "llvm.br"(%23)[^bb3] : (i32) -> ()
  ^bb7:  // pred: ^bb3
    %24 = "llvm.add"(%5, %0) : (i32, i32) -> i32
    "llvm.br"(%24)[^bb2] : (i32) -> ()
  ^bb8:  // pred: ^bb2
    %25 = "llvm.add"(%2, %0) : (i32, i32) -> i32
    "llvm.br"(%25)[^bb1] : (i32) -> ()
  ^bb9:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "func", type = !llvm.func<void (i64, ptr<f64>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
