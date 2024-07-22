#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "int", sizeInBits = 32, encoding = DW_ATE_signed>
#di_file = #llvm.di_file<"test.cpp" in "">
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C_plus_plus_14, file = #di_file, producer = "clang version 18.0.0", isOptimized = false, emissionKind = Full>
#di_subroutine_type = #llvm.di_subroutine_type<types = #di_basic_type>
#di_global_variable = #llvm.di_global_variable<scope = #di_compile_unit, name = "One", linkageName = "One", file = #di_file, line = 1, type = #di_basic_type, isDefined = true>
#di_global_variable1 = #llvm.di_global_variable<scope = #di_compile_unit, name = "Two", linkageName = "Two", file = #di_file, line = 2, type = #di_basic_type, isDefined = true>
#di_subprogram = #llvm.di_subprogram<id = distinct[1]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "test", linkageName = "?test@@YAHXZ", file = #di_file, line = 3, scopeLine = 3, subprogramFlags = Definition, type = #di_subroutine_type>
#di_global_variable_expression = #llvm.di_global_variable_expression<var = #di_global_variable, expr = <>>
#di_global_variable_expression1 = #llvm.di_global_variable_expression<var = #di_global_variable1, expr = <>>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "Three", file = #di_file, line = 4, type = #di_basic_type>
#di_local_variable1 = #llvm.di_local_variable<scope = #di_subprogram, name = "Four", file = #di_file, line = 5, type = #di_basic_type>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @"?One@@3HA"(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64, dbg_expr = #di_global_variable_expression, dso_local} : i32
  llvm.mlir.global external @"?Two@@3HA"(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64, dbg_expr = #di_global_variable_expression1, dso_local} : i32
  llvm.func @"?test@@YAHXZ"() -> (i32 {llvm.noundef}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.intr.dbg.value #di_local_variable = %0 : i32
    %1 = llvm.mlir.addressof @"?Two@@3HA" : !llvm.ptr
    %2 = llvm.mlir.addressof @"?One@@3HA" : !llvm.ptr
    %3 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.dbg.value #di_local_variable = %3 : i32
    %4 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.intr.dbg.value #di_local_variable = %4 : i32
    llvm.intr.dbg.value #di_local_variable1 = %4 : i32
    %5 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.switch %5 : i32, ^bb3(%0 : i32) [
      0: ^bb1,
      2: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%4 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%3 : i32)
  ^bb3(%6: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.intr.dbg.value #di_local_variable = %6 : i32
    llvm.return %6 : i32
  }
}
