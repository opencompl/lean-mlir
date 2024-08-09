module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func internal @<<INVALID EMPTY SYMBOL>>(%arg0: !llvm.ptr) attributes {dso_local} {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.poison : vector<4xf32>
    %4 = llvm.mlir.constant(48 : i32) : i32
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.bitcast %arg0 : !llvm.ptr to !llvm.ptr
    %7 = llvm.load %6 {alignment = 1 : i64} : !llvm.ptr -> i32
    %8 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %9 = llvm.bitcast %8 : !llvm.ptr to !llvm.ptr
    %10 = llvm.load %9 {alignment = 1 : i64} : !llvm.ptr -> i32
    llvm.br ^bb1(%1, %7 : vector<4xf32>, i32)
  ^bb1(%11: vector<4xf32>, %12: i32):  // 2 preds: ^bb0, ^bb2
    %13 = llvm.icmp "slt" %12, %10 : i32
    llvm.cond_br %13, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %14 = llvm.sitofp %12 : i32 to f32
    %15 = llvm.insertelement %14, %11[%2 : i32] : vector<4xf32>
    %16 = llvm.shufflevector %15, %3 [0, 0, 0, 0] : vector<4xf32> 
    %17 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %18 = llvm.bitcast %17 : !llvm.ptr to !llvm.ptr
    llvm.store %16, %18 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr
    %19 = llvm.add %12, %5  : i32
    llvm.br ^bb1(%16, %19 : vector<4xf32>, i32)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}
