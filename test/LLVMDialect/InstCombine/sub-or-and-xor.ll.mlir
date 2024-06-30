"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.and"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.sub"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_to_xor", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.and"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.sub"(%0, %1) : (i32, i32) -> i32
    "llvm.call"(%2) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_to_xor_extra_use_sub", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.and"(%arg0, %arg1) : (i32, i32) -> i32
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %2 = "llvm.sub"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_to_xor_extra_use_and", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %1 = "llvm.and"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.sub"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_to_xor_extra_use_or", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.or"(%arg1, %arg0) : (i32, i32) -> i32
    %1 = "llvm.and"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.sub"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_to_xor_or_commuted", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.and"(%arg1, %arg0) : (i32, i32) -> i32
    %2 = "llvm.sub"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_to_xor_and_commuted", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.or"(%arg0, %arg1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %1 = "llvm.and"(%arg1, %arg0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.sub"(%0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_to_xor_vec", type = !llvm.func<vector<2xi32> (vector<2xi32>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.or"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.and"(%arg0, %arg2) : (i32, i32) -> i32
    %2 = "llvm.sub"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_to_xor_wrong_arg", type = !llvm.func<i32 (i32, i32, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
