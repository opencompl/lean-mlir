
define i24 @main(i63 %0) {
  %2 = trunc nuw nsw i63 %0 to i24
  ret i24 %2
}
