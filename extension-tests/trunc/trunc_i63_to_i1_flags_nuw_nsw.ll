
define i1 @main(i63 %0) {
  %2 = trunc nuw nsw i63 %0 to i1
  ret i1 %2
}
