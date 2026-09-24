@echo off
cd /d "%~dp0"
set HF_HOME=%~dp0..\shared_models\huggingface
 
.venv\Scripts\python.exe ComfyUI\main.py ^
    --base-directory .\data ^
    --extra-model-paths-config ..\..\shared_models\extra_model_paths.yaml ^
    --enable-manager ^
    --listen 0.0.0.0 ^
    --port 8172 ^
    --disable-auto-launch
 
pause
