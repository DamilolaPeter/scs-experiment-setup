FROM debian:bullseye

ENV APT="apt-get -y"

# pinning
RUN echo "deb http://ftp.debian.org/debian/ bookworm main non-free contrib" >> /etc/apt/sources.list
RUN echo "Package: *\nPin: release a=bullseye\nPin-Priority: 700\n\nPackage: *\nPin: release a=stable\nPin-Priority: 700\n\nPackage: *\nPin: release a=bookworm\nPin-Priority: -1\n\nPackage: *\nPin: release a=testing\nPin-Priority: -1" > /etc/apt/preferences.d/pinning

RUN ${APT} update && ${APT} dist-upgrade

# cxlb-build-toolchain.git
RUN ${APT} install git
RUN git clone https://github.com/CorteXlab/cxlb-build-toolchain.git cxlb-build-toolchain.git

# build toolchain (separate build steps to benefit from docker cache in case of build issues on a specific module)
ENV BUILD="cxlb-build-toolchain.git/cxlb-build-toolchain -y /usr/bin/python3 -as"
ENV PARMS="cxlb_toolchain_build /cortexlab/toolchains/current"
RUN ${APT} install udev
RUN ${BUILD} uhd=master ${PARMS}
RUN ${BUILD} uhd-firmware ${PARMS}
RUN ${BUILD} volk=main ${PARMS}
RUN ${APT} install python3-pygccxml/bookworm
RUN ${BUILD} gnuradio=maint-3.10 ${PARMS}
RUN ${APT} -t bookworm install nodejs
RUN ${BUILD} gr-bokehgui=master ${PARMS}
RUN ${BUILD} gr-iqbal=master ${PARMS}

# activate toolchain configuration
# RUN /cortexlab/toolchains/current/bin/cxlb-toolchain-system-conf
# RUN echo source /cortexlab/toolchains/current/bin/cxlb-toolchain-user-conf >> /etc/profile
RUN ln -s /cortexlab/toolchains/current/bin/cxlb-toolchain-user-conf /etc/profile.d/cxlb-toolchain-user-conf.sh
# RUN sysctl -w net.core.wmem_max=2500000

# build the OOT library
RUN git clone https://github.com/AllisonOge/gr-specsensor.git gr-specsensor.git
RUN cd gr-specsensor.git/ && mkdir build && cd build/ && cmake -DCMAKE_INSTALL_PREFIX=/cortexlab/toolchains/current .. && make && make install

# install deps
RUN ${APT} install sqlite3

# install pip requirements
RUN python3 -m pip install --upgrade pip && python3 -m pip install -r requirements.txt