module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @dummy(!llvm.ptr, i32)
  llvm.func @test(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %2, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "eq" %arg1, %1 : i32
    llvm.cond_br %3, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.call @dummy(%arg0, %arg1) : (!llvm.ptr, i32) -> ()
    llvm.return
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.unreachable
  }
  llvm.func @bar(!llvm.ptr, !llvm.ptr {llvm.nonnull, llvm.noundef})
  llvm.func @bar_without_noundef(!llvm.ptr, !llvm.ptr {llvm.nonnull})
  llvm.func @baz(!llvm.ptr, !llvm.ptr)
  llvm.func @deduce_nonnull_from_another_call(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    llvm.call @bar(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @baz(%arg1, %arg1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @deduce_nonnull_from_another_call2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    llvm.call @bar_without_noundef(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @baz(%arg1, %arg1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
}
