# Build from the MATLAB base image
FROM mathworks/matlab:r2022a

WORKDIR /software

# See https://stackoverflow.com/questions/49435109/error-upon-jar-execution-unable-to-allocate-file-descriptor-table
RUN ulimit -n 10000

# Copy license and CONN to image.
COPY ./conn22a.zip /software/conn22a.zip
COPY ./spm12.zip /software/spm12.zip

# License for testing purposes only
COPY ./libmwlmgrimpl.so /opt/matlab/R2022a/bin/glnxa64/matlab_startup_plugins/lmgrimpl/libmwlmgrimpl.so
COPY ./license.lic /licenses/license.lic

# Replace the default path
COPY ./pathdef.m /opt/matlab/R2022a/toolbox/local/pathdef.m

# Set location of license file
ENV MLM_LICENSE_FILE=/licenses/license.lic

RUN unzip conn22a.zip && unzip spm12.zip

# Start MATLAB in batch mode and execute your script/function.
CMD ["matlab","-batch", "rand"]

