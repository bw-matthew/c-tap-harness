#!/bin/sh
#
# Test suite for libtap cleanup function functionality.
#
# Written by Russ Allbery <rra@stanford.edu>
# Copyright 2009, 2012, 2013 Russ Allbery <rra@stanford.edu>
# Copyright 2008, 2013
#     The Board of Trustees of the Leland Stanford Junior University
#
# See LICENSE for licensing terms.

. "$SOURCE/tap/libtap.sh"
cd "${BUILD}/libtap/cleanup"

# Run a binary, saving its output, and then compare that output to the
# corresponding *.output file.
ok_test_program () {
    "$BUILD"/libtap/cleanup/"$1" > "$1".result 2>&1
    status=$?
    ok "$1 exit status" [ $status -eq "$2" ]
    diff -u "${SOURCE}/libtap/cleanup/$1".output "$1".result 2>&1
    status=$?
    ok "$1 output" [ $status -eq 0 ]
    if [ $status -eq 0 ] ; then
        rm "$1".result
    fi
}

# Total tests.
plan `expr 7 \* 2`

# Run the individual tests.
ok_test_program c-bail      255
ok_test_program c-fork      0
ok_test_program c-lazy      0
ok_test_program c-many      0
ok_test_program c-many-fail 0
ok_test_program c-one       0
ok_test_program c-one-fail  0
