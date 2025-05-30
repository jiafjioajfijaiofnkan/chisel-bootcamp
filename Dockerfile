# 第一阶段：设置系统和环境
FROM ubuntu:20.04 as base

RUN \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        ca-certificates-java \
        curl \
        graphviz \
        openjdk-8-jre-headless \
        python3-distutils \
        && \
    rm -rf /var/lib/apt/lists/*

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py
RUN pip3 install notebook

RUN useradd -ms /bin/bash bootcamp

ENV SCALA_VERSION=2.12.10
ENV ALMOND_VERSION=0.9.1

ENV COURSIER_CACHE=/coursier_cache

ADD . /chisel-bootcamp/
WORKDIR /chisel-bootcamp

ENV JUPYTER_CONFIG_DIR=/jupyter/config
ENV JUPITER_DATA_DIR=/jupyter/data

RUN mkdir -p $JUPYTER_CONFIG_DIR/custom
RUN cp source/custom.js $JUPYTER_CONFIG_DIR/custom/

# 第二阶段 - 下载 Scala 依赖和 Scala 内核
FROM base as intermediate-builder

RUN mkdir /coursier_cache

RUN \
    curl -L -o coursier https://git.io/coursier-cli && \
    chmod +x coursier && \
    ./coursier \
        bootstrap \
        -r jitpack \
        sh.almond:scala-kernel_$SCALA_VERSION:$ALMOND_VERSION \
        --sources \
        --default=true \
        -o almond && \
    ./almond --install --global && \
    \rm -rf almond couriser /root/.cache/coursier 

# 执行一个 notebook 以确保 Chisel 被下载到镜像中以供离线工作
RUN jupyter nbconvert --to notebook --output=/tmp/0_demo --execute 0_demo.ipynb

# 最后阶段
FROM base as final

# 将 Scala 依赖和内核复制到镜像中
COPY --from=intermediate-builder /coursier_cache/ /coursier_cache/
COPY --from=intermediate-builder /usr/local/share/jupyter/kernels/scala/ /usr/local/share/jupyter/kernels/scala/

RUN chown -R bootcamp:bootcamp /chisel-bootcamp

USER bootcamp
WORKDIR /chisel-bootcamp

EXPOSE 8888
CMD jupyter notebook --no-browser --ip 0.0.0.0 --port 8888
