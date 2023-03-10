FROM m1mbert/cxlb-gnuradio-3.10:1.2

RUN apt-get update && apt-get install sqlite3
RUN git clone https://github.com/AllisonOge/gr-specsensor.git gr-specsensor.git

# build the OOT library
RUN cd gr-specsensor.git/ && mkdir build && cd build/ && cmake -DCMAKE_INSTALL_PREFIX=/cortexlab/toolchains/current .. && make && make install

# clone parent repo and install requirements
RUN git clone https://github.com/AllisonOge/scs_predictive_analysis.git scs_predictive_analysis.git

RUN cd scs_predictive_analysis.git/ &&  python3 -m pip install --upgrade pip && python3 -m pip install -r requirements.txt
