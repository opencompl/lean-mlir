module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @bar(%arg0: i64) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x !llvm.struct<"struct.Key", (struct<(i32, i32)>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.bitcast %1 : i32 to i32
    %5 = llvm.getelementptr %2[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.Key", (struct<(i32, i32)>)>
    %6 = llvm.getelementptr %5[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    llvm.store %1, %6 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.getelementptr %5[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    llvm.store %1, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    %8 = llvm.getelementptr %2[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.Key", (struct<(i32, i32)>)>
    llvm.store %arg0, %8 {alignment = 4 : i64} : i64, !llvm.ptr
    %9 = llvm.call @foo(%2, %3) vararg(!llvm.func<i32 (...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    %10 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %10 : i32
  }
  llvm.func @foo(...) -> i32
}
