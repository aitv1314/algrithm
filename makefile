###################################################################################################
# 编译工具链设置
PATH := ${PATH}:
TOOL_CHAIN = 
CC = ${TOOL_CHAIN}g++
AR = ${TOOL_CHAIN}ar

DEBUG_BUILD ?= yes

# SHOW_COMMAND=yes，显示编译命令
ifeq (${SHOW_COMMAND}, yes)
QUIET :=
else
QUIET := @
endif

###################################################################################################
# 目录设置
# 工程根路径
PROJ_ROOT = $(abspath .)
# 中间文件缓存文件夹
TMP_PATH = $(abspath .)/tmp

# 当前路径
PWD_PATH = $(abspath .)

###################################################################################################
# 源文件.c
SRC := ${PROJ_ROOT}/*.cpp
# 展开*匹配，获取所有源文件完整路径
SRC := $(wildcard ${SRC})

###################################################################################################
# 头文件路径设置
# INCLUDE_PATH += /include/path1
INCLUDE_PATH += ${PROJ_ROOT}/


###################################################################################################
# 编译宏设定
DEFINE_SETTINGS := LINUX
DEFINE_SETTINGS += A72="A72"
DEFINE_SETTINGS += TARGET_NUM_CORES=16
DEFINE_SETTINGS += TARGET_ARCH=64
DEFINE_SETTINGS += X86_64
DEFINE_SETTINGS += X86

###################################################################################################
# 库路径设置
# 静态库.a文件夹路径
# STATIC_LIB_PATH := ${PROJ_ROOT}/moduleXXX1/lib
# STATIC_LIB_PATH += ${PROJ_ROOT}/moduleXXX2/lib
# 动态库.so文件夹路径
# DYNAMIC_LIB_PATH := ${PROJ_ROOT}/moduleXXX3/lib

###################################################################################################
# 库设置(静态库)
# STATIC_LIB += static_lib1
# STATIC_LIB += static_lib2
# STATIC_LIB += static_lib3
# STATIC_LIB += static_lib4
# 库设置(动态库)
DYNAMIC_LIB := stdc++
DYNAMIC_LIB += m
DYNAMIC_LIB += rt
DYNAMIC_LIB += pthread

###################################################################################################
# 编译选项
CFLAGS := -fPIC -Wall -fms-extensions -Wno-write-strings -Wno-format-security
CFLAGS += -fno-short-enums -Werror
# CFLAGS += -mlittle-endian  -Wno-format-truncation
CFLAGS += -Wno-format-truncation
ifeq ("${DEBUG_BUILD}","yes")
CFLAGS += -ggdb -ggdb3 -gdwarf-2 -D_DEBUG_=1 -g
else
CFLAGS += -O3 -DNDEBUG
endif

###################################################################################################
# 生成的中间文件.o
OBJ := $(patsubst ${PROJ_ROOT}/%.cpp,${TMP_PATH}/%.o,${SRC})
# 头文件存放路径设置
INC := $(foreach path,${INCLUDE_PATH},-I${path})
# 编译宏设置
DEF := $(foreach macro,${DEFINE_SETTINGS},-D${macro})
# 库设置
LIB := -rdynamic -Wl,--cref
LIB += $(foreach path,${DYNAMIC_LIB_PATH},"-Wl,-rpath-link=${path}")
LIB += $(foreach path,${STATIC_LIB_PATH},-L${path})
LIB += -Wl,-Bstatic -Wl,--start-group
LIB += $(foreach lib,${STATIC_LIB},-l${lib})
LIB += -Wl,--end-group
LIB += -Wl,-Bdynamic
LIB += $(foreach lib,${DYNAMIC_LIB},-l${lib})

# 生成目标
TARGET := ${PWD_PATH}/main
# 生成目标中的详细符号信息文件
DEP_FILE := -Wl,-Map=${TMP_PATH}/$(notdir ${TARGET}).dep

.PHONY: all clean
all: ${TARGET}

${TARGET}:${OBJ}
	@echo "[Linking $@]"
	${QUIET}${CC} ${OBJ} ${CFLAGS} ${LIB} -o $@ ${DEP_FILE} >/dev/null

${TMP_PATH}/%.o:${PROJ_ROOT}/%.cpp
	@echo "[Compiling $@]"
	@mkdir $(dir $@) -p
	${QUIET}${CC} -c $< -o $@ ${CFLAGS} ${DEF} ${INC} -MMD -MF $(patsubst %.o,%.dep,$@) -MT '$@'

clean:
	@echo "[cleaning ${TARGET}]"
	${QUIET}rm -rf ${TARGET}
	${QUIET}rm -rf ${TMP_PATH}