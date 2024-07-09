module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<2>, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<3>, dense<64> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr, dense<[40, 64, 64, 32]> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<1>, dense<16> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test58_d(i64) -> i32
  llvm.func @test59(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.icmp "ult" %2, %3 : !llvm.ptr
    %5 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %6 = llvm.call @test58_d(%5) : (i64) -> i32
    llvm.return %4 : i1
  }
  llvm.func @test59_as1(%arg0: !llvm.ptr<1>) -> i1 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %3 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.icmp "ult" %2, %3 : !llvm.ptr<1>
    %5 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    %6 = llvm.call @test58_d(%5) : (i64) -> i32
    llvm.return %4 : i1
  }
  llvm.func @test60(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %1 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.icmp "ult" %0, %1 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @test60_as1(%arg0: !llvm.ptr<1>, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %1 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %2 = llvm.icmp "ult" %0, %1 : !llvm.ptr<1>
    llvm.return %2 : i1
  }
  llvm.func @test60_addrspacecast(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.getelementptr inbounds %0[%arg1] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i32
    %2 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.addrspacecast %1 : !llvm.ptr<3> to !llvm.ptr
    %4 = llvm.icmp "ult" %3, %2 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @test60_addrspacecast_smaller(%arg0: !llvm.ptr, %arg1: i16, %arg2: i64) -> i1 {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<1>
    %1 = llvm.getelementptr inbounds %0[%arg1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i32
    %2 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.addrspacecast %1 : !llvm.ptr<1> to !llvm.ptr
    %4 = llvm.icmp "ult" %3, %2 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @test60_addrspacecast_larger(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i16) -> i1 {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    %1 = llvm.getelementptr inbounds %0[%arg1] : (!llvm.ptr<2>, i32) -> !llvm.ptr<2>, i32
    %2 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %3 = llvm.addrspacecast %1 : !llvm.ptr<2> to !llvm.ptr<1>
    %4 = llvm.icmp "ult" %3, %2 : !llvm.ptr<1>
    llvm.return %4 : i1
  }
  llvm.func @test61(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %1 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.icmp "ult" %0, %1 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @test61_as1(%arg0: !llvm.ptr<1>, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i32
    %1 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %2 = llvm.icmp "ult" %0, %1 : !llvm.ptr<1>
    llvm.return %2 : i1
  }
  llvm.func @test62(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.icmp "slt" %2, %3 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @test62_as1(%arg0: !llvm.ptr<1>) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %3 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.icmp "slt" %2, %3 : !llvm.ptr<1>
    llvm.return %4 : i1
  }
  llvm.func @icmp_and_ashr_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(14 : i32) : i32
    %4 = llvm.mlir.constant(27 : i32) : i32
    %5 = llvm.ashr %arg0, %0  : i32
    %6 = llvm.and %5, %1  : i32
    %7 = llvm.and %5, %2  : i32
    %8 = llvm.icmp "ne" %6, %3 : i32
    %9 = llvm.icmp "ne" %7, %4 : i32
    %10 = llvm.and %8, %9  : i1
    llvm.return %10 : i1
  }
  llvm.func @icmp_and_ashr_multiuse_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(14 : i32) : i32
    %4 = llvm.mlir.constant(27 : i32) : i32
    %5 = llvm.mlir.constant(false) : i1
    %6 = llvm.ashr %arg0, %0  : i32
    %7 = llvm.and %6, %1  : i32
    %8 = llvm.and %6, %2  : i32
    %9 = llvm.icmp "ne" %7, %3 : i32
    %10 = llvm.icmp "ne" %8, %4 : i32
    %11 = llvm.select %9, %10, %5 : i1, i1
    llvm.return %11 : i1
  }
  llvm.func @icmp_lshr_and_overshift(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "ne" %4, %2 : i8
    llvm.return %5 : i1
  }
  llvm.func @icmp_ashr_and_overshift(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.ashr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "ne" %4, %2 : i8
    llvm.return %5 : i1
  }
  llvm.func @test71(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.icmp "ugt" %1, %2 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @test71_as1(%arg0: !llvm.ptr<1>) -> i1 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %3 = llvm.icmp "ugt" %1, %2 : !llvm.ptr<1>
    llvm.return %3 : i1
  }
}
