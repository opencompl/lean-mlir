
define i1 @main(i64 %0) {
  %2 = trunc nuw nsw i64 %0 to i1
  ret i1 %2
}
