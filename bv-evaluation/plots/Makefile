.PHONY: lint


all : 
	python3 plot.py all

lint:
	ruff format *.py
	ruff check *.py

instcombine : 
	python3 plot.py instcombine

hackersdelight : 
	python3 plot.py hackersdelight

smtlib : 
	python3 plot.py smtlib


clean: 
	rm *.pdf
