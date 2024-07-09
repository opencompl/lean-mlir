module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func unnamed_addr @test(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.readnone}, %arg2: i64) {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.icmp "ult" %arg0, %arg1 : !llvm.ptr
    llvm.cond_br %2, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %3 = llvm.inttoptr %arg2 : i64 to !llvm.ptr
    llvm.br ^bb2(%arg0, %3, %arg2 : !llvm.ptr, !llvm.ptr, i64)
  ^bb2(%4: !llvm.ptr, %5: !llvm.ptr, %6: i64):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32
    %8 = llvm.fmul %7, %0  : f32
    llvm.store %8, %4 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.inttoptr %6 : i64 to !llvm.ptr
    %10 = llvm.getelementptr inbounds %9[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %11 = llvm.ptrtoint %10 : !llvm.ptr to i64
    %12 = llvm.getelementptr inbounds %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %13 = llvm.icmp "ult" %12, %arg1 : !llvm.ptr
    llvm.cond_br %13, ^bb2(%12, %10, %11 : !llvm.ptr, !llvm.ptr, i64), ^bb3
  ^bb3:  // 2 preds: ^bb0, ^bb2
    llvm.return
  }
}
