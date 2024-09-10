module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @Unknown() {addr_space = 0 : i32} : i128
  llvm.func @test(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    "llvm.intr.memset"(%arg0, %0, %2) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    "llvm.intr.memset"(%arg0, %0, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    "llvm.intr.memset"(%arg0, %0, %4) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    "llvm.intr.memset"(%arg0, %0, %5) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %1 : i32
  }
  llvm.func @memset_to_constant() {
    %0 = llvm.mlir.addressof @Unknown : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(16 : i32) : i32
    "llvm.intr.memset"(%0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return
  }
  llvm.func @memset_undef(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return
  }
  llvm.func @memset_undef_volatile(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = true}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return
  }
  llvm.func @memset_poison(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return
  }
  llvm.func @memset_poison_volatile(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = true}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return
  }
}
