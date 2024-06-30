"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: !llvm.ptr<i32>, %arg5: i32, %arg6: i32, %arg7: !llvm.ptr<i8>, %arg8: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = -1 : i64} : () -> i64
    %4 = "llvm.zext"(%arg1) : (i32) -> i64
    %5 = "llvm.getelementptr"(%arg7, %4) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %6 = "llvm.zext"(%arg2) : (i32) -> i64
    %7 = "llvm.getelementptr"(%5, %6) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %8 = "llvm.getelementptr"(%7, %3) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %9 = "llvm.bitcast"(%8) : (!llvm.ptr<i8>) -> !llvm.ptr<i32>
    %10 = "llvm.load"(%9) : (!llvm.ptr<i32>) -> i32
    %11 = "llvm.icmp"(%10, %arg3) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%11, %2)[^bb5, ^bb1] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%arg1, %arg6)[^bb3] : (i32, i32) -> ()
  ^bb2(%12: i32, %13: i32):  // pred: ^bb4
    %14 = "llvm.zext"(%13) : (i32) -> i64
    %15 = "llvm.getelementptr"(%arg7, %14) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %16 = "llvm.getelementptr"(%15, %6) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %17 = "llvm.getelementptr"(%16, %3) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %18 = "llvm.bitcast"(%17) : (!llvm.ptr<i8>) -> !llvm.ptr<i32>
    %19 = "llvm.load"(%18) : (!llvm.ptr<i32>) -> i32
    %20 = "llvm.icmp"(%19, %arg3) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%20, %2, %13, %12)[^bb5, ^bb3] {operand_segment_sizes = dense<[1, 1, 2]> : vector<3xi32>} : (i1, i32, i32, i32) -> ()
  ^bb3(%21: i32, %22: i32):  // 2 preds: ^bb1, ^bb2
    %23 = "llvm.and"(%21, %arg8) : (i32, i32) -> i32
    %24 = "llvm.zext"(%23) : (i32) -> i64
    %25 = "llvm.getelementptr"(%arg4, %24) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %26 = "llvm.load"(%25) : (!llvm.ptr<i32>) -> i32
    %27 = "llvm.icmp"(%26, %arg5) {predicate = 8 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%27, %1)[^bb4, ^bb5] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb4:  // pred: ^bb3
    %28 = "llvm.add"(%22, %0) : (i32, i32) -> i32
    %29 = "llvm.icmp"(%28, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%29, %1, %28, %26)[^bb5, ^bb2] {operand_segment_sizes = dense<[1, 1, 2]> : vector<3xi32>} : (i1, i32, i32, i32) -> ()
  ^bb5(%30: i32):  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    "llvm.return"(%30) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i32 (ptr<i8>, i32, i32, i32, ptr<i32>, i32, i32, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "blackhole", type = !llvm.func<void (vec<2 x ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 80 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = dense<7> : vector<2xi64>} : () -> vector<2xi64>
    %2 = "llvm.mlir.constant"() {value = dense<21> : vector<2xi64>} : () -> vector<2xi64>
    %3 = "llvm.mlir.constant"() {value = dense<[0, 1]> : vector<2xi64>} : () -> vector<2xi64>
    %4 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %6 = "llvm.mlir.undef"() : () -> i64
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %7 = "llvm.getelementptr"(%arg1, %6) : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
    %8 = "llvm.getelementptr"(%7, %5) : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
    %9 = "llvm.bitcast"(%8) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<vec<2 x ptr<i8>>>
    %10 = "llvm.getelementptr"(%9, %4, %4) : (!llvm.ptr<vec<2 x ptr<i8>>>, i64, i64) -> !llvm.ptr<ptr<i8>>
    %11 = "llvm.getelementptr"(%10, %3) : (!llvm.ptr<ptr<i8>>, vector<2xi64>) -> !llvm.vec<2 x ptr<ptr<i8>>>
    %12 = "llvm.ptrtoint"(%11) : (!llvm.vec<2 x ptr<ptr<i8>>>) -> vector<2xi64>
    %13 = "llvm.lshr"(%12, %2) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %14 = "llvm.shl"(%13, %1) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %15 = "llvm.getelementptr"(%arg0, %14) : (!llvm.ptr<i8>, vector<2xi64>) -> !llvm.vec<2 x ptr<i8>>
    %16 = "llvm.getelementptr"(%15, %0) : (!llvm.vec<2 x ptr<i8>>, i64) -> !llvm.vec<2 x ptr<i8>>
    "llvm.call"(%16) {callee = @blackhole, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<2 x ptr<i8>>) -> ()
    "llvm.br"()[^bb1] : () -> ()
  }) {linkage = 10 : i64, sym_name = "PR37005", type = !llvm.func<void (ptr<i8>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[80, 60]> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 21 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %4 = "llvm.mlir.undef"() : () -> i64
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %5 = "llvm.getelementptr"(%arg1, %4) : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
    %6 = "llvm.getelementptr"(%5, %3) : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
    %7 = "llvm.ptrtoint"(%6) : (!llvm.ptr<ptr<i8>>) -> i64
    %8 = "llvm.lshr"(%7, %2) : (i64, i64) -> i64
    %9 = "llvm.shl"(%8, %1) : (i64, i64) -> i64
    %10 = "llvm.getelementptr"(%arg0, %9) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %11 = "llvm.getelementptr"(%10, %0) : (!llvm.ptr<i8>, vector<2xi64>) -> !llvm.vec<2 x ptr<i8>>
    "llvm.call"(%11) {callee = @blackhole, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<2 x ptr<i8>>) -> ()
    "llvm.br"()[^bb1] : () -> ()
  }) {linkage = 10 : i64, sym_name = "PR37005_2", type = !llvm.func<void (ptr<i8>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<2 x ptr<i8>>, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 80 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = dense<7> : vector<2xi64>} : () -> vector<2xi64>
    %2 = "llvm.mlir.constant"() {value = dense<21> : vector<2xi64>} : () -> vector<2xi64>
    %3 = "llvm.mlir.constant"() {value = dense<[0, 1]> : vector<2xi64>} : () -> vector<2xi64>
    %4 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %6 = "llvm.mlir.undef"() : () -> i64
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %7 = "llvm.getelementptr"(%arg1, %6) : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
    %8 = "llvm.getelementptr"(%7, %5) : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
    %9 = "llvm.bitcast"(%8) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<vec<2 x ptr<i8>>>
    %10 = "llvm.getelementptr"(%9, %4, %4) : (!llvm.ptr<vec<2 x ptr<i8>>>, i64, i64) -> !llvm.ptr<ptr<i8>>
    %11 = "llvm.getelementptr"(%10, %3) : (!llvm.ptr<ptr<i8>>, vector<2xi64>) -> !llvm.vec<2 x ptr<ptr<i8>>>
    %12 = "llvm.ptrtoint"(%11) : (!llvm.vec<2 x ptr<ptr<i8>>>) -> vector<2xi64>
    %13 = "llvm.lshr"(%12, %2) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %14 = "llvm.shl"(%13, %1) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %15 = "llvm.getelementptr"(%arg0, %14) : (!llvm.vec<2 x ptr<i8>>, vector<2xi64>) -> !llvm.vec<2 x ptr<i8>>
    %16 = "llvm.getelementptr"(%15, %0) : (!llvm.vec<2 x ptr<i8>>, i64) -> !llvm.vec<2 x ptr<i8>>
    "llvm.call"(%16) {callee = @blackhole, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<2 x ptr<i8>>) -> ()
    "llvm.br"()[^bb1] : () -> ()
  }) {linkage = 10 : i64, sym_name = "PR37005_3", type = !llvm.func<void (vec<2 x ptr<i8>>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 80 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @PR51485} : () -> !llvm.ptr<func<void (vector<2xi64>)>>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<func<void (vector<2xi64>)>>) -> !llvm.ptr<i8>
    %3 = "llvm.mlir.constant"() {value = dense<7> : vector<2xi64>} : () -> vector<2xi64>
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %4 = "llvm.shl"(%arg0, %3) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %5 = "llvm.getelementptr"(%2, %4) : (!llvm.ptr<i8>, vector<2xi64>) -> !llvm.vec<2 x ptr<i8>>
    %6 = "llvm.getelementptr"(%5, %0) : (!llvm.vec<2 x ptr<i8>>, i64) -> !llvm.vec<2 x ptr<i8>>
    "llvm.call"(%6) {callee = @blackhole, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<2 x ptr<i8>>) -> ()
    "llvm.br"()[^bb1] : () -> ()
  }) {linkage = 10 : i64, sym_name = "PR51485", type = !llvm.func<void (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>, %arg1: !llvm.ptr<f32>, %arg2: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 0.000000e+00 : f32} : () -> f32
    %3 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %4 = "llvm.load"(%arg0) : (!llvm.ptr<i64>) -> i64
    %5 = "llvm.getelementptr"(%arg1, %4) : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    "llvm.br"(%3, %2)[^bb1] : (i64, f32) -> ()
  ^bb1(%6: i64, %7: f32):  // 2 preds: ^bb0, ^bb3
    %8 = "llvm.icmp"(%6, %1) {predicate = 7 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%8)[^bb3, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"(%7) : (f32) -> ()
  ^bb3:  // pred: ^bb1
    %9 = "llvm.getelementptr"(%5, %6) : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %10 = "llvm.load"(%9) : (!llvm.ptr<f32>) -> f32
    %11 = "llvm.fadd"(%7, %10) : (f32, f32) -> f32
    %12 = "llvm.add"(%6, %0) : (i64, i64) -> i64
    "llvm.br"(%12, %11)[^bb1] : (i64, f32) -> ()
  }) {linkage = 10 : i64, sym_name = "gep_cross_loop", type = !llvm.func<f32 (ptr<i64>, ptr<f32>, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i1, %arg2: i32, %arg3: i32):  // no predecessors
    %0 = "llvm.zext"(%arg3) : (i32) -> i64
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = "llvm.zext"(%arg2) : (i32) -> i64
    %2 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %3 = "llvm.getelementptr"(%2, %0) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.call"(%3) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.cond_br"(%arg1)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "only_one_inbounds", type = !llvm.func<void (ptr<i8>, i1, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i1, %arg2: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i64} : () -> i64
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = "llvm.zext"(%arg2) : (i32) -> i64
    %2 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %3 = "llvm.getelementptr"(%2, %0) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.call"(%3) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.cond_br"(%arg1)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "both_inbounds_one_neg", type = !llvm.func<void (ptr<i8>, i1, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i1, %arg2: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = "llvm.zext"(%arg2) : (i32) -> i64
    %2 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %3 = "llvm.getelementptr"(%2, %0) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.call"(%3) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.cond_br"(%arg1)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "both_inbounds_pos", type = !llvm.func<void (ptr<i8>, i1, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
