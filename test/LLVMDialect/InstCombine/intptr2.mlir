module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.readnone}, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.icmp "ult" %arg0, %arg1 : !llvm.ptr
    llvm.cond_br %2, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %3 = llvm.ptrtoint %arg2 : !llvm.ptr to i64
    llvm.br ^bb2(%arg0, %3 : !llvm.ptr, i64)
  ^bb2(%4: !llvm.ptr, %5: i64):  // 2 preds: ^bb1, ^bb2
    %6 = llvm.inttoptr %5 : i64 to !llvm.ptr
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %8 = llvm.fmul %7, %0  : f32
    llvm.store %8, %4 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.getelementptr inbounds %6[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %10 = llvm.ptrtoint %9 : !llvm.ptr to i64
    %11 = llvm.getelementptr inbounds %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %12 = llvm.icmp "ult" %11, %arg1 : !llvm.ptr
    llvm.cond_br %12, ^bb2(%11, %10 : !llvm.ptr, i64), ^bb3
  ^bb3:  // 2 preds: ^bb0, ^bb2
    llvm.return
  }
}
