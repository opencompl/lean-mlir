module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_generic(%arg0: i64, %arg1: i64) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i64, i1)> 
    llvm.return %1 : i1
  }
  llvm.func @test_constant0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }
  llvm.func @test_constant1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }
  llvm.func @test_constant2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }
  llvm.func @test_constant3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }
  llvm.func @test_constant4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }
  llvm.func @test_constant127(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }
  llvm.func @test_constant128(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }
  llvm.func @test_constant255(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }
  llvm.func @i1_res(%arg0: i1, %arg1: i1) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i1, i1) -> !llvm.struct<(i1, i1)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i1, i1)> 
    llvm.return %1 : i1
  }
  llvm.func @v2i1_res(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (vector<2xi1>, vector<2xi1>) -> !llvm.struct<(vector<2xi1>, vector<2xi1>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(vector<2xi1>, vector<2xi1>)> 
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @i1_res_by_one(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i1, i1) -> !llvm.struct<(i1, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i1, i1)> 
    llvm.return %2 : i1
  }
  llvm.func @v2i1_res_by_one(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %1) : (vector<2xi1>, vector<2xi1>) -> !llvm.struct<(vector<2xi1>, vector<2xi1>)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(vector<2xi1>, vector<2xi1>)> 
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @i1_ov(%arg0: i1, %arg1: i1) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i1, i1) -> !llvm.struct<(i1, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i1, i1)> 
    llvm.return %1 : i1
  }
  llvm.func @v2i1_ov(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (vector<2xi1>, vector<2xi1>) -> !llvm.struct<(vector<2xi1>, vector<2xi1>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(vector<2xi1>, vector<2xi1>)> 
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @i1_ov_by_one(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i1, i1) -> !llvm.struct<(i1, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i1, i1)> 
    llvm.return %2 : i1
  }
  llvm.func @v2i1_ov_by_one(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %1) : (vector<2xi1>, vector<2xi1>) -> !llvm.struct<(vector<2xi1>, vector<2xi1>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(vector<2xi1>, vector<2xi1>)> 
    llvm.return %3 : vector<2xi1>
  }
}
