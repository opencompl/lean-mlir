module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<2>, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<3>, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<1>, dense<16> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @func(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.br ^bb3(%1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr
    llvm.br ^bb3(%3 : !llvm.ptr)
  ^bb3(%4: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i64
    llvm.return %5 : i64
  }
  llvm.func @func_single_operand(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.br ^bb2(%1 : !llvm.ptr)
  ^bb2(%2: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    llvm.return %3 : i64
  }
  llvm.func @func_pointer_different_types(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.br ^bb2(%1 : !llvm.ptr)
  ^bb2(%2: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    llvm.return %3 : i64
  }
  llvm.func @func_integer_type_too_small(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    llvm.br ^bb2(%1 : !llvm.ptr)
  ^bb2(%2: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    llvm.return %3 : i64
  }
  llvm.func @func_phi_not_use_in_ptr2int(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> !llvm.ptr {
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    llvm.br ^bb2(%1 : !llvm.ptr)
  ^bb2(%2: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @func_ptr_different_addrspace(%arg0: !llvm.ptr<2>, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr<2> to i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.br ^bb2(%1 : !llvm.ptr)
  ^bb2(%2: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    llvm.return %3 : i64
  }
}
