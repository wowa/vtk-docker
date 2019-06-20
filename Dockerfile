FROM ubuntu:18.04

## SETTING PATHS annd ENVIRONMENT VARIABLES
ENV PATH ${PATH}:/usr/bin:/bin:/usr/sbin:/sbin
ENV DEBIAN_FRONTEND noninteractive
## INSTALL DEPENDENCIES
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y \
     build-essential \
     cmake \
     cmake-curses-gui git \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /root/
RUN git clone --depth 1 --single-branch --branch v7.1.1 https://gitlab.kitware.com/vtk/vtk.git

RUN mkdir /root/vtk-build/ && cd /root/vtk-build/ && cmake -DBUILD_EXAMPLES:BOOL=OFF \
-DBUILD_SHARED_LIBS:BOOL=OFF \
-DBUILD_TESTING:BOOL=OFF \
#-DCMAKE_INSTALL_PREFIX:PATH=/vtk-install/ \
-DVTK_Group_StandAlone:BOOL=ON \
-DVTK_Group_Rendering:BOOL=OFF \
-DVTK_Group_Imaging:BOOL=OFF \
-DVTK_Group_MPI:BOOL=OFF \
-DVTK_Group_Qt:BOOL=OFF \
-DVTK_Group_Tk:BOOL=OFF \
-DVTK_Group_Views:BOOL=OFF \
-DVTK_Group_Web:BOOL=OFF \
-DVTK_USER_CXX11_FEATURES:BOOL=ON \
-DVTK_WRAP_JAVA:BOOL=OFF \
-DVTK_WRAP_PYTHON:BOOL=OFF \
-DVTK_WRAP_TCL:BOOL=OFF \
-DVTK_RENDERING_BACKEND:STRING=None \
/root/vtk/ && \
make && \
make install



