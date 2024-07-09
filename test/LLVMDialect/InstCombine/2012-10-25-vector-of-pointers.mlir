module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @widget(%arg0: !llvm.ptr {llvm.nocapture}, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<3> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb10
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb10
  ^bb3:  // pred: ^bb1
    %4 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.vec<2 x ptr>
    %5 = llvm.ptrtoint %4 : !llvm.vec<2 x ptr> to vector<2xi64>
    %6 = llvm.sub %1, %5  : vector<2xi64>
    %7 = llvm.ashr %6, %2  : vector<2xi64>
    %8 = llvm.extractelement %7[%3 : i32] : vector<2xi64>
    %9 = llvm.add %0, %8 overflow<nsw>  : i64
    llvm.cond_br %arg5, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    llvm.br ^bb6
  ^bb5:  // pred: ^bb3
    llvm.br ^bb6
  ^bb6:  // 2 preds: ^bb4, ^bb5
    llvm.cond_br %arg3, ^bb9, ^bb7
  ^bb7:  // pred: ^bb6
    llvm.cond_br %arg4, ^bb9, ^bb8
  ^bb8:  // pred: ^bb7
    llvm.br ^bb9
  ^bb9:  // 3 preds: ^bb6, ^bb7, ^bb8
    llvm.unreachable
  ^bb10:  // 2 preds: ^bb0, ^bb2
    llvm.return
  }
}
