module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "big">>} {
  llvm.mlir.global internal @"\01L_OBJC_METH_VAR_NAME_112"("whiteComponent\00") {addr_space = 0 : i32, dso_local, section = "__TEXT,__cstring,cstring_literals"}
  llvm.mlir.global internal @"\01L_OBJC_SELECTOR_REFERENCES_81"() {addr_space = 0 : i32, dso_local, section = "__OBJC,__message_refs,literal_pointers,no_dead_strip"} : !llvm.ptr {
    %0 = llvm.mlir.constant("whiteComponent\00") : !llvm.array<15 x i8>
    %1 = llvm.mlir.addressof @"\01L_OBJC_METH_VAR_NAME_112" : !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @bork() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant("whiteComponent\00") : !llvm.array<15 x i8>
    %2 = llvm.mlir.addressof @"\01L_OBJC_METH_VAR_NAME_112" : !llvm.ptr
    %3 = llvm.mlir.addressof @"\01L_OBJC_SELECTOR_REFERENCES_81" : !llvm.ptr
    %4 = llvm.mlir.addressof @objc_msgSend_fpret : !llvm.ptr
    %5 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %7, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %8 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %10 = llvm.call %4(%9, %8) : !llvm.ptr, (!llvm.ptr, !llvm.ptr) -> f32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @objc_msgSend_fpret(!llvm.ptr, ...)
}
