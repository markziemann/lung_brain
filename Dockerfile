FROM bioconductor/bioconductor_docker:RELEASE_3_17

# Update apt-get
RUN apt-get update \
        && apt-get upgrade -y \
        && apt-get install -y nano git  libncurses-dev \
        ## Install the python package magic wormhole to send files
        && pip install magic-wormhole           \
        ## Remove packages in '/var/cache/' and 'var/lib'
        ## to remove side-effects of apt-get update
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

# Install CRAN packages
RUN Rscript -e 'install.packages(c("zoo","tidyverse","reshape2","gplots","MASS","eulerr","kableExtra","vioplot","pkgload","beeswarm"))'

# Install bioconductor packages
RUN Rscript -e 'BiocManager::install(c("DESeq2","fgsea","limma","topconfects","mitch"))'

# get a clone of the codes
RUN git clone https://github.com/markziemann/lung_brain.git

# Set the container working directory
ENV DIRPATH /lung_brain
WORKDIR $DIRPATH
