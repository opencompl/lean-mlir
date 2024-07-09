module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fold_to_new_instruction(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : !llvm.ptr
    llvm.return %0 : i1
  }
  llvm.func @fold_to_new_instruction2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : !llvm.ptr
    llvm.return %0 : i1
  }
  llvm.func @do_not_add_annotation_to_existing_instr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @copy_1_byte(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @memcpy(!llvm.ptr {llvm.noalias, llvm.returned}, !llvm.ptr {llvm.noalias, llvm.nocapture, llvm.readonly}, i64) -> !llvm.ptr attributes {passthrough = ["nofree", "nounwind"]}
  llvm.func @libcallcopy_1_byte(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.call @memcpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @__memcpy_chk(!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr attributes {passthrough = ["nofree", "nounwind"]}
  llvm.func @libcallcopy_1_byte_chk(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.call @__memcpy_chk(%arg0, %arg1, %0, %0) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @move_1_byte(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    "llvm.intr.memmove"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @memmove(!llvm.ptr {llvm.returned}, !llvm.ptr {llvm.nocapture, llvm.readonly}, i64) -> !llvm.ptr attributes {passthrough = ["nofree", "nounwind"]}
  llvm.func @libcallmove_1_byte(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.call @memmove(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @__memmove_chk(!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr attributes {passthrough = ["nofree", "nounwind"]}
  llvm.func @libcallmove_1_byte_chk(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.call @__memmove_chk(%arg0, %arg1, %0, %0) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @set_1_byte(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return
  }
  llvm.func @memset(!llvm.ptr, i32, i64) -> !llvm.ptr attributes {passthrough = ["nofree"]}
  llvm.func @libcall_set_1_byte(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @memset(%arg0, %0, %1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @__memset_chk(!llvm.ptr, i32, i64, i64) -> !llvm.ptr attributes {passthrough = ["nofree"]}
  llvm.func @libcall_set_1_byte_chk(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @__memset_chk(%arg0, %0, %1, %1) : (!llvm.ptr, i32, i64, i64) -> !llvm.ptr
    llvm.return
  }
}
