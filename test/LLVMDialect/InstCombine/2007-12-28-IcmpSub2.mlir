module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "ule" %4, %1 : i32
    %6 = llvm.select %5, %1, %0 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test2() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test3() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test4() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "sle" %4, %1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test5() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "sge" %4, %1 : i32
    %6 = llvm.select %5, %1, %0 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test6() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.select %5, %1, %0 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test7() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %1, %0 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test8() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    llvm.return %6 : i32
  }
}
