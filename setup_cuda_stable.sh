python3.12 -m venv cuda_stable.venv
source cuda_stable.venv/bin/activate

pip3 install torch
pip install loguru misaki[en] numpy transformers soundfile
