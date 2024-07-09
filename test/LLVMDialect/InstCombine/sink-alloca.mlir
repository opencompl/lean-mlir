module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @cond() -> i1
  llvm.func @use_and_return(!llvm.ptr) -> !llvm.ptr
  llvm.func @foo(%arg0: i32) {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.call @cond() : () -> i1
    llvm.cond_br %1, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.alloca %arg0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.intr.stacksave : !llvm.ptr
    %4 = llvm.call @cond() : () -> i1
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %5 = llvm.call @use_and_return(%2) : (!llvm.ptr) -> !llvm.ptr
    llvm.store %0, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.intr.stackrestore %3 : !llvm.ptr
    %6 = llvm.call @use_and_return(%5) : (!llvm.ptr) -> !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }
}
