
define i25 @main(i64 %0) {
  %2 = trunc nuw nsw i64 %0 to i25
  ret i25 %2
}
