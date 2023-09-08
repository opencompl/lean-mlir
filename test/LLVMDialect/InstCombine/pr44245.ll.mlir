"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> !llvm.ptr<func<void ()>>
    %1 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %2 = "llvm.inttoptr"(%1) : (i64) -> !llvm.ptr<ptr<i64>>
    %3 = "llvm.mlir.undef"() : () -> !llvm.ptr<ptr<i8>>
    %4 = "llvm.mlir.undef"() : () -> !llvm.ptr<i8>
    "llvm.cond_br"(%arg0, %4)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, !llvm.ptr<i8>) -> ()
  ^bb1(%5: !llvm.ptr<i8>):  // 2 preds: ^bb0, ^bb4
    "llvm.store"(%5, %3) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    "llvm.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    "llvm.cond_br"(%arg0)[^bb3, ^bb5] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %6 = "llvm.load"(%2) : (!llvm.ptr<ptr<i64>>) -> !llvm.ptr<i64>
    "llvm.br"(%6)[^bb4] : (!llvm.ptr<i64>) -> ()
  ^bb4(%7: !llvm.ptr<i64>):  // 8 preds: ^bb3, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb19
    %8 = "llvm.bitcast"(%7) : (!llvm.ptr<i64>) -> !llvm.ptr<i8>
    "llvm.br"(%8)[^bb1] : (!llvm.ptr<i8>) -> ()
  ^bb5:  // pred: ^bb2
    "llvm.cond_br"(%arg0)[^bb6, ^bb7] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb6:  // pred: ^bb5
    %9 = "llvm.load"(%2) : (!llvm.ptr<ptr<i64>>) -> !llvm.ptr<i64>
    "llvm.br"(%9)[^bb4] : (!llvm.ptr<i64>) -> ()
  ^bb7:  // pred: ^bb5
    "llvm.cond_br"(%arg0)[^bb8, ^bb9] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb8:  // pred: ^bb7
    %10 = "llvm.load"(%2) : (!llvm.ptr<ptr<i64>>) -> !llvm.ptr<i64>
    "llvm.br"(%10)[^bb4] : (!llvm.ptr<i64>) -> ()
  ^bb9:  // pred: ^bb7
    "llvm.cond_br"(%arg0)[^bb10, ^bb11] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb10:  // pred: ^bb9
    %11 = "llvm.load"(%2) : (!llvm.ptr<ptr<i64>>) -> !llvm.ptr<i64>
    "llvm.br"(%11)[^bb4] : (!llvm.ptr<i64>) -> ()
  ^bb11:  // pred: ^bb9
    "llvm.cond_br"(%arg0)[^bb12, ^bb13] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb12:  // pred: ^bb11
    %12 = "llvm.load"(%2) : (!llvm.ptr<ptr<i64>>) -> !llvm.ptr<i64>
    "llvm.br"(%12)[^bb4] : (!llvm.ptr<i64>) -> ()
  ^bb13:  // pred: ^bb11
    "llvm.cond_br"(%arg0)[^bb14, ^bb15] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb14:  // pred: ^bb13
    %13 = "llvm.load"(%2) : (!llvm.ptr<ptr<i64>>) -> !llvm.ptr<i64>
    "llvm.br"(%13)[^bb4] : (!llvm.ptr<i64>) -> ()
  ^bb15:  // pred: ^bb13
    "llvm.cond_br"(%arg0)[^bb16, ^bb17] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb16:  // pred: ^bb15
    %14 = "llvm.load"(%2) : (!llvm.ptr<ptr<i64>>) -> !llvm.ptr<i64>
    "llvm.br"(%14)[^bb4] : (!llvm.ptr<i64>) -> ()
  ^bb17:  // pred: ^bb15
    "llvm.cond_br"(%arg0)[^bb18, ^bb20] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb18:  // pred: ^bb17
    %15 = "llvm.load"(%2) : (!llvm.ptr<ptr<i64>>) -> !llvm.ptr<i64>
    "llvm.br"(%15)[^bb19] : (!llvm.ptr<i64>) -> ()
  ^bb19(%16: !llvm.ptr<i64>):  // 2 preds: ^bb18, ^bb20
    "llvm.br"(%16)[^bb4] : (!llvm.ptr<i64>) -> ()
  ^bb20:  // pred: ^bb17
    %17 = "llvm.load"(%2) : (!llvm.ptr<ptr<i64>>) -> !llvm.ptr<i64>
    "llvm.call"(%0) : (!llvm.ptr<func<void ()>>) -> ()
    "llvm.br"(%17)[^bb19] : (!llvm.ptr<i64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<void (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> !llvm.ptr<ptr<struct<"type_2", ()>>>
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.undef"() : () -> !llvm.ptr<struct<"type_2", ()>>
    "llvm.br"(%2)[^bb1] : (!llvm.ptr<struct<"type_2", ()>>) -> ()
  ^bb1(%3: !llvm.ptr<struct<"type_2", ()>>):  // 2 preds: ^bb0, ^bb5
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<struct<"type_2", ()>>) -> !llvm.ptr<struct<"type_3", ()>>
    %5 = "llvm.getelementptr"(%4, %1) : (!llvm.ptr<struct<"type_3", ()>>, i32) -> !llvm.ptr<struct<"type_3", ()>>
    %6 = "llvm.bitcast"(%5) : (!llvm.ptr<struct<"type_3", ()>>) -> !llvm.ptr<struct<"type_1", ()>>
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "llvm.cond_br"(%arg0)[^bb3, ^bb4] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %7 = "llvm.load"(%0) : (!llvm.ptr<ptr<struct<"type_2", ()>>>) -> !llvm.ptr<struct<"type_2", ()>>
    "llvm.br"(%7)[^bb5] : (!llvm.ptr<struct<"type_2", ()>>) -> ()
  ^bb4:  // pred: ^bb2
    %8 = "llvm.load"(%0) : (!llvm.ptr<ptr<struct<"type_2", ()>>>) -> !llvm.ptr<struct<"type_2", ()>>
    "llvm.br"(%8)[^bb5] : (!llvm.ptr<struct<"type_2", ()>>) -> ()
  ^bb5(%9: !llvm.ptr<struct<"type_2", ()>>):  // 2 preds: ^bb3, ^bb4
    "llvm.br"(%9)[^bb1] : (!llvm.ptr<struct<"type_2", ()>>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_2", type = !llvm.func<void (i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
