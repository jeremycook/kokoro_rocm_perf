python3.12 -m venv cpu.venv
source cpu.venv/bin/activate

pip3 install torch torchvision --index-url https://download.pytorch.org/whl/cpu
pip install loguru misaki[en] numpy transformers soundfile
