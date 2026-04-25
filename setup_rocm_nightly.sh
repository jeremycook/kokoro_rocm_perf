python3.12 -m venv rocm_nightly.venv
source rocm_nightly.venv/bin/activate

pip install --pre torch --index-url https://download.pytorch.org/whl/nightly/rocm7.2
pip install loguru misaki[en] numpy transformers soundfile
