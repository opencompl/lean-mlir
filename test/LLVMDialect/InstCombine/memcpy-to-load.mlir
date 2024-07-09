#alias_scope_domain = #llvm.alias_scope_domain<id = distinct[0]<>, description = "The domain">
#alias_scope_domain1 = #llvm.alias_scope_domain<id = distinct[1]<>>
#alias_scope = #llvm.alias_scope<id = distinct[2]<>, domain = #alias_scope_domain>
#alias_scope1 = #llvm.alias_scope<id = distinct[3]<>, domain = #alias_scope_domain1>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @copy_1_byte(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @copy_2_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(2 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @copy_3_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(3 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @copy_4_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @copy_5_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(5 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @copy_8_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @copy_16_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @copy_8_bytes_noalias(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{alias_scopes = [#alias_scope], isVolatile = false, noalias_scopes = [#alias_scope1]}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
}
