FROM mathworks/matlab:r2022a

WORKDIR /software

COPY . .

RUN mv ./libmwlmgrimpl.so /opt/matlab/R2022a/bin/glnxa64/matlab_startup_plugins/lmgrimpl/libmwlmgrimpl.so && \
    mv ./license.lic /licenses/license.lic && \
    mv ./pathdef.m /opt/matlab/R2022a/toolbox/local/pathdef.m

ENV MLM_LICENSE_FILE=/licenses/license.lic

RUN unzip conn22a.zip && \
    unzip spm12.zip  && \
    rm -rf  conn22a.zip spm12.zip

# Start MATLAB in batch mode and execute your script/function.
#CMD ["matlab","-batch", "rand"]

