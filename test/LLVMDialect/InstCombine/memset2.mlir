module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: !llvm.ptr<1> {llvm.nocapture}) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.constant(8 : i64) : i64
    %5 = llvm.getelementptr inbounds %arg0[%0, 0, %2] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.struct<"struct.Moves", (array<9 x i8>, i8, i8, i8, array<5 x i8>)>
    "llvm.intr.memset"(%5, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, i8, i64) -> ()
    llvm.return %1 : i32
  }
}
