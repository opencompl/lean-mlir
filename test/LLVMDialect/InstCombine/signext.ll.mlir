module  {
  llvm.func @use(i32)
  llvm.func @sextinreg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.and %arg0, %2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @sextinreg_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.and %arg0, %2  : i32
    %4 = llvm.xor %3, %1  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.add %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @sextinreg_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32768> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-32768> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %2  : vector<2xi32>
    %4 = llvm.xor %3, %1  : vector<2xi32>
    %5 = llvm.add %4, %0  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @sextinreg_alt(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32768 : i32) : i32
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.and %arg0, %2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @sextinreg_alt_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-32768> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<32768> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %2  : vector<2xi32>
    %4 = llvm.xor %3, %1  : vector<2xi32>
    %5 = llvm.add %4, %0  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @sext(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32768 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.add %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @sext_extra_use(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32768 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.xor %2, %1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.add %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @sext_splat(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-32768> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<32768> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    %4 = llvm.add %3, %0  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @sextinreg2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.and %arg0, %2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @sextinreg2_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<255> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %2  : vector<2xi32>
    %4 = llvm.xor %3, %1  : vector<2xi32>
    %5 = llvm.add %4, %0  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test6(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.shl %1, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @test6_splat_vec(%arg0: vector<2xi12>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<20> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi12> to vector<2xi32>
    %2 = llvm.shl %1, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-67108864 : i32) : i32
    %1 = llvm.mlir.constant(67108864 : i32) : i32
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @ashr_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-67108864> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<67108864> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.lshr %arg0, %2  : vector<2xi32>
    %4 = llvm.xor %3, %1  : vector<2xi32>
    %5 = llvm.add %4, %0  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
}
