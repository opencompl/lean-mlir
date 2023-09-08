"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "global", type = i8, value = 0 : i8} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %1 = "llvm.icmp"(%arg0, %0) {predicate = 6 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%1)[^bb1, ^bb1] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb0
    "llvm.return"(%arg0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @global} : () -> !llvm.ptr<i8>
    %1 = "llvm.ptrtoint"(%0) : (!llvm.ptr<i8>) -> i32
    %2 = "llvm.mlir.constant"() {value = 27 : i32} : () -> i32
    %3 = "llvm.icmp"(%2, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%3)[^bb1, ^bb1] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb0
    "llvm.return"(%arg0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "pat", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = true} : () -> i1
    "llvm.cond_br"(%arg0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%1)[^bb3] : (i1) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"(%0)[^bb3] : (i1) -> ()
  ^bb3(%2: i1):  // 2 preds: ^bb1, ^bb2
    "llvm.cond_br"(%2)[^bb4, ^bb5] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb4:  // pred: ^bb3
    "llvm.br"(%1)[^bb6] : (i1) -> ()
  ^bb5:  // pred: ^bb3
    "llvm.br"(%0)[^bb6] : (i1) -> ()
  ^bb6(%3: i1):  // 2 preds: ^bb4, ^bb5
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test01", type = !llvm.func<i1 (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    "llvm.cond_br"(%arg0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%1)[^bb3] : (i1) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"(%0)[^bb3] : (i1) -> ()
  ^bb3(%2: i1):  // 2 preds: ^bb1, ^bb2
    "llvm.cond_br"(%2)[^bb4, ^bb5] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb4:  // pred: ^bb3
    "llvm.br"(%1)[^bb6] : (i1) -> ()
  ^bb5:  // pred: ^bb3
    "llvm.br"(%0)[^bb6] : (i1) -> ()
  ^bb6(%3: i1):  // 2 preds: ^bb4, ^bb5
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test02", type = !llvm.func<i1 (i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
