"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.ptrtoint"(%arg0) : (!llvm.ptr<i32>) -> i1
    "llvm.return"(%0) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i1 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i128):  // no predecessors
    %0 = "llvm.inttoptr"(%arg0) : (i128) -> !llvm.ptr<i32>
    "llvm.return"(%0) : (!llvm.ptr<i32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<ptr<i32> (i128)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.inttoptr"(%arg0) : (i32) -> !llvm.ptr<i8>
    %1 = "llvm.ptrtoint"(%0) : (!llvm.ptr<i8>) -> i64
    "llvm.return"(%1) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "f0", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<4 x ptr<i8>>):  // no predecessors
    %0 = "llvm.ptrtoint"(%arg0) : (!llvm.vec<4 x ptr<i8>>) -> vector<4xi32>
    "llvm.return"(%0) : (vector<4xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<vector<4xi32> (vec<4 x ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<? x 4 x ptr<i8>>):  // no predecessors
    %0 = "llvm.ptrtoint"(%arg0) : (!llvm.vec<? x 4 x ptr<i8>>) -> !llvm.vec<? x 4 x i32>
    "llvm.return"(%0) : (!llvm.vec<? x 4 x i32>) -> ()
  }) {linkage = 10 : i64, sym_name = "testvscale4", type = !llvm.func<vec<? x 4 x i32> (vec<? x 4 x ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<4 x ptr<i8>>):  // no predecessors
    %0 = "llvm.ptrtoint"(%arg0) : (!llvm.vec<4 x ptr<i8>>) -> vector<4xi128>
    "llvm.return"(%0) : (vector<4xi128>) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<vector<4xi128> (vec<4 x ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi32>):  // no predecessors
    %0 = "llvm.inttoptr"(%arg0) : (vector<4xi32>) -> !llvm.vec<4 x ptr<i8>>
    "llvm.return"(%0) : (!llvm.vec<4 x ptr<i8>>) -> ()
  }) {linkage = 10 : i64, sym_name = "test6", type = !llvm.func<vec<4 x ptr<i8>> (vector<4xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi128>):  // no predecessors
    %0 = "llvm.inttoptr"(%arg0) : (vector<4xi128>) -> !llvm.vec<4 x ptr<i8>>
    "llvm.return"(%0) : (!llvm.vec<4 x ptr<i8>>) -> ()
  }) {linkage = 10 : i64, sym_name = "test7", type = !llvm.func<vec<4 x ptr<i8>> (vector<4xi128>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
