
define i42 @main(i63 %0) {
  %2 = trunc nuw nsw i63 %0 to i42
  ret i42 %2
}
