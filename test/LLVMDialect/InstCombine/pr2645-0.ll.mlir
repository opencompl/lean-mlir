module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func internal @<<INVALID EMPTY SYMBOL>>(%arg0: !llvm.ptr) attributes {dso_local} {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(48 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.bitcast %arg0 : !llvm.ptr to !llvm.ptr
    %6 = llvm.load %5 {alignment = 1 : i64} : !llvm.ptr -> i32
    %7 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %8 = llvm.bitcast %7 : !llvm.ptr to !llvm.ptr
    %9 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i32
    llvm.br ^bb1(%1, %6 : vector<4xf32>, i32)
  ^bb1(%10: vector<4xf32>, %11: i32):  // 2 preds: ^bb0, ^bb2
    %12 = llvm.icmp "slt" %11, %9 : i32
    llvm.cond_br %12, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %13 = llvm.sitofp %11 : i32 to f32
    %14 = llvm.insertelement %13, %10[%2 : i32] : vector<4xf32>
    %15 = llvm.shufflevector %14, %1 [0, 0, 0, 0] : vector<4xf32> 
    %16 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %17 = llvm.bitcast %16 : !llvm.ptr to !llvm.ptr
    llvm.store %15, %17 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr
    %18 = llvm.add %11, %4  : i32
    llvm.br ^bb1(%15, %18 : vector<4xf32>, i32)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}
