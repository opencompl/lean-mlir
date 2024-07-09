module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<[40, 64, 64, 32]> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @Global() {addr_space = 0 : i32} : !llvm.array<10 x i8>
  llvm.mlir.global external @global_as2(0 : i32) {addr_space = 2 : i32} : i32
  llvm.mlir.global external @global_as1_as2_ptr() {addr_space = 1 : i32} : !llvm.struct<"as2_ptr_struct", (ptr<2>)> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @global_as2 : !llvm.ptr<2>
    %2 = llvm.mlir.undef : !llvm.struct<"as2_ptr_struct", (ptr<2>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"as2_ptr_struct", (ptr<2>)> 
    llvm.return %3 : !llvm.struct<"as2_ptr_struct", (ptr<2>)>
  }
  llvm.mlir.global external @arst() {addr_space = 1 : i32} : !llvm.array<4 x ptr<2>> {
    %0 = llvm.mlir.zero : !llvm.ptr<2>
    %1 = llvm.mlir.undef : !llvm.array<4 x ptr<2>>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.array<4 x ptr<2>> 
    %3 = llvm.insertvalue %0, %2[1] : !llvm.array<4 x ptr<2>> 
    %4 = llvm.insertvalue %0, %3[2] : !llvm.array<4 x ptr<2>> 
    %5 = llvm.insertvalue %0, %4[3] : !llvm.array<4 x ptr<2>> 
    llvm.return %5 : !llvm.array<4 x ptr<2>>
  }
  llvm.mlir.global external @G() {addr_space = 0 : i32} : !llvm.array<3 x i8>
  llvm.mlir.global external @Array() {addr_space = 0 : i32} : !llvm.array<40 x i32>
  llvm.mlir.global external @X_as1(dense<0> : tensor<1000xi8>) {addr_space = 1 : i32, alignment = 16 : i64} : !llvm.array<1000 x i8>
  llvm.func @test1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i8) -> !llvm.ptr, i32
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i16) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @test2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32)>
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test3(%arg0: i8) {
    %0 = llvm.mlir.addressof @Global : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.getelementptr %0[%1, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i8>
    llvm.store %arg0, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test_evaluate_gep_nested_as_ptrs(%arg0: !llvm.ptr<2>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @global_as2 : !llvm.ptr<2>
    %2 = llvm.mlir.undef : !llvm.struct<"as2_ptr_struct", (ptr<2>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"as2_ptr_struct", (ptr<2>)> 
    %4 = llvm.mlir.addressof @global_as1_as2_ptr : !llvm.ptr<1>
    llvm.store %arg0, %4 {alignment = 8 : i64} : !llvm.ptr<2>, !llvm.ptr<1>
    llvm.return
  }
  llvm.func @test_evaluate_gep_as_ptrs_array(%arg0: !llvm.ptr<2>) {
    %0 = llvm.mlir.zero : !llvm.ptr<2>
    %1 = llvm.mlir.undef : !llvm.array<4 x ptr<2>>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.array<4 x ptr<2>> 
    %3 = llvm.insertvalue %0, %2[1] : !llvm.array<4 x ptr<2>> 
    %4 = llvm.insertvalue %0, %3[2] : !llvm.array<4 x ptr<2>> 
    %5 = llvm.insertvalue %0, %4[3] : !llvm.array<4 x ptr<2>> 
    %6 = llvm.mlir.addressof @arst : !llvm.ptr<1>
    %7 = llvm.mlir.constant(0 : i16) : i16
    %8 = llvm.mlir.constant(2 : i16) : i16
    %9 = llvm.getelementptr %6[%7, %8] : (!llvm.ptr<1>, i16, i16) -> !llvm.ptr<1>, !llvm.array<4 x ptr<2>>
    llvm.store %arg0, %9 {alignment = 8 : i64} : !llvm.ptr<2>, !llvm.ptr<1>
    llvm.return
  }
  llvm.func @test4(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %1 = llvm.getelementptr %0[%arg2] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test5(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    %3 = llvm.getelementptr %arg1[%0, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    %4 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @test6(%arg0: vector<2xi32>, %arg1: !llvm.vec<2 x ptr>) -> vector<2xi1> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.getelementptr inbounds %arg1[%1, 1, %arg0] : (!llvm.vec<2 x ptr>, vector<2xi32>, vector<2xi32>) -> !llvm.vec<2 x ptr>, !llvm.struct<"S", (i32, array<100 x i32>)>
    %4 = llvm.getelementptr inbounds %arg1[%1, 0] : (!llvm.vec<2 x ptr>, vector<2xi32>) -> !llvm.vec<2 x ptr>, !llvm.struct<"S", (i32, array<100 x i32>)>
    %5 = llvm.icmp "eq" %3, %4 : !llvm.vec<2 x ptr>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @test6b(%arg0: vector<2xi32>, %arg1: !llvm.vec<2 x ptr>) -> vector<2xi1> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr inbounds %arg1[%0, 1, %arg0] : (!llvm.vec<2 x ptr>, i32, vector<2xi32>) -> !llvm.vec<2 x ptr>, !llvm.struct<"S", (i32, array<100 x i32>)>
    %3 = llvm.getelementptr inbounds %arg1[%0, 0] : (!llvm.vec<2 x ptr>, i32) -> !llvm.vec<2 x ptr>, !llvm.struct<"S", (i32, array<100 x i32>)>
    %4 = llvm.icmp "eq" %2, %3 : !llvm.vec<2 x ptr>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test7(%arg0: i16) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @G : !llvm.ptr
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.getelementptr %0[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @test8(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @Array : !llvm.ptr
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test9(%arg0: !llvm.ptr, %arg1: i8) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i8) -> !llvm.ptr, i32
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test10() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.getelementptr %0[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, f64)>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i32
    llvm.return %4 : i32
  }
  llvm.func @constant_fold_custom_dl() -> i16 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<1000xi8>) : !llvm.array<1000 x i8>
    %4 = llvm.mlir.addressof @X_as1 : !llvm.ptr<1>
    %5 = llvm.getelementptr inbounds %4[%1, %0] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<1000 x i8>
    %6 = llvm.mlir.constant(0 : i16) : i16
    %7 = llvm.bitcast %5 : !llvm.ptr<1> to !llvm.ptr<1>
    %8 = llvm.ptrtoint %4 : !llvm.ptr<1> to i16
    %9 = llvm.sub %6, %8  : i16
    %10 = llvm.getelementptr %7[%9] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %11 = llvm.ptrtoint %10 : !llvm.ptr<1> to i16
    llvm.return %11 : i16
  }
}
