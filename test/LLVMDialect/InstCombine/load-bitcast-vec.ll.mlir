"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<4xf32>>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<vector<4xf32>>) -> !llvm.ptr<f32>
    %1 = "llvm.load"(%0) : (!llvm.ptr<f32>) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "matching_scalar", type = !llvm.func<f32 (ptr<vector<4xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<4xf32>>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<vector<4xf32>>) -> !llvm.ptr<i32>
    %1 = "llvm.load"(%0) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "nonmatching_scalar", type = !llvm.func<i32 (ptr<vector<4xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<4xf32>>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<vector<4xf32>>) -> !llvm.ptr<i64>
    %1 = "llvm.load"(%0) : (!llvm.ptr<i64>) -> i64
    "llvm.return"(%1) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "larger_scalar", type = !llvm.func<i64 (ptr<vector<4xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<4xf32>>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<vector<4xf32>>) -> !llvm.ptr<i8>
    %1 = "llvm.load"(%0) : (!llvm.ptr<i8>) -> i8
    "llvm.return"(%1) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "smaller_scalar", type = !llvm.func<i8 (ptr<vector<4xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<4xf32>>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<vector<4xf32>>) -> !llvm.ptr<i8>
    %1 = "llvm.load"(%0) : (!llvm.ptr<i8>) -> i8
    "llvm.return"(%1) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "smaller_scalar_less_aligned", type = !llvm.func<i8 (ptr<vector<4xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<4xf32>>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<vector<4xf32>>) -> !llvm.ptr<f32>
    %1 = "llvm.load"(%0) : (!llvm.ptr<f32>) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "matching_scalar_small_deref", type = !llvm.func<f32 (ptr<vector<4xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<4xf32>>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<vector<4xf32>>) -> !llvm.ptr<f32>
    %1 = "llvm.load"(%0) : (!llvm.ptr<f32>) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "matching_scalar_smallest_deref", type = !llvm.func<f32 (ptr<vector<4xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<4xf32>>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<vector<4xf32>>) -> !llvm.ptr<f32>
    %1 = "llvm.load"(%0) : (!llvm.ptr<f32>) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "matching_scalar_smallest_deref_or_null", type = !llvm.func<f32 (ptr<vector<4xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<4xf32>, 4>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<vector<4xf32>, 4>) -> !llvm.ptr<f32, 4>
    %1 = "llvm.load"(%0) : (!llvm.ptr<f32, 4>) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "matching_scalar_smallest_deref_addrspace", type = !llvm.func<f32 (ptr<vector<4xf32>, 4>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<4xf32>, 4>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<vector<4xf32>, 4>) -> !llvm.ptr<f32, 4>
    %1 = "llvm.load"(%0) : (!llvm.ptr<f32, 4>) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "matching_scalar_smallest_deref_or_null_addrspace", type = !llvm.func<f32 (ptr<vector<4xf32>, 4>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<4xf32>>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<vector<4xf32>>) -> !llvm.ptr<f32>
    %1 = "llvm.load"(%0) : (!llvm.ptr<f32>) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "matching_scalar_volatile", type = !llvm.func<f32 (ptr<vector<4xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<f64>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<f64>) -> !llvm.ptr<f32>
    %1 = "llvm.load"(%0) : (!llvm.ptr<f32>) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "nonvector", type = !llvm.func<f32 (ptr<f64>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
