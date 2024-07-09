module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @test1.aligned_glbl() {addr_space = 0 : i32, alignment = 4 : i64} : !llvm.struct<"test1.struct", (i32, i32)> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.struct<"test1.struct", (i32, i32)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"test1.struct", (i32, i32)> 
    %3 = llvm.insertvalue %0, %2[1] : !llvm.struct<"test1.struct", (i32, i32)> 
    llvm.return %3 : !llvm.struct<"test1.struct", (i32, i32)>
  }
  llvm.mlir.global external constant @channel_wg4idx() {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : !llvm.array<9 x i8>
  llvm.func @test1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"test1.struct", (i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"test1.struct", (i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"test1.struct", (i32, i32)> 
    %5 = llvm.mlir.addressof @test1.aligned_glbl : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"test1.struct", (i32, i32)>
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.mlir.constant(3 : i64) : i64
    %9 = llvm.and %7, %8  : i64
    llvm.store %9, %arg0 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @OpenFilter(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @channel_wg4idx : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.sub %arg0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i8
    %4 = llvm.zext %3 : i8 to i64
    llvm.return %4 : i64
  }
}
