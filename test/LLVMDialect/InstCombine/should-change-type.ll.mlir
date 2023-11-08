"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i64
    %1 = "llvm.zext"(%arg1) : (i8) -> i64
    %2 = "llvm.add"(%0, %1) : (i64, i64) -> i64
    %3 = "llvm.trunc"(%2) : (i64) -> i8
    "llvm.return"(%3) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i16):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i16) -> i64
    %1 = "llvm.zext"(%arg1) : (i16) -> i64
    %2 = "llvm.add"(%0, %1) : (i64, i64) -> i64
    %3 = "llvm.trunc"(%2) : (i64) -> i16
    "llvm.return"(%3) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i16 (i16, i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i32) -> i64
    %1 = "llvm.zext"(%arg1) : (i32) -> i64
    %2 = "llvm.add"(%0, %1) : (i64, i64) -> i64
    %3 = "llvm.trunc"(%2) : (i64) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i9, %arg1: i9):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i9) -> i64
    %1 = "llvm.zext"(%arg1) : (i9) -> i64
    %2 = "llvm.add"(%0, %1) : (i64, i64) -> i64
    %3 = "llvm.trunc"(%2) : (i64) -> i9
    "llvm.return"(%3) : (i9) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<i9 (i9, i9)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
