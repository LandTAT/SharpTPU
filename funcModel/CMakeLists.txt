# CMake 最低版本号要求
cmake_minimum_required(VERSION 3.8) # C++17 需要至少 CMake 3.8

# 项目信息
project(simFP)

# 查找当前目录下的所有源文件
# 并将名称保存到 DIR_SRCS 变量
aux_source_directory(. DIR_SRCS)

# 设置 C++ 标准为 C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# include_directories(../HLS_arbitrary_Precision_Types/include)

# 指定生成目标
add_executable(${PROJECT_NAME} ${DIR_SRCS})
