// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/01/Not.tst

load Demultiplexor4way.hdl,
output-file Demultiplexor4way.out,
compare-to Demultiplexor4way.cmp,
output-list in%B3.1.3 s1%B3.1.3 s2%B3.1.3 a%B3.1.3 b%B3.1.3 c%B3.1.3 d%B3.1.3;

set in 0,
set s1 0,
set s2 0,
eval,
output;

set in 0,
set s1 0,
set s2 1,
eval,
output;

set in 0,
set s1 1,
set s2 0,
eval,
output;

set in 0,
set s1 1,
set s2 1,
eval,
output;

set in 1,
set s1 0,
set s2 0,
eval,
output;

set in 1,
set s1 0,
set s2 1,
eval,
output;

set in 1,
set s1 1,
set s2 0,
eval,
output;

set in 1,
set s1 1,
set s2 1,
eval,
output;