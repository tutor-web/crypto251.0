#!/bin/sh
set -eu

for lec in lec00100 lec00200 lec00300 lec00400 lec00500 lec01200 lec01400 lec01500 lec01600 lec02000 lec02100 lec02200 lec03000 lec03100 lec03200 lec03400 lec03500 lec04000 lec04500 lec15000 lec15500 lec26000 lec30000 lec30100 lec31000 lec47000 lec47100; do
    curl http://ui-tutorweb.clifford.shuttlethread.com/comp/crypto251.0/${lec}/rst > ${lec}.rst
done
