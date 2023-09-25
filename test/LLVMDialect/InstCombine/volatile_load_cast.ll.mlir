"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %1 = "llvm.bitcast"(%0) : (i32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "float_load", type = !llvm.func<f32 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<f32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<f32>) -> f32
    %1 = "llvm.bitcast"(%0) : (f32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "i32_load", type = !llvm.func<i32 (ptr<f32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i64>) -> i64
    %1 = "llvm.bitcast"(%0) : (i64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "double_load", type = !llvm.func<f64 (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<f64>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<f64>) -> f64
    %1 = "llvm.bitcast"(%0) : (f64) -> i64
    "llvm.return"(%1) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "i64_load", type = !llvm.func<i64 (ptr<f64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i64>) -> i64
    %1 = "llvm.inttoptr"(%0) : (i64) -> !llvm.ptr<i8>
    "llvm.return"(%1) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "ptr_load", type = !llvm.func<ptr<i8> (ptr<i64>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
