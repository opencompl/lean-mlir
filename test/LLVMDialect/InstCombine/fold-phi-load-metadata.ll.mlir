"module"() ( {
  "llvm.mlir.global"() ( {
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<i32>
    "llvm.return"(%0) : (!llvm.ptr<i32>) -> ()
  }) {linkage = 5 : i64, sym_name = "g1", type = !llvm.ptr<i32>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"struct.S1", (i32, f32)>>, %arg1: !llvm.ptr<struct<"struct.S2", (f32, i32)>>, %arg2: i32, %arg3: !llvm.ptr<ptr<i32>>, %arg4: !llvm.ptr<ptr<i32>>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @g1} : () -> !llvm.ptr<ptr<i32>>
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.icmp"(%arg2, %3) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%4)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %5 = "llvm.getelementptr"(%arg1, %2, %1) : (!llvm.ptr<struct<"struct.S2", (f32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    %6 = "llvm.load"(%5) : (!llvm.ptr<i32>) -> i32
    %7 = "llvm.load"(%arg3) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    "llvm.br"(%6, %7)[^bb3] : (i32, !llvm.ptr<i32>) -> ()
  ^bb2:  // pred: ^bb0
    %8 = "llvm.getelementptr"(%arg0, %2, %3) : (!llvm.ptr<struct<"struct.S1", (i32, f32)>>, i64, i32) -> !llvm.ptr<i32>
    %9 = "llvm.load"(%8) : (!llvm.ptr<i32>) -> i32
    %10 = "llvm.load"(%arg4) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    "llvm.br"(%9, %10)[^bb3] : (i32, !llvm.ptr<i32>) -> ()
  ^bb3(%11: i32, %12: !llvm.ptr<i32>):  // 2 preds: ^bb1, ^bb2
    "llvm.store"(%12, %0) : (!llvm.ptr<i32>, !llvm.ptr<ptr<i32>>) -> ()
    "llvm.return"(%11) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "phi_load_metadata", type = !llvm.func<i32 (ptr<struct<"struct.S1", (i32, f32)>>, ptr<struct<"struct.S2", (f32, i32)>>, i32, ptr<ptr<i32>>, ptr<ptr<i32>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
