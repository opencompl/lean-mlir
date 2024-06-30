"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "__darwin_gcc3_preregister_frame_info", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<ptr<i8>>, %arg2: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @__darwin_gcc3_preregister_frame_info} : () -> !llvm.ptr<func<void ()>>
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr<func<void ()>>) -> !llvm.ptr<i32>
    %4 = "llvm.load"(%3) : (!llvm.ptr<i32>) -> i32
    %5 = "llvm.icmp"(%4, %1) {predicate = 1 : i64} : (i32, i32) -> i1
    %6 = "llvm.zext"(%5) : (i1) -> i8
    %7 = "llvm.icmp"(%6, %0) {predicate = 1 : i64} : (i8, i8) -> i1
    "llvm.cond_br"(%7)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "_start", type = !llvm.func<void (i32, ptr<ptr<i8>>, ptr<ptr<i8>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
