module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @empty(dense<0> : tensor<1xi8>) {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.mlir.global external constant @A("A\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @hello("hello\0A\00") {addr_space = 0 : i32}
  llvm.func @fputs(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @test_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.call @fputs(%2, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_simplify2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("A\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @A : !llvm.ptr
    %2 = llvm.call @fputs(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_simplify3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello\0A\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @fputs(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
}
