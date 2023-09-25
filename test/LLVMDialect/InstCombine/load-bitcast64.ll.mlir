"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<i8>) -> !llvm.ptr<i64>
    %1 = "llvm.load"(%0) : (!llvm.ptr<i64>) -> i64
    %2 = "llvm.inttoptr"(%1) : (i64) -> !llvm.ptr<i64>
    "llvm.return"(%2) : (!llvm.ptr<i64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<ptr<i64> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<i8>) -> !llvm.ptr<i32>
    %1 = "llvm.load"(%0) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.inttoptr"(%1) : (i32) -> !llvm.ptr<i32>
    "llvm.return"(%2) : (!llvm.ptr<i32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<ptr<i32> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<i8>) -> !llvm.ptr<i32>
    %1 = "llvm.load"(%0) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.inttoptr"(%1) : (i32) -> !llvm.ptr<i64>
    "llvm.return"(%2) : (!llvm.ptr<i64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<ptr<i64> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<i8>) -> !llvm.ptr<ptr<i64>>
    %1 = "llvm.load"(%0) : (!llvm.ptr<ptr<i64>>) -> !llvm.ptr<i64>
    %2 = "llvm.ptrtoint"(%1) : (!llvm.ptr<i64>) -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<i64 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<i8>) -> !llvm.ptr<ptr<i32>>
    %1 = "llvm.load"(%0) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    %2 = "llvm.ptrtoint"(%1) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<i8>) -> !llvm.ptr<ptr<i32>>
    %1 = "llvm.load"(%0) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    %2 = "llvm.ptrtoint"(%1) : (!llvm.ptr<i32>) -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test6", type = !llvm.func<i64 (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
