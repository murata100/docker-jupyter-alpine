FROM python:3.6-alpine3.10

RUN apk update && apk --no-cache add \
    alpine-sdk linux-headers zeromq-dev pkgconfig py3-zmq curl git freetype-dev && \
    pip install --upgrade pip && pip install \
    pyzmq ipython ipykernel pyreadline jupyter \
    requests pandas pytablewriter && \
    pip install --upgrade cython && \
    pip install matplotlib japanize_matplotlib

# Support UTF-8 filename in Python (https://stackoverflow.com/a/31754469)
ENV LC_CTYPE=C.UTF-8

RUN mkdir -p $HOME/.jupyter/custom && \
    echo '.CodeMirror pre, .output pre {font-family: "Noto Sans Mono CJK JP", "Menlo", "DejaVu Sans Mono", "Liberation Mono", "Consolas", "Ubuntu Mono", "Courier New", "andale mono", "lucida console", monospace;}' >> $HOME/.jupyter/custom/custom.css

CMD jupyter notebook --ip=0.0.0.0 --allow-root --NotebookApp.token= --NotebookApp.password=
