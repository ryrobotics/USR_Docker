# Using in the docker environment
# Recompile cuTT
git clone https://github.com/ryrobotics/cutt_lts.git /src/cutt_lts
cd /src/cutt_lts
rm ./build/*
make

# Compile GIE Mapping code
mkdir -p /src/GIE_ws/src
mkdir -p /src/GIE_ws/GIE_log
git clone --depth=1 https://github.com/ryrobotics/GIE-mapping.git /src/GIE_ws/src/GIE-mapping

cp /src/cutt_lts/lib/libcutt.a /src/GIE_ws/src/GIE-mapping/lib/libcutt.a
cp /usr/local/cuda-10.2/targets/aarch64-linux/lib/libcudadevrt.a /src/GIE_ws/src/GIE-mapping/lib/libcudadevrt.a

cd /src/GIE_ws
catkin_make
source /src/GIE_ws/devel/setup.bash