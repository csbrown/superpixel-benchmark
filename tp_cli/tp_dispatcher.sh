#!/bin/sh
# Copyright (c) 2016, David Stutz
# Contact: david.stutz@rwth-aachen.de, davidstutz.de
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
# 
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 
# 3. Neither the name of the copyright holder nor the names of its contributors
#    may be used to endorse or promote products derived from this software
#    without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Usage:
# $ ../tp_cli/tp_dispatcher.sh -h
# Allowed options:
# -i folder to process
# -s number of superpixels
# -m time step to use, see paper
# -g sigma parameter, see paper
# -t maximum number of iterations
# -o output folder
# -v folder for visualizatioN
# -x prefix of output files
# -w verbose output
# -e path to MatLab executable
# -a path to add, usually the lib_seaw path

DEBUG=1
INPUT=""
SUPERPIXELS=400
TIME_STEP=0.5
MAX_ITERATIONS=500
SIGMA_FACTOR=2.5
VIS=""
PREFIX=""
WORDY=0
OUTPUT=""
MATLAB="matlab"
ADDPATH=""
while getopts ":i:s:m:t:g:o:v:x:we:a:h" opt; do
    case $opt in
        i)
            INPUT=$OPTARG
            if [ $DEBUG -gt 0 ] ; then
                echo "Input (-i) set to: $OPTARG"
            fi
            ;;
        s)
            SUPERPIXELS=$OPTARG
            if [ $DEBUG -gt 0 ] ; then
                echo "Superpixels (-s) set to: $OPTARG"
            fi
            ;;
        m)
            TIME_STEP=$OPTARG
            if [ $DEBUG -gt 0 ] ; then
                echo "Time step (-m) set to: $OPTARG"
            fi
            ;;
        g)
            SIGMA_FACTOR=$OPTARG
            if [ $DEBUG -gt 0 ] ; then
                echo "Sigma factor (-g) set to: $OPTARG"
            fi
            ;;
        t)
            MAX_ITERATIONS=$OPTARG
            if [ $DEBUG -gt 0 ] ; then
                echo "Max iterations (-t) set to: $OPTARG"
            fi
            ;;
        o)
            OUTPUT=$OPTARG
            if [ $DEBUG -gt 0 ] ; then
                echo "Output (-o) set to: $OPTARG"
            fi
            ;;
        v)
            VIS=$OPTARG
            if [ $DEBUG -gt 0 ] ; then
                echo "Vis (-v) set to: $OPTARG"
            fi
            ;;
        x)
            PREFIX=$OPTARG
            if [ $DEBUG -gt 0 ] ; then
                echo "Prefix (-v) set to: $OPTARG"
            fi
            ;;
        w)
            WORDY=1
            if [ $DEBUG -gt 0 ] ; then
                echo "Wordy (-w) set to: 1"
            fi
            ;;
        e)
            MATLAB=$OPTARG
            if [ $DEBUG -gt 0 ] ; then
                echo "MatLab executable (-e) set to: $OPTARG"
            fi
            ;;
        a)
            ADDPATH=$OPTARG
            if [ $DEBUG -gt 0 ] ; then
                echo "Add path (-a) set to: $OPTARG"
            fi
            ;;
        h)
            echo "Allowed options:"
            echo "-i folder to process"
            echo "-s number of superpixels"
            echo "-m time step to use, see paper"
            echo "-g sigma parameter, see paper"
            echo "-t maximum number of iterations"
            echo "-o output folder"
            echo "-v folder for visualizatioN"
            echo "-x prefix of output files"
            echo "-w verbose output"
            echo "-e path to MatLab executable"
            echo "-a path to add, usually the lib_seaw path"
            exit
            ;;
        \?)
            if [ $DEBUG -gt 0 ] ; then
                echo "Invalid option: -$OPTARG."
            fi
            exit 1
            ;;
        :)
            if [ $DEBUG -gt 0 ] ; then
                echo "Invalid option: -$OPTARG."
            fi
            exit 1
            ;;
    esac
done

if [ -z $INPUT ] ; then
    "Use -i to provide the input directory."
    exit 1
fi

if [ -z $MATLAB ] ; then
    "Use -e to provide the path to the MatLab executable."
    exit 1
fi

if [ $DEBUG -gt 0 ] ; then
    echo "Executing: $MATLAB -nodisplay -nojvm -r addpath '$ADDPATH';debug=$DEBUG;folder='$INPUT';superpixels=$SUPERPIXELS;time_step=$TIME_STEP;max_iterations=$MAX_ITERATIONS;sigma_factor=$SIGMA_FACTOR;csv_folder='$OUTPUT';vis_folder='$VIS';prefix='$PREFIX';wordy=$WORDY;tp_dispatcher;exit;"
fi

if [ -z $ADDPATH ] ; then
    $MATLAB -nodisplay -nojvm -r "debug=$DEBUG;folder='$INPUT';superpixels=$SUPERPIXELS;time_step=$TIME_STEP;max_iterations=$MAX_ITERATIONS;sigma_factor=$SIGMA_FACTOR;csv_folder='$OUTPUT';vis_folder='$VIS';prefix='$PREFIX';wordy=$WORDY;tp_dispatcher;exit;"
else
    $MATLAB -nodisplay -nojvm -r "addpath '$ADDPATH';debug=$DEBUG;folder='$INPUT';superpixels=$SUPERPIXELS;time_step=$TIME_STEP;max_iterations=$MAX_ITERATIONS;sigma_factor=$SIGMA_FACTOR;csv_folder='$OUTPUT';vis_folder='$VIS';prefix='$PREFIX';wordy=$WORDY;tp_dispatcher;exit;"
fi
