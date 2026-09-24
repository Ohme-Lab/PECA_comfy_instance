# Installation

## Clone 

Clone this repository inside a folder on your computer:

'''
cd <folder>
git clone --recurse-submodules https://github.com/Ohme-Lab/Kit_AI_PECA_ComfyUI
'''

## Create ComfyUI virtual environment
To create and manage a virtual environment in ComfyUI, we recommend using UV package manager: 

### Install UV
https://docs.astral.sh/uv/getting-started/installation/#standalone-installer

### Create virtual environment and install dependencies
cd <folder>

#### Nvidia GPUs (tested with RTX series)
In a terminal session: 

'''
uv venv --python 3.12
.venv\Scripts\activate
uv pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu130
uv pip install -r ComfyUI/requirements.txt
uv pip install -r ./ComfyUI/manager_requirements.txt  # The manager allows to install and manage custom nodes with ComfyUI
uv pip install pip_requirements.txt
uv pip install git+https://github.com/facebookresearch/sam2
'''

#### AMD RX Vega M GPUs 
The MoyenNUC computer (AMD GPU) is not directly supported by ComfyUI.
Our friend Claude recommends using the ROCm approach, that is, using Windows' DirectML backend. This will be slower than directly using the GPU, but making it possible to use ComfyUI with this PC configuration. 

We recommend using Python 3.12, since some libs are not available with DirectML with Python 3.13.

''' 
uv venv --python 3.13
.venv\Scripts\activate
uv pip install torch-directml --> ROCm GPUs (RX Vega M)
uv pip install -U --pre comfyui-manage
uv pip install torchaudio
uv pip install -r ComfyUI/requirements.txt
uv pip install -r ./ComfyUI/manager_requirements.txt
uv pip install pip_requirements.txt
uv pip install git+https://github.com/facebookresearch/sam2
'''

## Start ComfyUI

### Nvidia RTX
From the repository folder, execute in the terminal: 
''' 
python ./ComfyUI/main.py --enable-manager
''' 

### AMD ROCm 
The command line is the same, except that ComfyUI must be instructed to use the DirectML backend (a bit slower):

''' 
python ./ComfyUI/main.py --enable-manager --directml
''' 

## Add new workflow files to ComfyUI (optional)
The current repository saves the workflow files that can be used in ComfyUI. 
