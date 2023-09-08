"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i32>>, %arg1: !llvm.ptr<ptr<i32>>, %arg2: i1):  // no predecessors
    "llvm.cond_br"(%arg2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %0 = "llvm.ptrtoint"(%arg0) : (!llvm.ptr<ptr<i32>>) -> i64
    %1 = "llvm.inttoptr"(%0) : (i64) -> !llvm.ptr<i32>
    "llvm.br"(%1)[^bb3] : (!llvm.ptr<i32>) -> ()
  ^bb2:  // pred: ^bb0
    %2 = "llvm.ptrtoint"(%arg1) : (!llvm.ptr<ptr<i32>>) -> i64
    %3 = "llvm.inttoptr"(%2) : (i64) -> !llvm.ptr<i32>
    "llvm.br"(%3)[^bb3] : (!llvm.ptr<i32>) -> ()
  ^bb3(%4: !llvm.ptr<i32>):  // 2 preds: ^bb1, ^bb2
    %5 = "llvm.ptrtoint"(%4) : (!llvm.ptr<i32>) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "func", type = !llvm.func<i64 (ptr<ptr<i32>>, ptr<ptr<i32>>, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i32>>, %arg1: !llvm.ptr<ptr<i32>>, %arg2: i1):  // no predecessors
    %0 = "llvm.bitcast"(%arg1) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    "llvm.cond_br"(%arg2, %0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, !llvm.ptr<i32>) -> ()
  ^bb1:  // pred: ^bb0
    %1 = "llvm.ptrtoint"(%arg0) : (!llvm.ptr<ptr<i32>>) -> i64
    %2 = "llvm.inttoptr"(%1) : (i64) -> !llvm.ptr<i32>
    "llvm.br"(%2)[^bb2] : (!llvm.ptr<i32>) -> ()
  ^bb2(%3: !llvm.ptr<i32>):  // 2 preds: ^bb0, ^bb1
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr<i32>) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "func_single_operand", type = !llvm.func<i64 (ptr<ptr<i32>>, ptr<ptr<i32>>, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i16>>, %arg1: !llvm.ptr<ptr<i32>>, %arg2: i1):  // no predecessors
    %0 = "llvm.bitcast"(%arg1) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    "llvm.cond_br"(%arg2, %0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, !llvm.ptr<i32>) -> ()
  ^bb1:  // pred: ^bb0
    %1 = "llvm.ptrtoint"(%arg0) : (!llvm.ptr<ptr<i16>>) -> i64
    %2 = "llvm.inttoptr"(%1) : (i64) -> !llvm.ptr<i32>
    "llvm.br"(%2)[^bb2] : (!llvm.ptr<i32>) -> ()
  ^bb2(%3: !llvm.ptr<i32>):  // 2 preds: ^bb0, ^bb1
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr<i32>) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "func_pointer_different_types", type = !llvm.func<i64 (ptr<ptr<i16>>, ptr<ptr<i32>>, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i32>>, %arg1: !llvm.ptr<ptr<i32>>, %arg2: i1):  // no predecessors
    %0 = "llvm.bitcast"(%arg1) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    "llvm.cond_br"(%arg2, %0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, !llvm.ptr<i32>) -> ()
  ^bb1:  // pred: ^bb0
    %1 = "llvm.ptrtoint"(%arg0) : (!llvm.ptr<ptr<i32>>) -> i32
    %2 = "llvm.inttoptr"(%1) : (i32) -> !llvm.ptr<i32>
    "llvm.br"(%2)[^bb2] : (!llvm.ptr<i32>) -> ()
  ^bb2(%3: !llvm.ptr<i32>):  // 2 preds: ^bb0, ^bb1
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr<i32>) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "func_integer_type_too_small", type = !llvm.func<i64 (ptr<ptr<i32>>, ptr<ptr<i32>>, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i32>>, %arg1: !llvm.ptr<ptr<i32>>, %arg2: i1):  // no predecessors
    %0 = "llvm.bitcast"(%arg1) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    "llvm.cond_br"(%arg2, %0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, !llvm.ptr<i32>) -> ()
  ^bb1:  // pred: ^bb0
    %1 = "llvm.ptrtoint"(%arg0) : (!llvm.ptr<ptr<i32>>) -> i32
    %2 = "llvm.inttoptr"(%1) : (i32) -> !llvm.ptr<i32>
    "llvm.br"(%2)[^bb2] : (!llvm.ptr<i32>) -> ()
  ^bb2(%3: !llvm.ptr<i32>):  // 2 preds: ^bb0, ^bb1
    "llvm.return"(%3) : (!llvm.ptr<i32>) -> ()
  }) {linkage = 10 : i64, sym_name = "func_phi_not_use_in_ptr2int", type = !llvm.func<ptr<i32> (ptr<ptr<i32>>, ptr<ptr<i32>>, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i16, 2>, %arg1: !llvm.ptr<ptr<i32>>, %arg2: i1):  // no predecessors
    %0 = "llvm.bitcast"(%arg1) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    "llvm.cond_br"(%arg2, %0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, !llvm.ptr<i32>) -> ()
  ^bb1:  // pred: ^bb0
    %1 = "llvm.ptrtoint"(%arg0) : (!llvm.ptr<i16, 2>) -> i64
    %2 = "llvm.inttoptr"(%1) : (i64) -> !llvm.ptr<i32>
    "llvm.br"(%2)[^bb2] : (!llvm.ptr<i32>) -> ()
  ^bb2(%3: !llvm.ptr<i32>):  // 2 preds: ^bb0, ^bb1
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr<i32>) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "func_ptr_different_addrspace", type = !llvm.func<i64 (ptr<i16, 2>, ptr<ptr<i32>>, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
