# Kit AI PECA — ComfyUI


## Start ComfyUI

Double-click `start.bat`, or run it from a terminal. It:

- uses the project's `.venv`, no need to activate it;
- sets `--base-directory` to the repository, so `data/models/`, `data/custom_nodes/`, `data/input/`, `data/output/`, `data/temp/` and `data/user/` are read from here and not from inside `ComfyUI/`;
- loads `../shared_models/extra_model_paths.yaml` to add the shared models;
- points the Hugging Face cache to `../shared_models/huggingface`;
- enables the Manager (`--enable-manager`) to install custom nodes;
- listens on `0.0.0.0:8172` 

**AMD / DirectML:** add `--directml` to the command in `start.bat`.

Go to http://grosnuc.local:8172 from local or another device in the LAN. 

## Structure

```
Projets_comfy/
├── shared_models/                  # models shared by all Comfy projects (not in git)
│   ├── extra_model_paths.yaml      # tells ComfyUI where to find them
│   ├── huggingface/                # Hugging Face cache used by custom nodes
│   ├── checkpoints/  loras/  vae/  controlnet/  ...
│
└── Kit_AI_PECA_ComfyUI/            # this repository
    ├── start.bat                   # launches ComfyUI with the right paths
    ├── extra_model_paths.shared.yaml   # template for shared_models/extra_model_paths.yaml
    ├── pip_requirements.txt
    ├── ComfyUI/                    # ComfyUI clone (not in git, see below)
    ├── .venv/                      # Python environment (not in git)
    ├── data
        ├── input/  
        ├── output/  
        ├── temp/  
        ├── models/                     # project specific models
        ├── custom_nodes/               
        ├── user/default/workflows/     # workflow files 
```

- **This repository** holds only what is specific to the project: launch script, config, workflows.
- **`shared_models/`** holds the heavy, generic models (checkpoints, VAE, text encoders, ControlNet…), downloaded once and reused by every project. It sits **next to** the repository folder.
- **Project-specific models** (e.g. the project's LoRAs) go in `models/` inside the repository. They are listed before the shared ones.

## Installation

### 1. Clone this repository

```
cd <Projets_comfy>
git clone https://github.com/Ohme-Lab/Kit_AI_PECA_ComfyUI
cd Kit_AI_PECA_ComfyUI
```

### 2. Clone ComfyUI (pinned version)

ComfyUI is not committed. Clone it inside the repository and check out the version this kit was tested with:

```
git clone https://github.com/Comfy-Org/ComfyUI
cd ComfyUI
git checkout vX.Y.Z
cd ..
```

### 3. Set up the shared models folder (once per computer)

```
mkdir ..\shared_models
copy extra_model_paths.shared.yaml ..\shared_models\extra_model_paths.yaml
robocopy ComfyUI\models ..\shared_models /E /XF *
```

The last line creates the standard model subfolders (empty). Put the model files in the matching subfolder.

### 4. Create the virtual environment

Install UV: https://docs.astral.sh/uv/getting-started/installation/#standalone-installer

Use **Python 3.12** in both cases below (some DirectML libraries are not available for 3.13).

#### Nvidia GPUs (tested with RTX series)

```
uv venv --python 3.12
.venv\Scripts\activate
uv pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu130
uv pip install -r ComfyUI/requirements.txt
uv pip install -r ComfyUI/manager_requirements.txt
uv pip install -r pip_requirements.txt
uv pip install git+https://github.com/facebookresearch/sam2
```

#### AMD RX Vega M GPUs (MoyenNUC)

This GPU is not directly supported by ComfyUI. We use **DirectML** (Windows' DirectX 12 backend): slower than native GPU support, but it works.

```
uv venv --python 3.12
.venv\Scripts\activate
uv pip install torch-directml torchaudio
uv pip install -r ComfyUI/requirements.txt
uv pip install -r ComfyUI/manager_requirements.txt
uv pip install -r pip_requirements.txt
uv pip install git+https://github.com/facebookresearch/sam2
```

## Workflows

Workflow files are saved in `user/default/workflows/` and committed with the repository. Save a workflow from the ComfyUI interface, then commit it.