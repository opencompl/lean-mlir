module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @gp() {addr_space = 0 : i32, alignment = 8 : i64} : !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @malloc(i64) -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = [["allockind", "9"], ["allocsize", "4294967295"]]}
  llvm.func @compare_global_trivialeq() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @compare_global_trivialne() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.icmp "ne" %3, %4 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @f()
  llvm.func @compare_and_call_with_deopt() -> i1 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.icmp "eq" %4, %3 : !llvm.ptr
    llvm.call @f() : () -> ()
    llvm.return %5 : i1
  }
  llvm.func @compare_ne_and_call_with_deopt() -> i1 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.call @f() : () -> ()
    llvm.return %5 : i1
  }
  llvm.func @compare_ne_global_maybe_null() -> i1 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.call @f() : () -> ()
    llvm.return %5 : i1
  }
  llvm.func @escape(!llvm.ptr)
  llvm.func @compare_and_call_after() -> i1 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %5 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %6 = llvm.icmp "eq" %4, %5 : !llvm.ptr
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @escape(%4) : (!llvm.ptr) -> ()
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %6 : i1
  }
  llvm.func @compare_distinct_mallocs() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %3 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @compare_samepointer_under_bitcast() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %1 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @compare_samepointer_escaped() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %1 : !llvm.ptr
    llvm.call @f() : () -> ()
    llvm.return %2 : i1
  }
  llvm.func @compare_ret_escape(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %5 = llvm.icmp "eq" %4, %arg0 : !llvm.ptr
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // 2 preds: ^bb0, ^bb2
    llvm.return %3 : !llvm.ptr
  ^bb2:  // pred: ^bb0
    %6 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %7 = llvm.icmp "eq" %3, %6 : !llvm.ptr
    llvm.cond_br %7, ^bb1, ^bb3
  ^bb3:  // pred: ^bb2
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @compare_distinct_pointer_escape() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @f() : () -> ()
    %3 = llvm.icmp "ne" %1, %2 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @hidden_inttoptr() -> !llvm.ptr
  llvm.func @hidden_offset(!llvm.ptr) -> !llvm.ptr
  llvm.func @ptrtoint_single_cmp() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %3 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %4 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @offset_single_cmp() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %5 = llvm.icmp "eq" %2, %4 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @witness(i1, i1)
  llvm.func @neg_consistent_fold1() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %3 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %4 = llvm.call @hidden_inttoptr() : () -> !llvm.ptr
    %5 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    %6 = llvm.icmp "eq" %2, %4 : !llvm.ptr
    llvm.call @witness(%5, %6) : (i1, i1) -> ()
    llvm.return
  }
  llvm.func @neg_consistent_fold2() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %5 = llvm.call @hidden_offset(%3) : (!llvm.ptr) -> !llvm.ptr
    %6 = llvm.icmp "eq" %2, %4 : !llvm.ptr
    %7 = llvm.icmp "eq" %2, %5 : !llvm.ptr
    llvm.call @witness(%6, %7) : (i1, i1) -> ()
    llvm.return
  }
  llvm.func @neg_consistent_fold3() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.call @hidden_inttoptr() : () -> !llvm.ptr
    %6 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    %7 = llvm.icmp "eq" %3, %5 : !llvm.ptr
    llvm.call @witness(%6, %7) : (i1, i1) -> ()
    llvm.return
  }
  llvm.func @neg_consistent_fold4() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    %6 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    llvm.call @witness(%5, %6) : (i1, i1) -> ()
    llvm.return
  }
  llvm.func @unknown(!llvm.ptr)
  llvm.func @consistent_nocapture_inttoptr() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @unknown(%2) : (!llvm.ptr) -> ()
    %3 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %4 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @consistent_nocapture_offset() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @unknown(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %5 = llvm.icmp "eq" %2, %4 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @consistent_nocapture_through_global() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @unknown(%3) : (!llvm.ptr) -> ()
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @two_nonnull_mallocs() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %3 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @two_nonnull_mallocs2() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @unknown(%2) : (!llvm.ptr) -> ()
    %3 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @two_nonnull_mallocs_hidden() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %5 = llvm.getelementptr %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %6 = llvm.getelementptr %4[%2] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %7 = llvm.icmp "eq" %5, %6 : !llvm.ptr
    llvm.return %7 : i1
  }
}
