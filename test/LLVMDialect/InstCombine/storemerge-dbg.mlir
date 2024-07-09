module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @escape(i32) -> i32
  llvm.func @foo(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.call @escape(%3) : (i32) -> i32
    llvm.return %4 : i32
  }
}
