#!/usr/bin/env bash

rm "rover-stats.tex" || true
exec &> >(tee -a "rover-stats.tex")

ROVER_NUM_PROBLEMS=$(cat Rover.lean | grep -c '\"name\":')
echo "\\newcommand{\\RoverTotalProblems}{$ROVER_NUM_PROBLEMS}" 
NUM_SOLVED_MULTI_WIDTH=$(cat Rover.lean | grep -c "MULTIWIDTH")
echo "\\newcommand{\\RoverNumSolvedMultiWidth}{$NUM_SOLVED_MULTI_WIDTH}" 
NUM_SOLVED_BMC=$(cat Rover.lean | grep -c "BMC")
echo "\\newcommand{\\RoverNumSolvedBmc}{$NUM_SOLVED_BMC}" 
NUM_INEXPRESSIBLE=$(cat Rover.lean | grep -c "INEXPRESSIBLE")
echo "\\newcommand{\\RoveNumInexpressible}{$NUM_INEXPRESSIBLE}" 
NUM_TODO=$(cat Rover.lean | grep -c "TODO")
echo "\\newcommand{\\RoveNumTodo}{$NUM_TODO}" 
