module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @readnone_but_may_throw() attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>}
  llvm.func @f_0(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.call @readnone_but_may_throw() : () -> ()
    llvm.store %1, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @f_1(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.call @readnone_but_may_throw() : () -> ()
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }
}
