#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "int", sizeInBits = 32, encoding = DW_ATE_signed>
#di_file = #llvm.di_file<"-" in "/">
#di_file1 = #llvm.di_file<"<stdin>" in "/">
#di_null_type = #llvm.di_null_type
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C99, file = #di_file, isOptimized = false, emissionKind = Full>
#di_subroutine_type = #llvm.di_subroutine_type<types = #di_null_type, #di_basic_type>
#di_subprogram = #llvm.di_subprogram<id = distinct[1]<>, compileUnit = #di_compile_unit, scope = #di_file1, name = "t1", file = #di_file1, line = 1, scopeLine = 1, subprogramFlags = Definition, type = #di_subroutine_type>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "a", file = #di_file1, line = 1, arg = 1, type = #di_basic_type>
#di_local_variable1 = #llvm.di_local_variable<scope = #di_subprogram, name = "fake_ptr", file = #di_file1, line = 1, type = #di_basic_type>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t1(%arg0: i32) {
    llvm.intr.dbg.value #di_local_variable = %arg0 : i32
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.dbg.value #di_local_variable1 = %1 : !llvm.ptr
    llvm.intr.dbg.value #di_local_variable #llvm.di_expression<[DW_OP_deref]> = %1 : !llvm.ptr
    llvm.store %arg0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
