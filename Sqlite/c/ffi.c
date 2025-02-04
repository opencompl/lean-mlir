#include <lean/lean.h>
#include "sqlite3.h"

extern sqlite3 *lean_to_sqlite3(uint64_t ptr) {
  return (sqlite3 *)ptr;
}

extern uint64_t sqlite3_to_lean(sqlite3 *ptr) {
  return (uint64_t)ptr;
}

extern uint32_t my_add(uint32_t a, uint32_t b) {
    return a + b;
}

extern lean_obj_res my_lean_fun() {
    return lean_io_result_mk_ok(lean_box(0));
}

// int sqlite3_open(const char *filename, sqlite3 **ppDb);

// int sqlite3_close(sqlite3*);
void sqlite3_close_ffi(uint64_t ptr) {
  sqlite3_close(lean_to_sqlite3(ptr));
}

// int sqlite3_prepare_v2(sqlite3 *db, const char *zSql, int nByte, sqlite3_stmt **ppStmt, const char **pzTail);
// 
// int sqlite3_bind_text(sqlite3_stmt*, int, const char*, int n, void(*)(void*));
// 
// int sqlite3_bind_int(sqlite3_stmt*, int, int);
// 
// int sqlite3_step(sqlite3_stmt*);
// 
// int sqlite3_finalize(sqlite3_stmt *pStmt);
// 
// int sqlite3_exec(sqlite3*, const char *sql, int (*callback)(void*,int,char**,char**), void *, char **errmsg);
// 
// const char *sqlite3_errmsg(sqlite3*);
// 
// void sqlite3_free(void*);

