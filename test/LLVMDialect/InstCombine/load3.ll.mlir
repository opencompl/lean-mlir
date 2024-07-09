module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.mlir.global private constant @".str"("XYZ\00") {addr_space = 0 : i32, dso_local}
  llvm.mlir.global external @rslts32(dense<0> : tensor<36xi32>) {addr_space = 0 : i32, alignment = 4 : i64} : !llvm.array<36 x i32>
  llvm.mlir.global internal constant @expect32(dense<[1, 2, 0, 100, 3, 4, 0, -7, 4, 4, 8, 8, 1, 3, 8, 3, 4, -2, 2, 8, 83, 77, 8, 17, 77, 88, 22, 33, 44, 88, 77, 4, 4, 7, -7, -8]> : tensor<36xi32>) {addr_space = 0 : i32, alignment = 4 : i64, dso_local} : !llvm.array<36 x i32>
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    %3 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %5 = llvm.sub %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test2() -> f32 {
    %0 = llvm.mlir.constant("XYZ\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> f32
    llvm.return %2 : f32
  }
  llvm.func @test3() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(28 : i32) : i32
    %1 = llvm.mlir.constant(29826161 : i32) : i32
    %2 = llvm.mlir.constant(dense<[1, 2, 0, 100, 3, 4, 0, -7, 4, 4, 8, 8, 1, 3, 8, 3, 4, -2, 2, 8, 83, 77, 8, 17, 77, 88, 22, 33, 44, 88, 77, 4, 4, 7, -7, -8]> : tensor<36xi32>) : !llvm.array<36 x i32>
    %3 = llvm.mlir.addressof @expect32 : !llvm.ptr
    %4 = llvm.getelementptr %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<36 x i32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(dense<0> : tensor<36xi32>) : !llvm.array<36 x i32>
    %7 = llvm.mlir.addressof @rslts32 : !llvm.ptr
    %8 = llvm.getelementptr %7[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<36 x i32>
    %9 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %9, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
