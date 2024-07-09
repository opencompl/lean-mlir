module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<4>, dense<16> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<3>, dense<16> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<1>, dense<64> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<2>, dense<8> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_as0(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_as1(%arg0: !llvm.ptr<1>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_as2(%arg0: !llvm.ptr<2>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<2>, i32) -> !llvm.ptr<2>, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr<2> -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_as3(%arg0: !llvm.ptr<3>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr<3> -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_combine_ptrtoint(%arg0: !llvm.ptr<2>) -> i32 {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr<2> to i8
    %1 = llvm.inttoptr %0 : i8 to !llvm.ptr<2>
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr<2> -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_combine_inttoptr(%arg0: i8) -> i8 {
    %0 = llvm.inttoptr %arg0 : i8 to !llvm.ptr<2>
    %1 = llvm.ptrtoint %0 : !llvm.ptr<2> to i8
    llvm.return %1 : i8
  }
  llvm.func @test_combine_vector_ptrtoint(%arg0: !llvm.vec<2 x ptr<2>>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.ptrtoint %arg0 : !llvm.vec<2 x ptr<2>> to vector<2xi8>
    %2 = llvm.inttoptr %1 : vector<2xi8> to !llvm.vec<2 x ptr<2>>
    %3 = llvm.extractelement %2[%0 : i32] : !llvm.vec<2 x ptr<2>>
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr<2> -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_combine_vector_inttoptr(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.inttoptr %arg0 : vector<2xi8> to !llvm.vec<2 x ptr<2>>
    %1 = llvm.ptrtoint %0 : !llvm.vec<2 x ptr<2>> to vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
  llvm.func @shrink_gep_constant_index_64_as2(%arg0: !llvm.ptr<2>) -> !llvm.ptr<2> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i32
    llvm.return %1 : !llvm.ptr<2>
  }
  llvm.func @shrink_gep_constant_index_32_as2(%arg0: !llvm.ptr<2>) -> !llvm.ptr<2> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<2>, i32) -> !llvm.ptr<2>, i32
    llvm.return %1 : !llvm.ptr<2>
  }
  llvm.func @shrink_gep_constant_index_64_as3(%arg0: !llvm.ptr<3>) -> !llvm.ptr<3> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i32
    llvm.return %1 : !llvm.ptr<3>
  }
  llvm.func @shrink_gep_variable_index_64_as2(%arg0: !llvm.ptr<2>, %arg1: i64) -> !llvm.ptr<2> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i32
    llvm.return %0 : !llvm.ptr<2>
  }
  llvm.func @grow_gep_variable_index_8_as1(%arg0: !llvm.ptr<1>, %arg1: i8) -> !llvm.ptr<1> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<1>, i8) -> !llvm.ptr<1>, i32
    llvm.return %0 : !llvm.ptr<1>
  }
}
