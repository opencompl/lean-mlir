"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i64>) -> i64
    %1 = "llvm.trunc"(%0) : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "truncload_no_deref", type = !llvm.func<i32 (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i64>) -> i64
    %1 = "llvm.trunc"(%0) : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "truncload_small_deref", type = !llvm.func<i32 (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i64>) -> i64
    %1 = "llvm.trunc"(%0) : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "truncload_deref", type = !llvm.func<i32 (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %1 = "llvm.trunc"(%0) : (i32) -> i16
    "llvm.return"(%1) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "truncload_align", type = !llvm.func<i16 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i64>) -> i64
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    %1 = "llvm.trunc"(%0) : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "truncload_extra_use", type = !llvm.func<i32 (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i64>) -> i64
    %1 = "llvm.trunc"(%0) : (i64) -> i8
    "llvm.return"(%1) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "truncload_type", type = !llvm.func<i8 (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i64>) -> i64
    %1 = "llvm.trunc"(%0) : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "truncload_volatile", type = !llvm.func<i32 (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64, 1>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i64, 1>) -> i64
    %1 = "llvm.trunc"(%0) : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "truncload_address_space", type = !llvm.func<i32 (ptr<i64, 1>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
