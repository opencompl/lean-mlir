module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @umulov_square_i32(%arg0: i32) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.return %1 : i1
  }
  llvm.func @umulov_square_i16(%arg0: i16) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg0) : (i16, i16) -> !llvm.struct<(i16, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i16, i1)> 
    llvm.return %1 : i1
  }
  llvm.func @umulov_square_i13(%arg0: i13) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg0) : (i13, i13) -> !llvm.struct<(i13, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i13, i1)> 
    llvm.return %1 : i1
  }
  llvm.func @umulov_square_i32_multiuse(%arg0: i32) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i1)> 
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %1 : i1
  }
  llvm.func @smulov_square_i32(%arg0: i32) -> i1 {
    %0 = "llvm.intr.smul.with.overflow"(%arg0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.return %1 : i1
  }
  llvm.func @use(i32)
}
