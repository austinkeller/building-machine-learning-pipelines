FROM jupyter/scipy-notebook:feacdbfc2e89

# name your environment and choose python 3.x version
ARG conda_env=python36
ARG py_ver=3.6

# you can add additional libraries you want conda to install by listing them below the first line and ending with "&& \"
RUN conda create \
      --quiet \
      --yes \
      -p $CONDA_DIR/envs/$conda_env \
      python=$py_ver \
      ipython \
      ipykernel \
      && conda clean --all -f -y

# create Python 3.x environment and link it to jupyter
RUN $CONDA_DIR/envs/${conda_env}/bin/python -m ipykernel install --user --name=${conda_env} && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# any additional pip installs can be added by uncommenting the following line
RUN $CONDA_DIR/envs/${conda_env}/bin/pip install --upgrade pip
RUN $CONDA_DIR/envs/${conda_env}/bin/pip install --upgrade --use-feature=2020-resolver \
      apache-beam[interactive,gcp,aws] \
      tfx \
      tensorflow_hub \
      tensorflow_privacy \
      tensorboard_plugin_fairness_indicators \
      witwidget

# prepend conda environment to path
ENV PATH $CONDA_DIR/envs/${conda_env}/bin:$PATH

# if you want this environment to be the default one, uncomment the following line:
ENV CONDA_DEFAULT_ENV ${conda_env}
