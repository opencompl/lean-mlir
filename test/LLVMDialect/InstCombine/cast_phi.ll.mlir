"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0.000000e+00 : f32} : () -> f32
    %2 = "llvm.mlir.constant"() {value = 256 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %6 = "llvm.alloca"(%5) : (i32) -> !llvm.ptr<array<258 x f32>>
    %7 = "llvm.alloca"(%5) : (i32) -> !llvm.ptr<array<258 x f32>>
    %8 = "llvm.uitofp"(%arg0) : (i32) -> f32
    %9 = "llvm.bitcast"(%8) : (f32) -> i32
    %10 = "llvm.zext"(%arg1) : (i32) -> i64
    %11 = "llvm.getelementptr"(%6, %4, %10) : (!llvm.ptr<array<258 x f32>>, i64, i64) -> !llvm.ptr<f32>
    %12 = "llvm.bitcast"(%11) : (!llvm.ptr<f32>) -> !llvm.ptr<i32>
    "llvm.store"(%9, %12) : (i32, !llvm.ptr<i32>) -> ()
    %13 = "llvm.getelementptr"(%7, %4, %10) : (!llvm.ptr<array<258 x f32>>, i64, i64) -> !llvm.ptr<f32>
    %14 = "llvm.bitcast"(%13) : (!llvm.ptr<f32>) -> !llvm.ptr<i32>
    "llvm.store"(%9, %14) : (i32, !llvm.ptr<i32>) -> ()
    %15 = "llvm.icmp"(%arg1, %3) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%15)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %16 = "llvm.getelementptr"(%6, %4, %2) : (!llvm.ptr<array<258 x f32>>, i64, i64) -> !llvm.ptr<f32>
    "llvm.store"(%8, %16) : (f32, !llvm.ptr<f32>) -> ()
    %17 = "llvm.getelementptr"(%7, %4, %2) : (!llvm.ptr<array<258 x f32>>, i64, i64) -> !llvm.ptr<f32>
    "llvm.store"(%1, %17) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %18 = "llvm.icmp"(%arg0, %3) {predicate = 4 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%18, %9, %9, %arg0)[^bb3, ^bb8] {operand_segment_sizes = dense<[1, 3, 0]> : vector<3xi32>} : (i1, i32, i32, i32) -> ()
  ^bb3(%19: i32, %20: i32, %21: i32):  // 2 preds: ^bb2, ^bb12
    %22 = "llvm.icmp"(%21, %arg2) {predicate = 8 : i64} : (i32, i32) -> i1
    %23 = "llvm.add"(%21, %5) : (i32, i32) -> i32
    %24 = "llvm.sext"(%23) : (i32) -> i64
    %25 = "llvm.getelementptr"(%6, %4, %24) : (!llvm.ptr<array<258 x f32>>, i64, i64) -> !llvm.ptr<f32>
    %26 = "llvm.bitcast"(%25) : (!llvm.ptr<f32>) -> !llvm.ptr<i32>
    %27 = "llvm.getelementptr"(%7, %4, %24) : (!llvm.ptr<array<258 x f32>>, i64, i64) -> !llvm.ptr<f32>
    %28 = "llvm.bitcast"(%27) : (!llvm.ptr<f32>) -> !llvm.ptr<i32>
    %29 = "llvm.icmp"(%21, %arg2) {predicate = 6 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%22, %19, %20)[^bb4, ^bb5] {operand_segment_sizes = dense<[1, 0, 2]> : vector<3xi32>} : (i1, i32, i32) -> ()
  ^bb4:  // pred: ^bb3
    %30 = "llvm.load"(%26) : (!llvm.ptr<i32>) -> i32
    %31 = "llvm.load"(%28) : (!llvm.ptr<i32>) -> i32
    %32 = "llvm.bitcast"(%31) : (i32) -> f32
    %33 = "llvm.bitcast"(%30) : (i32) -> f32
    %34 = "llvm.fadd"(%32, %33) : (f32, f32) -> f32
    %35 = "llvm.bitcast"(%19) : (i32) -> f32
    %36 = "llvm.fadd"(%34, %35) : (f32, f32) -> f32
    %37 = "llvm.bitcast"(%36) : (f32) -> i32
    %38 = "llvm.bitcast"(%20) : (i32) -> f32
    %39 = "llvm.fadd"(%36, %38) : (f32, f32) -> f32
    %40 = "llvm.bitcast"(%39) : (f32) -> i32
    "llvm.br"(%37, %40)[^bb5] : (i32, i32) -> ()
  ^bb5(%41: i32, %42: i32):  // 2 preds: ^bb3, ^bb4
    "llvm.cond_br"(%29)[^bb6, ^bb7] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb6:  // pred: ^bb5
    "llvm.store"(%42, %12) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%41, %14) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"()[^bb7] : () -> ()
  ^bb7:  // 2 preds: ^bb5, ^bb6
    "llvm.cond_br"(%22, %41, %42)[^bb9, ^bb10] {operand_segment_sizes = dense<[1, 0, 2]> : vector<3xi32>} : (i1, i32, i32) -> ()
  ^bb8:  // 2 preds: ^bb2, ^bb12
    "llvm.return"() : () -> ()
  ^bb9:  // pred: ^bb7
    %43 = "llvm.load"(%26) : (!llvm.ptr<i32>) -> i32
    %44 = "llvm.load"(%28) : (!llvm.ptr<i32>) -> i32
    %45 = "llvm.bitcast"(%44) : (i32) -> f32
    %46 = "llvm.bitcast"(%43) : (i32) -> f32
    %47 = "llvm.fadd"(%45, %46) : (f32, f32) -> f32
    %48 = "llvm.bitcast"(%41) : (i32) -> f32
    %49 = "llvm.fadd"(%47, %48) : (f32, f32) -> f32
    %50 = "llvm.bitcast"(%49) : (f32) -> i32
    %51 = "llvm.bitcast"(%42) : (i32) -> f32
    %52 = "llvm.fadd"(%49, %51) : (f32, f32) -> f32
    %53 = "llvm.bitcast"(%52) : (f32) -> i32
    "llvm.br"(%50, %53)[^bb10] : (i32, i32) -> ()
  ^bb10(%54: i32, %55: i32):  // 2 preds: ^bb7, ^bb9
    "llvm.cond_br"(%29)[^bb11, ^bb12] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb11:  // pred: ^bb10
    "llvm.store"(%55, %12) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%54, %14) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"()[^bb12] : () -> ()
  ^bb12:  // 2 preds: ^bb10, ^bb11
    %56 = "llvm.add"(%21, %0) : (i32, i32) -> i32
    %57 = "llvm.icmp"(%56, %3) {predicate = 4 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%57, %54, %55, %56)[^bb3, ^bb8] {operand_segment_sizes = dense<[1, 3, 0]> : vector<3xi32>} : (i1, i32, i32, i32) -> ()
  }) {linkage = 10 : i64, sym_name = "MainKernel", type = !llvm.func<void (i32, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "get_i32", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "get_i3", type = !llvm.func<i3 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %2 = "llvm.icmp"(%arg0, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %3 = "llvm.call"() {callee = @get_i32, fastmathFlags = #llvm.fastmath<>} : () -> i32
    "llvm.br"(%3)[^bb3] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.call"() {callee = @bar, fastmathFlags = #llvm.fastmath<>} : () -> ()
    "llvm.br"(%0)[^bb3] : (i32) -> ()
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    %5 = "llvm.zext"(%4) : (i32) -> i37
    "llvm.return"(%5) : (i37) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_from_legal_to_illegal_type", type = !llvm.func<i37 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i3} : () -> i3
    %1 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %2 = "llvm.icmp"(%arg0, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %3 = "llvm.call"() {callee = @get_i3, fastmathFlags = #llvm.fastmath<>} : () -> i3
    "llvm.br"(%3)[^bb3] : (i3) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.call"() {callee = @bar, fastmathFlags = #llvm.fastmath<>} : () -> ()
    "llvm.br"(%0)[^bb3] : (i3) -> ()
  ^bb3(%4: i3):  // 2 preds: ^bb1, ^bb2
    %5 = "llvm.zext"(%4) : (i3) -> i37
    "llvm.return"(%5) : (i37) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_from_illegal_to_illegal_type", type = !llvm.func<i37 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %2 = "llvm.icmp"(%arg0, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %3 = "llvm.call"() {callee = @get_i32, fastmathFlags = #llvm.fastmath<>} : () -> i32
    "llvm.br"(%3)[^bb3] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.call"() {callee = @bar, fastmathFlags = #llvm.fastmath<>} : () -> ()
    "llvm.br"(%0)[^bb3] : (i32) -> ()
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    %5 = "llvm.zext"(%4) : (i32) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_from_legal_to_legal_type", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i3} : () -> i3
    %1 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %2 = "llvm.icmp"(%arg0, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %3 = "llvm.call"() {callee = @get_i3, fastmathFlags = #llvm.fastmath<>} : () -> i3
    "llvm.br"(%3)[^bb3] : (i3) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.call"() {callee = @bar, fastmathFlags = #llvm.fastmath<>} : () -> ()
    "llvm.br"(%0)[^bb3] : (i3) -> ()
  ^bb3(%4: i3):  // 2 preds: ^bb1, ^bb2
    %5 = "llvm.zext"(%4) : (i3) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_from_illegal_to_legal_type", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.br"(%2, %1)[^bb1] : (i32, i32) -> ()
  ^bb1(%3: i32, %4: i32):  // 2 preds: ^bb0, ^bb2
    %5 = "llvm.icmp"(%3, %0) {predicate = 6 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%5)[^bb2, ^bb3] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %6 = "llvm.add"(%3, %1) : (i32, i32) -> i32
    "llvm.br"(%6, %6)[^bb1] : (i32, i32) -> ()
  ^bb3:  // pred: ^bb1
    %7 = "llvm.trunc"(%4) : (i32) -> i8
    "llvm.return"(%7) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "trunc_in_loop_exit_block", type = !llvm.func<i8 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    "llvm.br"(%0)[^bb1] : (i8) -> ()
  ^bb1(%1: i8):  // 2 preds: ^bb0, ^bb2
    %2 = "llvm.zext"(%1) : (i8) -> i32
    %3 = "llvm.icmp"(%2, %arg1) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%3)[^bb2, ^bb3] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %4 = "llvm.zext"(%arg0) : (i8) -> i32
    %5 = "llvm.add"(%2, %4) : (i32, i32) -> i32
    %6 = "llvm.trunc"(%5) : (i32) -> i8
    "llvm.br"(%6)[^bb1] : (i8) -> ()
  ^bb3:  // pred: ^bb1
    %7 = "llvm.zext"(%1) : (i8) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_in_loop_and_exit_block", type = !llvm.func<i32 (i8, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
