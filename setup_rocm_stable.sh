python3.12 -m venv rocm_stable.venv
source rocm_stable.venv/bin/activate

pip3 install torch --index-url https://download.pytorch.org/whl/rocm7.2
pip install loguru misaki[en] numpy transformers soundfile
