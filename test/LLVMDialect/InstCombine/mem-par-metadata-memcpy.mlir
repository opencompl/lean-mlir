#access_group = #llvm.access_group<id = distinct[0]<>>
#loop_vectorize = #llvm.loop_vectorize<disable = false>
#loop_annotation = #llvm.loop_annotation<vectorize = #loop_vectorize>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @_Z4testPcl(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    llvm.br ^bb1(%0 : i64)
  ^bb1(%2: i64):  // 2 preds: ^bb0, ^bb3
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    llvm.cond_br %3, ^bb2, ^bb4
  ^bb2:  // pred: ^bb1
    %4 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %5 = llvm.add %2, %arg1 overflow<nsw>  : i64
    %6 = llvm.getelementptr inbounds %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    "llvm.intr.memcpy"(%4, %6, %1) <{access_groups = [#access_group], isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    %7 = llvm.add %2, %1 overflow<nsw>  : i64
    llvm.br ^bb1(%7 : i64) {loop_annotation = #loop_annotation}
  ^bb4:  // pred: ^bb1
    llvm.return
  }
}
