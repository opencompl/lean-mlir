"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "_ZTIi", type = !llvm.ptr<i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = ".str.4", type = !llvm.array<100 x i8>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"struct1", (ptr<struct<"struct2", (i32, i32)>>, i32, i32, i32)>>, %arg1: i1, %arg2: i64, %arg3: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.getelementptr"(%arg0, %2, %1) : (!llvm.ptr<struct<"struct1", (ptr<struct<"struct2", (i32, i32)>>, i32, i32, i32)>>, i64, i32) -> !llvm.ptr<ptr<struct<"struct2", (i32, i32)>>>
    %4 = "llvm.load"(%3) : (!llvm.ptr<ptr<struct<"struct2", (i32, i32)>>>) -> !llvm.ptr<struct<"struct2", (i32, i32)>>
    "llvm.cond_br"(%arg1)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %5 = "llvm.getelementptr"(%4, %arg2) : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64) -> !llvm.ptr<struct<"struct2", (i32, i32)>>
    %6 = "llvm.getelementptr"(%5, %2, %1) : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    "llvm.store"(%1, %6) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"(%5)[^bb3] : (!llvm.ptr<struct<"struct2", (i32, i32)>>) -> ()
  ^bb2:  // pred: ^bb0
    %7 = "llvm.getelementptr"(%4, %arg3) : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64) -> !llvm.ptr<struct<"struct2", (i32, i32)>>
    %8 = "llvm.getelementptr"(%7, %2, %1) : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    "llvm.store"(%1, %8) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"(%7)[^bb3] : (!llvm.ptr<struct<"struct2", (i32, i32)>>) -> ()
  ^bb3(%9: !llvm.ptr<struct<"struct2", (i32, i32)>>):  // 2 preds: ^bb1, ^bb2
    %10 = "llvm.getelementptr"(%9, %2, %0) : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    %11 = "llvm.load"(%10) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%11) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i32 (ptr<struct<"struct1", (ptr<struct<"struct2", (i32, i32)>>, i32, i32, i32)>>, i1, i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"struct1", (ptr<struct<"struct2", (i32, i32)>>, i32, i32, i32)>>, %arg1: i1, %arg2: i64, %arg3: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.getelementptr"(%arg0, %2, %1) : (!llvm.ptr<struct<"struct1", (ptr<struct<"struct2", (i32, i32)>>, i32, i32, i32)>>, i64, i32) -> !llvm.ptr<ptr<struct<"struct2", (i32, i32)>>>
    %4 = "llvm.load"(%3) : (!llvm.ptr<ptr<struct<"struct2", (i32, i32)>>>) -> !llvm.ptr<struct<"struct2", (i32, i32)>>
    %5 = "llvm.getelementptr"(%4, %arg2) : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64) -> !llvm.ptr<struct<"struct2", (i32, i32)>>
    %6 = "llvm.getelementptr"(%5, %2, %1) : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    "llvm.store"(%1, %6) : (i32, !llvm.ptr<i32>) -> ()
    %7 = "llvm.getelementptr"(%4, %arg3) : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64) -> !llvm.ptr<struct<"struct2", (i32, i32)>>
    %8 = "llvm.getelementptr"(%7, %2, %1) : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    "llvm.store"(%1, %8) : (i32, !llvm.ptr<i32>) -> ()
    %9 = "llvm.getelementptr"(%5, %2, %0) : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    %10 = "llvm.load"(%9) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%10) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i32 (ptr<struct<"struct1", (ptr<struct<"struct2", (i32, i32)>>, i32, i32, i32)>>, i1, i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"struct3", (i32, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>)>>, %arg1: i1, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @_ZTIi} : () -> !llvm.ptr<ptr<i8>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    %2 = "llvm.mlir.constant"() {value = 11 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %6 = "llvm.getelementptr"(%arg0, %5) : (!llvm.ptr<struct<"struct3", (i32, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>)>>, i64) -> !llvm.ptr<struct<"struct3", (i32, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>)>>
    "llvm.cond_br"(%arg1)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %7 = "llvm.getelementptr"(%6, %arg3, %4) : (!llvm.ptr<struct<"struct3", (i32, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>)>>, i64, i32) -> !llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>
    %8 = "llvm.getelementptr"(%7, %5, %3, %3) : (!llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>, i64, i32, i32) -> !llvm.ptr<i32>
    "llvm.store"(%3, %8) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"(%7)[^bb3] : (!llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>) -> ()
  ^bb2:  // pred: ^bb0
    %9 = "llvm.getelementptr"(%6, %arg4, %4) : (!llvm.ptr<struct<"struct3", (i32, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>)>>, i64, i32) -> !llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>
    %10 = "llvm.getelementptr"(%9, %5, %3, %4) : (!llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>, i64, i32, i32) -> !llvm.ptr<i32>
    "llvm.store"(%3, %10) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"(%9)[^bb3] : (!llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>) -> ()
  ^bb3(%11: !llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>):  // 2 preds: ^bb1, ^bb2
    %12 = "llvm.invoke"(%2)[^bb4, ^bb5] {callee = @foo1, operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i32) -> i32
  ^bb4:  // pred: ^bb3
    "llvm.return"(%3) : (i32) -> ()
  ^bb5:  // pred: ^bb3
    %13 = "llvm.landingpad"(%1) : (!llvm.ptr<i8>) -> !llvm.struct<(ptr<i8>, i32)>
    %14 = "llvm.getelementptr"(%11, %arg5, %4) : (!llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>, i64, i32) -> !llvm.ptr<struct<"struct2", (i32, i32)>>
    %15 = "llvm.getelementptr"(%14, %5, %4) : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    %16 = "llvm.load"(%15) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%16) : (i32) -> ()
  }) {linkage = 10 : i64, personality = @__gxx_personality_v0, sym_name = "test3", type = !llvm.func<i32 (ptr<struct<"struct3", (i32, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>)>>, i1, i64, i64, i64, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "__gxx_personality_v0", type = !llvm.func<i32 (...)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "foo1", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 127 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %3 = "llvm.getelementptr"(%arg1, %2) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %4 = "llvm.icmp"(%arg0, %1) {predicate = 8 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%4, %3)[^bb1, ^bb4] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, !llvm.ptr<i8>) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%3, %arg0)[^bb2] : (!llvm.ptr<i8>, i32) -> ()
  ^bb2(%5: !llvm.ptr<i8>, %6: i32):  // 2 preds: ^bb1, ^bb2
    %7 = "llvm.lshr"(%6, %0) : (i32, i32) -> i32
    %8 = "llvm.getelementptr"(%5, %2) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %9 = "llvm.icmp"(%7, %1) {predicate = 8 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%9, %8, %7, %8)[^bb2, ^bb3] {operand_segment_sizes = dense<[1, 2, 1]> : vector<3xi32>} : (i1, !llvm.ptr<i8>, i32, !llvm.ptr<i8>) -> ()
  ^bb3(%10: !llvm.ptr<i8>):  // pred: ^bb2
    "llvm.br"(%10)[^bb4] : (!llvm.ptr<i8>) -> ()
  ^bb4(%11: !llvm.ptr<i8>):  // 2 preds: ^bb0, ^bb3
    %12 = "llvm.getelementptr"(%11, %2) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"(%12) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<ptr<i8> (i32, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i16>, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i16} : () -> i16
    %1 = "llvm.mlir.constant"() {value = 2048 : i16} : () -> i16
    %2 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %3 = "llvm.mlir.constant"() {value = 64 : i8} : () -> i8
    %4 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %5 = "llvm.mlir.addressof"() {global_name = @".str.4"} : () -> !llvm.ptr<array<100 x i8>>
    %6 = "llvm.getelementptr"(%5, %4, %4) : (!llvm.ptr<array<100 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = "llvm.mlir.constant"() {value = 54 : i8} : () -> i8
    %8 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %9 = "llvm.load"(%arg1) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    %10 = "llvm.getelementptr"(%9, %8) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    %11 = "llvm.load"(%10) : (!llvm.ptr<i8>) -> i8
    %12 = "llvm.icmp"(%11, %7) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.cond_br"(%12, %10)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, !llvm.ptr<i8>) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.call"(%6) {callee = @g, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.br"(%10)[^bb2] : (!llvm.ptr<i8>) -> ()
  ^bb2(%13: !llvm.ptr<i8>):  // 3 preds: ^bb0, ^bb1, ^bb3
    %14 = "llvm.load"(%13) : (!llvm.ptr<i8>) -> i8
    %15 = "llvm.and"(%14, %3) : (i8, i8) -> i8
    %16 = "llvm.icmp"(%15, %2) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.cond_br"(%16)[^bb3, ^bb4] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %17 = "llvm.getelementptr"(%13, %8) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.br"(%17)[^bb2] : (!llvm.ptr<i8>) -> ()
  ^bb4:  // pred: ^bb2
    %18 = "llvm.getelementptr"(%13, %8) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.br"()[^bb5] : () -> ()
  ^bb5:  // 2 preds: ^bb4, ^bb5
    %19 = "llvm.load"(%18) : (!llvm.ptr<i8>) -> i8
    %20 = "llvm.zext"(%19) : (i8) -> i32
    %21 = "llvm.getelementptr"(%arg0, %20) : (!llvm.ptr<i16>, i32) -> !llvm.ptr<i16>
    %22 = "llvm.load"(%21) : (!llvm.ptr<i16>) -> i16
    %23 = "llvm.and"(%22, %1) : (i16, i16) -> i16
    %24 = "llvm.icmp"(%23, %0) {predicate = 0 : i64} : (i16, i16) -> i1
    "llvm.cond_br"(%24)[^bb6, ^bb5] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb6:  // 2 preds: ^bb5, ^bb6
    "llvm.br"()[^bb6] : () -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<void (ptr<i16>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "g", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
