module  {
  llvm.func @use(i8)
  llvm.func @use_vec(vector<2xi8>)
  llvm.func @test_nonzero(%arg0: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<i32>
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test_nonzero2(%arg0: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<i32>
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test_nonzero3(%arg0: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<i32>
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test_nonzero4(%arg0: !llvm.ptr<i8>) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.load %arg0 : !llvm.ptr<i8>
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @test_nonzero5(%arg0: !llvm.ptr<i8>) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.load %arg0 : !llvm.ptr<i8>
    %2 = llvm.icmp "ugt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @test_nonzero6(%arg0: !llvm.ptr<i8>) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.load %arg0 : !llvm.ptr<i8>
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @test_not_in_range(%arg0: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<i32>
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test_in_range(%arg0: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<i32>
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test_range_sgt_constant(%arg0: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<i32>
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test_range_slt_constant(%arg0: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<i32>
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test_multi_range1(%arg0: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<i32>
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test_multi_range2(%arg0: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<i32>
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test_two_ranges(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    %1 = llvm.load %arg1 : !llvm.ptr<i32>
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test_two_ranges2(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    %1 = llvm.load %arg1 : !llvm.ptr<i32>
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test_two_ranges3(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    %1 = llvm.load %arg1 : !llvm.ptr<i32>
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ugt_zext(%arg0: i1, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i8
    %1 = llvm.icmp "ugt" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @ult_zext(%arg0: vector<2xi1>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mul %arg1, %arg1  : vector<2xi8>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi8>
    %2 = llvm.icmp "ult" %0, %1 : vector<2xi8>
    llvm.return %2 : i1
  }
  llvm.func @uge_zext(%arg0: i1, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i8
    %1 = llvm.icmp "uge" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @ule_zext(%arg0: i1, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg1, %arg1  : i8
    %1 = llvm.zext %arg0 : i1 to i8
    %2 = llvm.icmp "ule" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @ugt_zext_use(%arg0: i1, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.icmp "ugt" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @ult_zext_not_i1(%arg0: i2, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i2 to i8
    %1 = llvm.icmp "ult" %arg1, %0 : i8
    llvm.return %1 : i1
  }
  llvm.func @sub_ult_zext(%arg0: i1, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i8
    %1 = llvm.sub %arg1, %arg2  : i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @zext_ult_zext(%arg0: i1, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg1, %arg1  : i8
    %1 = llvm.zext %arg0 : i1 to i16
    %2 = llvm.zext %0 : i8 to i16
    %3 = llvm.icmp "ult" %2, %1 : i16
    llvm.return %3 : i1
  }
  llvm.func @zext_ugt_zext(%arg0: i1, %arg1: i4) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i8
    %1 = llvm.zext %arg1 : i4 to i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "ugt" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @sub_ult_zext_not_i1(%arg0: i2, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.zext %arg0 : i2 to i8
    %1 = llvm.sub %arg1, %arg2  : i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sub_ult_zext_use1(%arg0: i1, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.sub %arg1, %arg2  : i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @zext_ugt_sub_use2(%arg0: vector<2xi1>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.zext %arg0 : vector<2xi1> to vector<2xi8>
    %1 = llvm.sub %arg1, %arg2  : vector<2xi8>
    llvm.call @use_vec(%1) : (vector<2xi8>) -> ()
    %2 = llvm.icmp "ugt" %0, %1 : vector<2xi8>
    llvm.return %2 : i1
  }
  llvm.func @sub_ult_zext_use3(%arg0: i1, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.sub %arg1, %arg2  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sub_ule_zext(%arg0: i1, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i8
    %1 = llvm.sub %arg1, %arg2  : i8
    %2 = llvm.icmp "ule" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sub_ult_and(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    %2 = llvm.sub %arg1, %arg2  : vector<2xi8>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi8>
    llvm.return %3 : i1
  }
  llvm.func @and_ugt_sub(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.sub %arg1, %arg2  : i8
    %3 = llvm.icmp "ugt" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @uge_sext(%arg0: i1, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i8
    %1 = llvm.icmp "uge" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @ule_sext(%arg0: vector<2xi1>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mul %arg1, %arg1  : vector<2xi8>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi8>
    %2 = llvm.icmp "ule" %0, %1 : vector<2xi8>
    llvm.return %2 : i1
  }
  llvm.func @ugt_sext(%arg0: i1, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i8
    %1 = llvm.icmp "ugt" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @ult_sext(%arg0: i1, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg1, %arg1  : i8
    %1 = llvm.sext %arg0 : i1 to i8
    %2 = llvm.icmp "ult" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @uge_sext_use(%arg0: i1, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @ule_sext_not_i1(%arg0: i2, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i2 to i8
    %1 = llvm.icmp "ule" %arg1, %0 : i8
    llvm.return %1 : i1
  }
  llvm.func @sub_ule_sext(%arg0: i1, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i8
    %1 = llvm.sub %arg1, %arg2  : i8
    %2 = llvm.icmp "ule" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sext_ule_sext(%arg0: i1, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg1, %arg1  : i8
    %1 = llvm.sext %arg0 : i1 to i16
    %2 = llvm.sext %0 : i8 to i16
    %3 = llvm.icmp "ule" %2, %1 : i16
    llvm.return %3 : i1
  }
  llvm.func @sext_uge_sext(%arg0: i1, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i8
    %1 = llvm.sext %arg1 : i4 to i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "uge" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @sub_ule_sext_not_i1(%arg0: i2, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.sext %arg0 : i2 to i8
    %1 = llvm.sub %arg1, %arg2  : i8
    %2 = llvm.icmp "ule" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sub_ule_sext_use1(%arg0: i1, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.sub %arg1, %arg2  : i8
    %2 = llvm.icmp "ule" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sext_uge_sub_use2(%arg0: vector<2xi1>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.sext %arg0 : vector<2xi1> to vector<2xi8>
    %1 = llvm.sub %arg1, %arg2  : vector<2xi8>
    llvm.call @use_vec(%1) : (vector<2xi8>) -> ()
    %2 = llvm.icmp "uge" %0, %1 : vector<2xi8>
    llvm.return %2 : i1
  }
  llvm.func @sub_ule_sext_use3(%arg0: i1, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.sub %arg1, %arg2  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "ule" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sub_ult_sext(%arg0: i1, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i8
    %1 = llvm.sub %arg1, %arg2  : i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sub_ule_ashr(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    %2 = llvm.sub %arg1, %arg2  : vector<2xi8>
    %3 = llvm.icmp "ule" %2, %1 : vector<2xi8>
    llvm.return %3 : i1
  }
  llvm.func @ashr_uge_sub(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sub %arg1, %arg2  : i8
    %3 = llvm.icmp "uge" %1, %2 : i8
    llvm.return %3 : i1
  }
}
