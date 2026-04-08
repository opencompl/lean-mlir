
define i63 @main(i64 %0) {
  %2 = trunc nuw nsw i64 %0 to i63
  ret i63 %2
}
