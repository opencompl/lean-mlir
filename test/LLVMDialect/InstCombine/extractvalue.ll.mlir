module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @bar(!llvm.struct<(i32, i32)>)
  llvm.func @baz(i32) -> i32
  llvm.func @foo(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.mlir.undef : !llvm.struct<(i32, struct<(i32, i32)>)>
    %2 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %arg1, %2[1] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i32)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i32)> 
    %6 = llvm.insertvalue %4, %1[0] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %7 = llvm.insertvalue %4, %6[1, 0] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %8 = llvm.insertvalue %5, %7[1, 1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %9 = llvm.extractvalue %8[1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %10 = llvm.extractvalue %8[1, 1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    llvm.call @bar(%9) : (!llvm.struct<(i32, i32)>) -> ()
    %11 = llvm.extractvalue %8[1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %12 = llvm.extractvalue %11[1] : !llvm.struct<(i32, i32)> 
    llvm.call @bar(%11) : (!llvm.struct<(i32, i32)>) -> ()
    %13 = llvm.insertvalue %10, %0[0] : !llvm.struct<(i32, i32)> 
    %14 = llvm.insertvalue %12, %13[1] : !llvm.struct<(i32, i32)> 
    %15 = llvm.insertvalue %14, %1[1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %16 = llvm.extractvalue %15[1, 1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    llvm.return %16 : i32
  }
  llvm.func @extract2gep(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<(i16, i32)>
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i16, i32)> 
    %3 = llvm.call @baz(%2) : (i32) -> i32
    llvm.store %3, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.cond_br %4, ^bb2, ^bb1
  ^bb2:  // pred: ^bb1
    llvm.return %2 : i32
  }
  llvm.func @doubleextract2gep(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<(i16, struct<(i32, i16)>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i16, struct<(i32, i16)>)> 
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i16)> 
    llvm.return %2 : i16
  }
  llvm.func @"nogep-multiuse"(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.add %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @"nogep-volatile"(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i32)> 
    llvm.return %1 : i32
  }
}
