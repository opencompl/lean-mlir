module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(!llvm.ptr)
  llvm.func @bar(!llvm.ptr<1>)
  llvm.func @nonnullAfterBitCast() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @nonnullAfterSExt(%arg0: i8) {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.inttoptr %3 : i64 to !llvm.ptr
    llvm.call @foo(%4) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @nonnullAfterZExt(%arg0: i8) {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.inttoptr %3 : i64 to !llvm.ptr
    llvm.call @foo(%4) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @nonnullAfterInt2Ptr(%arg0: i32, %arg1: i64) {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(100 : i64) : i64
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    llvm.call @foo(%3) : (!llvm.ptr) -> ()
    %4 = llvm.sdiv %1, %arg1  : i64
    %5 = llvm.inttoptr %4 : i64 to !llvm.ptr
    llvm.call @foo(%5) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @nonnullAfterPtr2Int() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr
    llvm.call @foo(%3) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @maybenullAfterInt2Ptr(%arg0: i128) {
    %0 = llvm.mlir.constant(0 : i128) : i128
    %1 = llvm.icmp "ne" %arg0, %0 : i128
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.inttoptr %arg0 : i128 to !llvm.ptr
    llvm.call @foo(%2) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @maybenullAfterPtr2Int() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    llvm.call @foo(%3) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @maybenullAfterAddrspacecast(%arg0: !llvm.ptr {llvm.nonnull}) {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<1>
    llvm.call @bar(%0) : (!llvm.ptr<1>) -> ()
    llvm.call @foo(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }
}
