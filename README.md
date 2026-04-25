Minimal example for comparing the performance of ROCM with CPU

```sh
# Using Python 3.12 because I couldn't get misaki to install on 3.13+
sudo dnf install python3.12

# Setup and then run at least twice to account for the need to download files

bash setup_cpu.sh
source cpu.venv/bin/activate
time python run.py
time python run.py
deactivate

bash setup_rocm_nightly.sh
source rocm_nightly.venv/bin/activate
time python run.py
time python run.py
deactivate

bash setup_rocm_stable.sh
source rocm_stable.venv/bin/activate
time python run.py
time python run.py
deactivate
```

My 2nd run.py times on AMD Radeon AI Pro R9700 and AMD Ryzen 7 5700G with iGPU disabled in BIOS

```
cpu.venv
real    0m12.148s
user    0m38.368s
sys     0m9.426s

rocm_nightly.venv
real    0m21.597s
user    0m23.808s
sys     0m13.301s

rocm_stable.venv
real    0m20.754s
user    0m20.923s
sys     0m3.742s
```

I get these warnings in the ROCM environments:

```
MIOpen(HIP): Warning [IsEnoughWorkspace] [GetSolutionsFallback WTI] Solver <GemmFwdRest>, workspace required: 156304896, provided ptr: 0 size: 0
MIOpen(HIP): Warning [IsEnoughWorkspace] [EvaluateInvokers] Solver <GemmFwdRest>, workspace required: 156304896, provided ptr: 0 size: 0
```

MIOpen and hipBLASLt logging

```sh
export MIOPEN_ENABLE_LOGGING=1
export MIOPEN_ENABLE_LOGGING_CMD=1
export HIPBLASLT_LOG_MASK=32
export HIPBLASLT_LOG_FILE="kokoro_tts_hipblaslt_log.txt"
export TORCH_BLAS_PREFER_HIPBLASLT=1
sort kokoro_tts_hipblaslt_log.txt | uniq -c | sort -nr > kokoro_tts_sorted_hipblaslt_log.txt
```
