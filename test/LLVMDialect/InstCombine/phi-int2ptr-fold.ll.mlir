module  {
  llvm.func @func(%arg0: !llvm.ptr<ptr<i32>>, %arg1: !llvm.ptr<ptr<i32>>, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr<ptr<i32>> to i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr<i32>
    llvm.br ^bb3(%1 : !llvm.ptr<i32>)
  ^bb2:  // pred: ^bb0
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr<ptr<i32>> to i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr<i32>
    llvm.br ^bb3(%3 : !llvm.ptr<i32>)
  ^bb3(%4: !llvm.ptr<i32>):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.ptrtoint %4 : !llvm.ptr<i32> to i64
    llvm.return %5 : i64
  }
  llvm.func @func_single_operand(%arg0: !llvm.ptr<ptr<i32>>, %arg1: !llvm.ptr<ptr<i32>>, %arg2: i1) -> i64 {
    %0 = llvm.bitcast %arg1 : !llvm.ptr<ptr<i32>> to !llvm.ptr<i32>
    llvm.cond_br %arg2, ^bb1, ^bb2(%0 : !llvm.ptr<i32>)
  ^bb1:  // pred: ^bb0
    %1 = llvm.ptrtoint %arg0 : !llvm.ptr<ptr<i32>> to i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr<i32>
    llvm.br ^bb2(%2 : !llvm.ptr<i32>)
  ^bb2(%3: !llvm.ptr<i32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.ptrtoint %3 : !llvm.ptr<i32> to i64
    llvm.return %4 : i64
  }
  llvm.func @func_pointer_different_types(%arg0: !llvm.ptr<ptr<i16>>, %arg1: !llvm.ptr<ptr<i32>>, %arg2: i1) -> i64 {
    %0 = llvm.bitcast %arg1 : !llvm.ptr<ptr<i32>> to !llvm.ptr<i32>
    llvm.cond_br %arg2, ^bb1, ^bb2(%0 : !llvm.ptr<i32>)
  ^bb1:  // pred: ^bb0
    %1 = llvm.ptrtoint %arg0 : !llvm.ptr<ptr<i16>> to i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr<i32>
    llvm.br ^bb2(%2 : !llvm.ptr<i32>)
  ^bb2(%3: !llvm.ptr<i32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.ptrtoint %3 : !llvm.ptr<i32> to i64
    llvm.return %4 : i64
  }
  llvm.func @func_integer_type_too_small(%arg0: !llvm.ptr<ptr<i32>>, %arg1: !llvm.ptr<ptr<i32>>, %arg2: i1) -> i64 {
    %0 = llvm.bitcast %arg1 : !llvm.ptr<ptr<i32>> to !llvm.ptr<i32>
    llvm.cond_br %arg2, ^bb1, ^bb2(%0 : !llvm.ptr<i32>)
  ^bb1:  // pred: ^bb0
    %1 = llvm.ptrtoint %arg0 : !llvm.ptr<ptr<i32>> to i32
    %2 = llvm.inttoptr %1 : i32 to !llvm.ptr<i32>
    llvm.br ^bb2(%2 : !llvm.ptr<i32>)
  ^bb2(%3: !llvm.ptr<i32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.ptrtoint %3 : !llvm.ptr<i32> to i64
    llvm.return %4 : i64
  }
  llvm.func @func_phi_not_use_in_ptr2int(%arg0: !llvm.ptr<ptr<i32>>, %arg1: !llvm.ptr<ptr<i32>>, %arg2: i1) -> !llvm.ptr<i32> {
    %0 = llvm.bitcast %arg1 : !llvm.ptr<ptr<i32>> to !llvm.ptr<i32>
    llvm.cond_br %arg2, ^bb1, ^bb2(%0 : !llvm.ptr<i32>)
  ^bb1:  // pred: ^bb0
    %1 = llvm.ptrtoint %arg0 : !llvm.ptr<ptr<i32>> to i32
    %2 = llvm.inttoptr %1 : i32 to !llvm.ptr<i32>
    llvm.br ^bb2(%2 : !llvm.ptr<i32>)
  ^bb2(%3: !llvm.ptr<i32>):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : !llvm.ptr<i32>
  }
  llvm.func @func_ptr_different_addrspace(%arg0: !llvm.ptr<i16, 2>, %arg1: !llvm.ptr<ptr<i32>>, %arg2: i1) -> i64 {
    %0 = llvm.bitcast %arg1 : !llvm.ptr<ptr<i32>> to !llvm.ptr<i32>
    llvm.cond_br %arg2, ^bb1, ^bb2(%0 : !llvm.ptr<i32>)
  ^bb1:  // pred: ^bb0
    %1 = llvm.ptrtoint %arg0 : !llvm.ptr<i16, 2> to i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr<i32>
    llvm.br ^bb2(%2 : !llvm.ptr<i32>)
  ^bb2(%3: !llvm.ptr<i32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.ptrtoint %3 : !llvm.ptr<i32> to i64
    llvm.return %4 : i64
  }
}
