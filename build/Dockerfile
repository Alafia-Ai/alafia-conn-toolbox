FROM mathworks/matlab:r2022a

COPY libmwlmgrimpl.so /opt/matlab/R2022a/bin/glnxa64/matlab_startup_plugins/lmgrimpl/libmwlmgrimpl.so
COPY license.lic      /licenses/license.lic
COPY pathdef.m        /opt/matlab/R2022a/toolbox/local/pathdef.m

WORKDIR /software

COPY *.zip .

ENV MLM_LICENSE_FILE=/licenses/license.lic

RUN unzip conn22a.zip && \
    unzip spm12.zip  && \
    rm -rf  conn22a.zip spm12.zip

