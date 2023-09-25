"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -16777216 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<f32>
    "llvm.store"(%arg0, %2) : (f32, !llvm.ptr<f32>) -> ()
    %3 = "llvm.load"(%2) : (!llvm.ptr<f32>) -> f32
    %4 = "llvm.bitcast"(%3) : (f32) -> i32
    %5 = "llvm.shl"(%4, %1) : (i32, i32) -> i32
    %6 = "llvm.icmp"(%5, %0) {predicate = 8 : i64} : (i32, i32) -> i1
    %7 = "llvm.zext"(%6) : (i1) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "__isnan", type = !llvm.func<i32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4608 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %2 = "llvm.shl"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "icmp_shl7", type = !llvm.func<i1 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
